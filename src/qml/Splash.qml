import QtQuick 2.3
import "utils.js" as Utils

Rectangle {
    id: splash

    anchors.fill: parent
    color: Utils.mainBgColor

    Image {
        id: logo
        source: "qrc:/assets/images/logo.png"
        fillMode: Image.PreserveAspectFit
        anchors.fill: parent
        anchors.margins: splash.width /4
        smooth: true
    }

    Text {
        text: "Improve you attension and concentration!!!"
        color: "white"
        //anchors.centerIn: splash
        anchors.horizontalCenter: splash.horizontalCenter
        anchors.topMargin: 3
        anchors.top: logo.bottom
        font.family: Utils.fontFamily
        font.pointSize: 12
    }

    Timer {
        id: timer
        interval: 3000
        running: false
        onTriggered: theMainWindow.nextScreen()
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: theMainWindow.nextScreen()
    }

    Component.onCompleted:{
        timer.start()
    }
    // code to exit on backspace pressed
    Connections {
        target: theMainWindow
        onBackPressed: Qt.quit()
    }

    opacity: 0
    OpacityAnimator on opacity{
        from: 0
        to: 1
        duration: 1000
        running: true
    }

}
