#ifndef CLIENTDATA_H
#define CLIENTDATA_H

#include <numcfc/Time.h>
#include <string>
#include <unordered_map>

enum class ColumnDataType {
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
    numcfc::TimeElapsed teSinceActivity;
};

typedef std::unordered_map<std::string, ColumnDataItem> ColumnData;
typedef std::unordered_map<std::string, ClientDataItem> ClientData;

#endif // CLIENTDATA_H
