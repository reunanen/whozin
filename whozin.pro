#-------------------------------------------------
#
# Project created by QtCreator 2014-10-21T13:37:31
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = whozin
TEMPLATE = app

INCLUDEPATH += Numcore_messaging_library
INCLUDEPATH += Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq
INCLUDEPATH += Numcore_messaging_library/messaging/numrabw/amqpcpp/include

DEFINES += AMQP_STATIC
DEFINES += AMQP_NO_SSL
DEFINES += HAVE_SELECT
DEFINES += _ALLOW_KEYWORD_MACROS
DEFINES += AMQ_PLATFORM=\\\"Windows\\\"
DEFINES += "_WIN32_WINNT=0x0501"
DEFINES += "inline=__inline"

LIBS += -lws2_32 -ladvapi32

SOURCES += main.cpp \
    mainwindow.cpp \
    clientdata.cpp \
    mytreewidgetitem.cpp \
    Numcore_messaging_library/numcfc/IdGenerator.cpp \
    Numcore_messaging_library/numcfc/IniFile.cpp \
    Numcore_messaging_library/numcfc/Logger.cpp \
    Numcore_messaging_library/numcfc/ThreadRunner.cpp \
    Numcore_messaging_library/numcfc/Time.cpp \
    Numcore_messaging_library/messaging/slaim/messaging.cpp \
    Numcore_messaging_library/messaging/claim/PostOffice.cpp \
    Numcore_messaging_library/messaging/claim/PostOfficeInitializer.cpp \
    Numcore_messaging_library/messaging/claim/AttributeMessage.cpp \
    Numcore_messaging_library/messaging/claim/MessageStreaming.cpp \
    Numcore_messaging_library/messaging/numrabw/numrabw_postoffice.cpp \
    Numcore_messaging_library/messaging/numrabw/amqpcpp/src/AMQP.cpp \
    Numcore_messaging_library/messaging/numrabw/amqpcpp/src/AMQPBase.cpp \
    Numcore_messaging_library/messaging/numrabw/amqpcpp/src/AMQPException.cpp \
    Numcore_messaging_library/messaging/numrabw/amqpcpp/src/AMQPExchange.cpp \
    Numcore_messaging_library/messaging/numrabw/amqpcpp/src/AMQPMessage.cpp \
    Numcore_messaging_library/messaging/numrabw/amqpcpp/src/AMQPQueue.cpp \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_api.c \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_connection.c \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_consumer.c \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_framing.c \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_hostcheck.c \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_mem.c \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_socket.c \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_table.c \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_tcp_socket.c \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_time.c \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_url.c

HEADERS  += mainwindow.h \
    mytreewidgetitem.h \
    clientdata.h \
    Numcore_messaging_library/messaging/claim/AttributeMessage.h \
    Numcore_messaging_library/messaging/claim/MessageStreaming.h \
    Numcore_messaging_library/messaging/claim/PostOffice.h \
    Numcore_messaging_library/messaging/claim/PostOfficeInitializer.h \
    Numcore_messaging_library/messaging/claim/ThroughputStatistics.h \
    Numcore_messaging_library/messaging/num0w/config.h \
    Numcore_messaging_library/messaging/num0w/num0w_postoffice.h \
    Numcore_messaging_library/messaging/slaim/buffer.h \
    Numcore_messaging_library/messaging/slaim/bufferitem.h \
    Numcore_messaging_library/messaging/slaim/errorlog.h \
    Numcore_messaging_library/messaging/slaim/message.h \
    Numcore_messaging_library/messaging/slaim/postoffice.h \
    Numcore_messaging_library/messaging/slaim/postoffice_extended.h \
    Numcore_messaging_library/messaging/numrabw/numrabw_postoffice.h \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp.h \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_framing.h \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_hostcheck.h \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_private.h \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_socket.h \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_table.h \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_tcp_socket.h \
    Numcore_messaging_library/messaging/numrabw/rabbitmq-c/librabbitmq/amqp_time.h \
    Numcore_messaging_library/messaging/numrabw/amqpcpp/include/AMQPcpp.h

FORMS    += mainwindow.ui

RC_FILE = whozin.rc
