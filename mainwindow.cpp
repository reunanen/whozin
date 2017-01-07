#include "mainwindow.h"
#include "ui_mainwindow.h"

#include "mytreewidgetitem.h"

#include <numcfc/Time.h>
#include <numcfc/Logger.h>

#include <QSettings>
#include <QTimer>
#include <QTreeWidget>
#include <QPainter>
#include <assert.h>

namespace {
    const char* companyName = "Tomaattinen";
    const char* applicationName = "whozin";

    const int maxInactivitySeconds = 60;
    const int inactivityIconsPerSecond = 10;

    const int inactivityGreen = 3;
    const int inactivityYellow = 10;
    const int inactivityRed = 30;
}

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow),
    iniFile("whozin.ini")
{
    ui->setupUi(this);

    setWindowTitle("whozin");

    QSettings settings(companyName, applicationName);
    restoreGeometry(settings.value("mainWindowGeometry").toByteArray());
    restoreState(settings.value("mainWindowState").toByteArray());
    ui->actionShowInactiveClients->setChecked(settings.value("showInactiveClients", false).toBool());

    QTimer::singleShot(0, this, SLOT(init()));
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::closeEvent(QCloseEvent *event)
{
    QSettings settings(companyName, applicationName);
    settings.setValue("mainWindowGeometry", saveGeometry());
    settings.setValue("mainWindowState", saveState());

    for (int i = 0, end = treeWidget->columnCount(); i < end; ++i) {
        QString key = "columnWidth_" + QString::number(i);
        settings.setValue(key, treeWidget->columnWidth(i));
    }

    settings.setValue("showInactiveClients", ui->actionShowInactiveClients->isChecked());
    settings.setValue("sortColumn", treeWidget->sortColumn());
    settings.setValue("sortOrder", treeWidget->header()->sortIndicatorOrder());

    QMainWindow::closeEvent(event);
}

void MainWindow::init()
{
    initUI();
    initMessaging();
}

void MainWindow::initUI()
{
    treeWidget = new QTreeWidget(this);
    treeWidget->setSortingEnabled(true);

    addColumn(tr("Address"), "client_address", 120, ColumnDataType::String);
    addColumn(tr("Hostname"), "hostname", 80, ColumnDataType::String);
    addColumn(tr("Username"), "username", 80, ColumnDataType::String);

    int numericColumnBegin = columns.size();

    addColumn(tr("Rb #"), "recv_buf_item_count", 40, ColumnDataType::Integer);
    addColumn(tr("Rb kB"), "recv_buf_byte_count", 50, ColumnDataType::Real, 1024);
    addColumn(tr("Sb #"), "send_buf_item_count", 40, ColumnDataType::Integer);
    addColumn(tr("Sb kB"), "send_buf_byte_count", 50, ColumnDataType::Real, 1024);
    addColumn(tr("R #/s"), "recv_items_per_sec", 45, ColumnDataType::Real);
    addColumn(tr("R kB/s"), "recv_bytes_per_sec", 50, ColumnDataType::Real, 1024);
    addColumn(tr("S #/s"), "sent_items_per_sec", 45, ColumnDataType::Real);
    addColumn(tr("S kB/s"), "sent_bytes_per_sec", 50, ColumnDataType::Real, 1024);

    int numericColumnEnd = columns.size();

    addColumn(tr("Started"), "time_started_utc", 158, ColumnDataType::TimestampUTC);

    latestUpdateColumnNumber = columns.size();

    addColumn(tr("Latest update"), "time_current_utc", 182, ColumnDataType::TimestampUTC);
    addColumn(tr("Working dir"), "working_dir", 160, ColumnDataType::String);

    QTreeWidgetItem* headerItem = new QTreeWidgetItem(columns);

    for (int i = numericColumnBegin; i < numericColumnEnd; ++i) {
        headerItem->setTextAlignment(i, Qt::AlignRight);
    }

    treeWidget->setHeaderItem(headerItem);

    for (auto i : columnData) {
        const ColumnDataItem& columnDataItem = i.second;
        treeWidget->setColumnWidth(columnDataItem.columnNumber, columnDataItem.columnWidth);
    }

    setCentralWidget(treeWidget);

    QSettings settings(companyName, applicationName);
    for (int i = 0, end = treeWidget->columnCount(); i < end; ++i) {
        QString key = "columnWidth_" + QString::number(i);
        bool ok = false;
        int columnWidth = settings.value(key).toInt(&ok);
        if (ok) {
            treeWidget->setColumnWidth(i, columnWidth);
        }
    }

    treeWidget->sortByColumn(settings.value("sortColumn").toInt(), static_cast<Qt::SortOrder>(settings.value("sortOrder").toInt()));

    initIcons();
}

void MainWindow::initIcons()
{
    assert(iconsByInactivityPeriod.empty());
    for (int i = 0, end = maxInactivitySeconds * inactivityIconsPerSecond; i < end; ++i) {

        double iconWidth = 32;
        double iconHeight = 32;
        QImage img(iconWidth, iconHeight, QImage::Format_ARGB32);

        img.fill(Qt::transparent);
        {
            double inactivityInSeconds = i / static_cast<double>(inactivityIconsPerSecond);

            int red = 0;
            int green = 0;
            int blue = 0;

            if (inactivityInSeconds < inactivityGreen) {
                green = 255;
            }
            else if (inactivityInSeconds < inactivityYellow) {
                green = 255;
                red = 255 * (inactivityInSeconds - inactivityGreen) / (inactivityYellow - inactivityGreen);
            }
            else if (inactivityInSeconds < inactivityRed) {
                green = 255 * (inactivityRed - inactivityInSeconds) / (inactivityRed - inactivityYellow);
                red = 255;
            }
            else {
                red = 255;
            }

            QPainter painter(&img);
            QColor color(red, green, blue);
            painter.setPen(color);
            painter.setBrush(color);
            painter.drawEllipse(QPointF(iconWidth / 2.0, iconHeight / 2.0), (iconWidth - 1) / 2, (iconHeight - 1) / 2);
        }
        QIcon icon(QPixmap::fromImage(img));
        iconsByInactivityPeriod.push_back(icon);
    }
}

void MainWindow::addColumn(const QString& title, const std::string& attributeName, int columnWidth, ColumnDataType dataType, double realNumberDivider)
{
    assert(columnData.find(attributeName) == columnData.end());

    ColumnDataItem columnDataItem;
    columnDataItem.attributeName = attributeName;
    columnDataItem.dataType = dataType;
    columnDataItem.realNumberDivider = realNumberDivider;
    columnDataItem.columnWidth = columnWidth;
    columnDataItem.columnNumber = columns.size();

    columnData[attributeName] = columnDataItem;

    columns.append(title);
}

void MainWindow::initMessaging()
{
    iniFile.Refresh();
    postOffice.Initialize(iniFile, "whozin");
    if (iniFile.IsDirty()) {
        iniFile.Save();
    }

    postOffice.Subscribe("__claim_MsgStatus");
    QTimer::singleShot(100, this, SLOT(processMessages()));
}

void MainWindow::processMessages()
{
    slaim::Message msg;
    bool messageReceived = false;

    treeWidget->setSortingEnabled(false);

    while (postOffice.Receive(msg, 0.0)) {
        messageReceived = true;

        if (msg.GetType() == "__claim_MsgStatus") {
            claim::AttributeMessage amsg(msg);
            const std::string clientAddress = extractClientAddress(amsg.m_attributes);
            if (!clientAddress.empty()) {
                ClientDataItem& clientDataItem = addOrGetExistingClient(clientAddress);
                clientDataItem.teSinceActivity.ResetToCurrent();
                int rowNumber = findRowNumber(clientAddress);
                QTreeWidgetItem* clientItem = treeWidget->invisibleRootItem()->child(rowNumber);

                for (const auto& i : amsg.m_attributes) {
                    const std::string& attributeName = i.first;
                    const std::string& attributeValue = i.second;
                    processAttribute(attributeName, attributeValue, clientItem);
                }
            }
        }
    }

    treeWidget->setSortingEnabled(true);

    // check errors and write to log, if any
    std::string error = postOffice.GetError();
    while (!error.empty()) {
        numcfc::Logger::LogAndEcho(error, "log_error");
        error = postOffice.GetError();
    }

    updateClientActivityStatus();

    // repeat
    QTimer::singleShot(messageReceived ? 0 : 1000, this, SLOT(processMessages()));
}

std::string MainWindow::extractClientAddress(const claim::AttributeMessage::Attributes& attributes)
{
    auto i = attributes.find("client_address");
    if (i != attributes.end()) {
        const std::string& clientAddress = i->second;
        return stripAddress(clientAddress);
    }
    return "";
}

std::string MainWindow::stripAddress(const std::string& clientAddress)
{
    std::string::size_type pos = clientAddress.rfind("#localhost");
    if (pos != std::string::npos) {
        return clientAddress.substr(0, pos);
    }
    else {
        return clientAddress;
    }
}

ClientDataItem& MainWindow::addOrGetExistingClient(const std::string& clientAddress)
{
    auto i = clientData.find(clientAddress);
    if (i == clientData.end()) {
        addClient(clientAddress);
        i = clientData.find(clientAddress);
    }
    ClientDataItem& clientDataItem = i->second;
    return clientDataItem;
}

void MainWindow::addClient(const std::string& clientAddress)
{
    QTreeWidgetItem* invisibleRoot = treeWidget->invisibleRootItem();

    ClientDataItem clientDataItem;
    clientData[clientAddress] = clientDataItem;

    QTreeWidgetItem* newClient = new MyTreeWidgetItem(treeWidget, columnData);
    newClient->setChildIndicatorPolicy(QTreeWidgetItem::DontShowIndicator);
    newClient->setText(0, QString(clientAddress.c_str()));

    bool isMe = clientAddress == stripAddress(postOffice.GetClientAddress());

    QTreeWidgetItem* headerItem = treeWidget->headerItem();
    for (int i = 0, end = headerItem->columnCount(); i < end; ++i) {
        if (i >= newClient->columnCount()) {
            newClient->setText(i, QString(""));
        }
        newClient->setTextAlignment(i, headerItem->textAlignment(i));

        if (isMe) {
            newClient->setTextColor(i, Qt::darkGray);
        }
    }

    invisibleRoot->addChild(newClient);
}

int MainWindow::findRowNumber(const std::string& clientAddress) const
{
    QTreeWidgetItem* invisibleRoot = treeWidget->invisibleRootItem();

    for (int i = 0, end = invisibleRoot->childCount(); i < end; ++i) {
        QTreeWidgetItem* treeWidgetItem = invisibleRoot->child(i);
        if (treeWidgetItem->text(0) == QString(clientAddress.c_str())) {
            return i;
        }
    }

    return -1;
}

void MainWindow::processAttribute(const std::string& attributeName, const std::string& attributeValue, QTreeWidgetItem* clientItem)
{
    auto k = columnData.find(attributeName);
    if (k != columnData.end()) {
        const ColumnDataItem& columnDataItem = k->second;
        if (columnDataItem.columnNumber != 0) {
            QString s = columnDataToString(attributeValue, columnDataItem.dataType, columnDataItem.realNumberDivider);
            clientItem->setText(columnDataItem.columnNumber, s);
        }
    }
}

void MainWindow::updateClientActivityStatus()
{
    QTreeWidgetItem* invisibleRoot = treeWidget->invisibleRootItem();

    bool atLeastOneItemIsChangingColor = false;

    for (auto i = clientData.begin(), end = clientData.end(); i != end; ++i) {
        const std::string& clientAddress = i->first;
        ClientDataItem& clientDataItem = i->second;
        int rowNumber = findRowNumber(clientAddress);
        if (rowNumber >= 0) {
            QTreeWidgetItem* treeWidgetItem = invisibleRoot->child(rowNumber);
            double inactivityInSeconds = clientDataItem.teSinceActivity.GetElapsedSeconds();
            if (inactivityInSeconds > maxInactivitySeconds && !ui->actionShowInactiveClients->isChecked()) {
                treeWidgetItem->setHidden(true);
            }
            else {
                if (inactivityInSeconds >= inactivityGreen && inactivityInSeconds < inactivityRed) {
                    atLeastOneItemIsChangingColor = true;
                }
                size_t inactivityIndex = static_cast<size_t>(inactivityInSeconds * inactivityIconsPerSecond);
                if (inactivityIndex >= iconsByInactivityPeriod.size()) {
                    inactivityIndex = iconsByInactivityPeriod.size() - 1;
                }
                if (treeWidgetItem->isHidden()) {
                    treeWidgetItem->setHidden(false);
                }
                const QIcon& icon = iconsByInactivityPeriod[inactivityIndex];
                treeWidgetItem->setIcon(latestUpdateColumnNumber, icon);
            }
        }
    }

    if (atLeastOneItemIsChangingColor) {
        QTimer::singleShot(100, this, SLOT(updateClientActivityStatus()));
    }
}

QString MainWindow::columnDataToString(const std::string& attributeValue, ColumnDataType dataType, double realDivider)
{
    switch (dataType) {
    case ColumnDataType::Unknown:
        return tr("UNKNOWN: ") + QString(attributeValue.c_str());
    case ColumnDataType::String:
        return QString(attributeValue.c_str());
    case ColumnDataType::Integer:
    {
        int i = atoi(attributeValue.c_str());
        return QString::number(i);
    }
    case ColumnDataType::Real:
    {
        double v = atof(attributeValue.c_str());
        return QString::number(v / realDivider, 'f', 1);
    }
    case ColumnDataType::TimestampUTC:
    {
        numcfc::Time utc(attributeValue.c_str(), numcfc::Time::Universal);
        numcfc::Time local = utc.ConvertUniversalToLocal();
        return QString(local.ToExtendedISO().c_str());
    }
    default:
        return tr("DEFAULT: ") + QString(attributeValue.c_str());
    }
}

void MainWindow::on_actionShowInactiveClients_triggered(bool checked)
{
    if (checked) {
        // show all clients
        QTreeWidgetItem* invisibleRoot = treeWidget->invisibleRootItem();

        for (int i = 0, end = invisibleRoot->childCount(); i < end; ++i) {
            QTreeWidgetItem* treeWidgetItem = invisibleRoot->child(i);
            if (treeWidgetItem->isHidden()) {
                treeWidgetItem->setHidden(false);
            }
        }
    }
    else {
        updateClientActivityStatus();
    }
}
