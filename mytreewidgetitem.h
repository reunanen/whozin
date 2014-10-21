#ifndef MYTREEWIDGETITEM_H
#define MYTREEWIDGETITEM_H

#include "clientdata.h"
#include <QTreeWidgetItem>

class MyTreeWidgetItem : public QTreeWidgetItem
{
public:
    explicit MyTreeWidgetItem(QTreeWidget *parent, const ColumnData& columnData);

    bool operator< (const QTreeWidgetItem &other) const;

private:
    const ColumnData& columnData;
};

#endif // MYTREEWIDGETITEM_H
