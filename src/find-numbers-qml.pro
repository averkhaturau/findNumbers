TEMPLATE = app

CONFIG += c++11

QT +=   qml \
        quick


SOURCES += main.cpp


RESOURCES += qml.qrc \
             images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = qml

OTHER_FILES = main.qml \
              qml/*.qml \
              qml/controls/*.qml \
              android/AndroidManifest.xml \
			  qml/utils.js

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    smartconnect.h \

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

win32:RC_ICONS += "assets/images/lenin.ico"
VERSION = "0.0.0.1"
QMAKE_TARGET_COMPANY="Aliaksei Verkhaturau"
QMAKE_TARGET_DESCRIPTION="Find Numbers game"
QMAKE_TARGET_COPYRIGHT="Copyright 2014 (C) Aliaksei Verkhaturau"
QMAKE_TARGET_PRODUCT="FindNumbers"
