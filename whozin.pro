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
INCLUDEPATH += ../Numcore_messaging_library
INCLUDEPATH += /Local/Numcore_messaging_library/messaging/num0w/libzmq/include
INCLUDEPATH += /Local/Numcore_messaging_library/messaging/num0w/libzmq/src
INCLUDEPATH += /Local/Numcore_messaging_library/messaging/num0w/libzmq/builds/msvc

DEFINES += ZMQ_STATIC
DEFINES += ZMQ_USE_SELECT
DEFINES += ZMQ_HAVE_WINDOWS_TARGET_XP
DEFINES += "_WIN32_WINNT=0x0501"

LIBS += -L/Local/boost_1_56_0/stage/lib/x86 \
    -lws2_32 -ladvapi32 -lIphlpapi

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
    ../Numcore_messaging_library/messaging/claim/MessageStreaming.cpp \
    ../Numcore_messaging_library/messaging/num0w/num0w_postoffice.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/builds/msvc/errno.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/address.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/client.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/clock.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ctx.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/curve_client.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/curve_server.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/dealer.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/decoder_allocators.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/devpoll.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/dgram.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/dish.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/dist.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/epoll.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/err.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/fq.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/gather.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/gssapi_client.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/gssapi_mechanism_base.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/gssapi_server.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/io_object.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/io_thread.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ip.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ipc_address.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ipc_connecter.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ipc_listener.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/kqueue.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/lb.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/mailbox.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/mailbox_safe.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/mechanism.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/metadata.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/msg.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/mtrie.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/norm_engine.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/null_mechanism.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/object.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/options.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/own.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pair.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pgm_receiver.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pgm_sender.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pgm_socket.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pipe.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/plain_client.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/plain_server.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/poll.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/poller_base.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/precompiled.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/proxy.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pub.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pull.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/push.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/radio.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/random.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/raw_decoder.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/raw_encoder.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/reaper.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/rep.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/req.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/router.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/scatter.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/select.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/server.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/session_base.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/signaler.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/socket_base.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/socket_poller.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/socks.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/socks_connecter.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/stream.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/stream_engine.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/sub.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tcp.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tcp_address.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tcp_connecter.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tcp_listener.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/thread.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/timers.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tipc_address.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tipc_connecter.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tipc_listener.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/trie.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/udp_address.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/udp_engine.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/v1_decoder.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/v1_encoder.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/v2_decoder.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/v2_encoder.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/vmci.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/vmci_address.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/vmci_connecter.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/vmci_listener.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/xpub.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/xsub.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/zmq.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/zmq_utils.cpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tweetnacl.c

HEADERS  += mainwindow.h \
    mytreewidgetitem.h \
    clientdata.h \
    ../Numcore_messaging_library/messaging/claim/AttributeMessage.h \
    ../Numcore_messaging_library/messaging/claim/MessageStreaming.h \
    ../Numcore_messaging_library/messaging/claim/PostOffice.h \
    ../Numcore_messaging_library/messaging/claim/PostOfficeInitializer.h \
    ../Numcore_messaging_library/messaging/claim/ThroughputStatistics.h \
    ../Numcore_messaging_library/messaging/num0w/config.h \
    ../Numcore_messaging_library/messaging/num0w/num0w_postoffice.h \
    ../Numcore_messaging_library/messaging/slaim/buffer.h \
    ../Numcore_messaging_library/messaging/slaim/bufferitem.h \
    ../Numcore_messaging_library/messaging/slaim/errorlog.h \
    ../Numcore_messaging_library/messaging/slaim/message.h \
    ../Numcore_messaging_library/messaging/slaim/postoffice.h \
    ../Numcore_messaging_library/messaging/slaim/postoffice_extended.h \
    ../Numcore_messaging_library/messaging/num0w/cppzmq/zmq.hpp \
    ../Numcore_messaging_library/messaging/num0w/cppzmq/zmq_addon.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/builds/gyp/platform.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/builds/mingw32/platform.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/builds/msvc/errno.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/builds/msvc/platform.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/builds/msvc/resource.h \
    ../Numcore_messaging_library/messaging/num0w/libzmq/builds/zos/platform.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/include/zmq.h \
    ../Numcore_messaging_library/messaging/num0w/libzmq/include/zmq_utils.h \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/address.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/array.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/atomic_counter.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/atomic_ptr.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/blob.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/client.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/clock.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/command.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/condition_variable.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/config.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ctx.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/curve_client.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/curve_server.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/dbuffer.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/dealer.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/decoder.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/decoder_allocators.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/devpoll.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/dgram.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/dish.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/dist.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/encoder.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/epoll.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/err.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/fd.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/fq.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/gather.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/gssapi_client.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/gssapi_mechanism_base.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/gssapi_server.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/i_decoder.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/i_encoder.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/i_engine.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/i_mailbox.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/i_poll_events.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/io_object.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/io_thread.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ip.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ipc_address.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ipc_connecter.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ipc_listener.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/kqueue.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/lb.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/likely.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/macros.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/mailbox.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/mailbox_safe.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/mechanism.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/metadata.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/msg.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/mtrie.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/mutex.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/norm_engine.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/null_mechanism.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/object.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/options.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/own.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pair.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pgm_receiver.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pgm_sender.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pgm_socket.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pipe.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/plain_client.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/plain_server.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/poll.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/poller.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/poller_base.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/precompiled.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/proxy.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pub.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/pull.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/push.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/radio.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/random.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/raw_decoder.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/raw_encoder.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/reaper.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/rep.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/req.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/router.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/scatter.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/select.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/server.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/session_base.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/signaler.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/socket_base.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/socket_poller.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/socks.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/socks_connecter.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/stdint.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/stream.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/stream_engine.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/sub.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tcp.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tcp_address.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tcp_connecter.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tcp_listener.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/thread.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/timers.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tipc_address.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tipc_connecter.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tipc_listener.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/trie.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/tweetnacl.h \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/udp_address.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/udp_engine.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/v1_decoder.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/v1_encoder.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/v2_decoder.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/v2_encoder.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/v2_protocol.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/vmci.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/vmci_address.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/vmci_connecter.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/vmci_listener.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/windows.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/wire.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/xpub.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/xsub.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ypipe.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ypipe_base.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/ypipe_conflate.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/yqueue.hpp \
    ../Numcore_messaging_library/messaging/num0w/libzmq/src/zmq_draft.h

FORMS    += mainwindow.ui

RC_FILE = whozin.rc
