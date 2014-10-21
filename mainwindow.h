#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include "clientdata.h"

#include <QMainWindow>
#include <numcfc/IniFile.h>
#include <messaging/claim/PostOffice.h>
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

public slots:
    void init();
    void processMessages();

protected:
    void closeEvent(QCloseEvent *event);

private:
    void initUI();
    void initMessaging();
    void addColumn(const QString& title, const std::string& attributeName, int columnWidth, ColumnDataType dataType, double realDivider = 1.0);
    void addClient(const std::string& clientAddress);
    void processAttribute(const std::string& attributeName, const std::string& attributeValue, QTreeWidgetItem* clientItem);
    QString columnDataToString(const std::string& attributeValue, ColumnDataType dataType, double realDivider);

    Ui::MainWindow *ui;
    QTreeWidget* treeWidget;

    numcfc::IniFile iniFile;
    claim::PostOffice postOffice;

    QStringList columns;
    std::unordered_map<std::string, ColumnDataItem> columnData;
    std::unordered_map<std::string, ClientDataItem> clientData;
};

#endif // MAINWINDOW_H
