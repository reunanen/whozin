#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include "clientdata.h"

#include <QMainWindow>

#include <numcfc/IniFile.h>
#include <messaging/claim/PostOffice.h>
#include <messaging/claim/AttributeMessage.h>

#include <unordered_map>

namespace Ui {
class MainWindow;
}

class QTreeWidget;
class QTreeWidgetItem;
class QCloseEvent;

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

protected:
    void closeEvent(QCloseEvent *event);

private slots:
    void init();
    void processMessages();
    void updateClientActivityStatus();

    void on_actionShowInactiveClients_triggered(bool checked);

private:
    void initUI();
    void initMessaging();
    void initIcons();
    void addColumn(const QString& title, const std::string& attributeName, int columnWidth, ColumnDataType dataType, double realDivider = 1.0);
    static std::string extractClientAddress(const claim::AttributeMessage::Attributes& attributes);
    static std::string stripAddress(const std::string& clientAddress);
    ClientDataItem& addOrGetExistingClient(const std::string& clientAddress);
    void addClient(const std::string& clientAddress);
    int findRowNumber(const std::string& clientAddress) const;
    void processAttribute(const std::string& attributeName, const std::string& attributeValue, QTreeWidgetItem* clientItem);
    QString columnDataToString(const std::string& attributeValue, ColumnDataType dataType, double realDivider);

    Ui::MainWindow *ui;
    QTreeWidget* treeWidget;

    numcfc::IniFile iniFile;
    claim::PostOffice postOffice;

    QStringList columns;
    ColumnData columnData;
    ClientData clientData;

    std::vector<QIcon> iconsByInactivityPeriod;

    int latestUpdateColumnNumber;
};

#endif // MAINWINDOW_H
