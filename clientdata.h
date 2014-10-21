#ifndef CLIENTDATA_H
#define CLIENTDATA_H

#include <string>
#include <numcfc/Time.h>

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
    numcfc::TimeElapsed teSinceActivity;
};

#endif // CLIENTDATA_H
