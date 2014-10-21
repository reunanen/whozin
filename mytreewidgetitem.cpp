#include "mytreewidgetitem.h"
#include "clientdata.h"
#include <assert.h>

MyTreeWidgetItem::MyTreeWidgetItem(QTreeWidget *parent, const ColumnData& columnData) :
    QTreeWidgetItem(parent), columnData(columnData)
{
}

bool MyTreeWidgetItem::operator< (const QTreeWidgetItem &other) const
{
    int sortCol = treeWidget()->sortColumn();
    ColumnDataType columnDataType = ColumnDataType::Unknown;
    for (const auto& i: columnData) {
        const ColumnDataItem& columnDataItem = i.second;
        if (columnDataItem.columnNumber == sortCol) {
            columnDataType = columnDataItem.dataType;
        }
    }

    switch (columnDataType) {
    case ColumnDataType::Unknown:
    case ColumnDataType::String:
    case ColumnDataType::TimestampUTC:
        return text(sortCol) < other.text(sortCol);
    case ColumnDataType::Integer:
    {
        int myNumber = text(sortCol).toInt();
        int otherNumber = other.text(sortCol).toInt();
        return myNumber < otherNumber;
    }
    case ColumnDataType::Real:
    {
        float myNumber = text(sortCol).toFloat();
        float otherNumber = other.text(sortCol).toFloat();
        return myNumber < otherNumber;
    }
    default:
        assert(false);
        return text(sortCol) < other.text(sortCol);
    }
}
