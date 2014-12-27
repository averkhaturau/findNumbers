import QtQuick 2.3
import "utils.js" as Utils

Rectangle {
    id: splash

    anchors.fill: parent
    color: Utils.mainBgColor


    Image {
        id: logo
        source: "qrc:/assets/images/lenin-300x235.jpg"
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
        smooth: true
    }

    Text {
        text: "Improve you attension and concentration!!!"
        color: "white"
        anchors.horizontalCenter: logo.horizontalCenter
        anchors.topMargin: 15
        anchors.top: logo.bottom
    }

    Timer {
        id: timer
        interval: 1234 // bla-bla-bla
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
