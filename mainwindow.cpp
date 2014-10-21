#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <numcfc/Time.h>
#include <numcfc/Logger.h>
#include <messaging/claim/AttributeMessage.h>

#include <QSettings>
#include <QTimer>
#include <QTreeWidget>
#include <assert.h>

namespace {
    const char* companyName = "Tomaattinen";
    const char* applicationName = "whozin";
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

    addColumn(tr("Address"), "client_address", 180, ColumnDataType::String);
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
    addColumn(tr("Latest update"), "time_current_utc", 158, ColumnDataType::TimestampUTC);
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
    postOffice.Initialize(iniFile, "whozin");
    postOffice.Subscribe("__claim_MsgStatus");
    QTimer::singleShot(100, this, SLOT(processMessages()));
}

void MainWindow::processMessages()
{
    slaim::Message msg;
    bool messageReceived = false;
    while (postOffice.Receive(msg, 0.0)) {
        messageReceived = true;

        if (msg.GetType() == "__claim_MsgStatus") {
            claim::AttributeMessage amsg(msg);
            auto i = amsg.m_attributes.find("client_address");
            if (i != amsg.m_attributes.end()) {
                const std::string& clientAddress = i->second;
                auto j = clientData.find(clientAddress);
                if (j == clientData.end()) {
                    addClient(clientAddress);
                    j = clientData.find(clientAddress);
                }
                int rowNumber = j->second.rowNumber;
                QTreeWidgetItem* clientItem = treeWidget->invisibleRootItem()->child(rowNumber);

                for (auto k : amsg.m_attributes) {
                    const std::string& attributeName = k.first;
                    const std::string& attributeValue = k.second;
                    processAttribute(attributeName, attributeValue, clientItem);
                }
            }
        }
    }

    // check errors and write to log, if any
    std::string error = postOffice.GetError();
    while (!error.empty()) {
        numcfc::Logger::LogAndEcho(error, "log_error");
        error = postOffice.GetError();
    }

    // repeat
    QTimer::singleShot(messageReceived ? 0 : 100, this, SLOT(processMessages()));
}

void MainWindow::addClient(const std::string& clientAddress)
{
    QTreeWidgetItem* invisibleRoot = treeWidget->invisibleRootItem();

    ClientDataItem clientDataItem;
    clientDataItem.rowNumber = invisibleRoot->childCount();
    clientData[clientAddress] = clientDataItem;

    QTreeWidgetItem* newClient = new QTreeWidgetItem(treeWidget);
    newClient->setText(0, QString(clientAddress.c_str()));

    QTreeWidgetItem* headerItem = treeWidget->headerItem();
    for (int i = 0, end = headerItem->columnCount(); i < end; ++i) {
        if (i >= newClient->columnCount()) {
            newClient->setText(i, QString(""));
        }
        newClient->setTextAlignment(i, headerItem->textAlignment(i));
    }

    invisibleRoot->addChild(newClient);
}

void MainWindow::processAttribute(const std::string& attributeName, const std::string& attributeValue, QTreeWidgetItem* clientItem)
{
    auto k = columnData.find(attributeName);
    if (k != columnData.end()) {
        const ColumnDataItem& columnDataItem = k->second;
        QString s = columnDataToString(attributeValue, columnDataItem.dataType, columnDataItem.realNumberDivider);
        clientItem->setText(columnDataItem.columnNumber, s);
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
