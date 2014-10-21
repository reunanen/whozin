#ifndef CLIENTDATA_H
#define CLIENTDATA_H

#include <string>

enum ColumnDataType {
    Unknown = 0,
    String = 1,
    Integer = 2,
    Real = 3,
    TimestampUTC = 4
};

struct ColumnDataItem
{
   std::string attributeName;
   ColumnDataType dataType;
   double realNumberDivider;
   int columnNumber;
   int columnWidth;
};

struct ClientDataItem
{
    int rowNumber;
};

#endif // CLIENTDATA_H
