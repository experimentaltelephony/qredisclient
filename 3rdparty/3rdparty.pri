# Core deps 
# Read API from hiredis
INCLUDEPATH += $$PWD/hiredis
DEPENDPATH += $$PWD/hiredis
HEADERS += $$PWD/hiredis/read.h \
           $$PWD/hiredis/sds.h
SOURCES += $$PWD/hiredis/read.c \
           $$PWD/hiredis/sds.c


unix:mac {
    INCLUDEPATH += /usr/local/Cellar/openssl/1.0.2h_1/include
    LIBS += -L/usr/local/Cellar/openssl/1.0.2h_1/lib
}

win32-msvc* {
    win32-msvc2015 {
        message("msvc2015 detected")
        WIN_DEPS_VERSION = v140
    } else {
        error("Your msvc version is not suppoted. qredisclient requires msvc2015+")
    }

    CONFIG(release, debug|release) {
        WIN_DEPS_PATH = $$PWD/windows/rmt_zlib.1.2.8.5/build/native/lib/$$WIN_DEPS_VERSION/Win32/Release/static/zlibstat.lib

        defined(OPENSSL_STATIC) {
            WIN_DEPS_PATH3 = $$PWD/windows/rmt_openssl.1.0.2.5/build/native/lib/$$WIN_DEPS_VERSION/Win32/Release/static
        } else {
            WIN_DEPS_PATH3 = $$PWD/windows/rmt_openssl.1.0.2.5/build/native/lib/$$WIN_DEPS_VERSION/Win32/Release/dynamic
        }
    } else: CONFIG(debug, debug|release) {
        defined(OPENSSL_STATIC) {
            WIN_DEPS_PATH3 = $$PWD/windows/rmt_openssl.1.0.2.5/build/native/lib/$$WIN_DEPS_VERSION/Win32/Debug/static
        } else {
            WIN_DEPS_PATH3 = $$PWD/windows/rmt_openssl.1.0.2.5/build/native/lib/$$WIN_DEPS_VERSION/Win32/Debug/dynamic
        }
    }

    LIBS += $$WIN_DEPS_PATH -L$$WIN_DEPS_PATH2 -L$$WIN_DEPS_PATH3 -llibeay32 -lssleay32 -lgdi32 -lws2_32 -lkernel32 -luser32 -lshell32 -luuid -lole32 -ladvapi32
} else {
    LIBS += -lssl -lz 
}


INCLUDEPATH += $$PWD/
