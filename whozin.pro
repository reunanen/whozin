#-------------------------------------------------
#
# Project created by QtCreator 2014-10-21T13:37:31
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = whozin
TEMPLATE = app

INCLUDEPATH += ../boost_1_56_0
INCLUDEPATH += ../spread-src-4.4.0/include
INCLUDEPATH += ../Numcore_messaging_library

LIBS += -L/Local/boost_1_56_0/stage/lib/x86 \
    -L/Local/spread-src-4.4.0/lib/win32/Release \
    -llibspread -lwsock32 -ladvapi32

SOURCES += main.cpp \
    mainwindow.cpp \
    clientdata.cpp \
    mytreewidgetitem.cpp \
    ../Numcore_messaging_library/numcfc/IdGenerator.cpp \
    ../Numcore_messaging_library/numcfc/IniFile.cpp \
    ../Numcore_messaging_library/numcfc/Logger.cpp \
    ../Numcore_messaging_library/numcfc/ThreadRunner.cpp \
    ../Numcore_messaging_library/numcfc/Time.cpp \
    ../Numcore_messaging_library/messaging/slaim/messaging.cpp \
    ../Numcore_messaging_library/messaging/claim/PostOffice.cpp \
    ../Numcore_messaging_library/messaging/claim/PostOfficeInitializer.cpp \
    ../Numcore_messaging_library/messaging/claim/AttributeMessage.cpp \
    ../Numcore_messaging_library/messaging/numsprew/numsprew_postoffice.cpp \
    ../Numcore_messaging_library/messaging/numsprew/signaling_select.cpp

HEADERS  += mainwindow.h \
    mytreewidgetitem.h \
    clientdata.h

FORMS    += mainwindow.ui

RC_FILE = whozin.rc
