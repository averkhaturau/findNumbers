import QtQuick 2.3
import "utils.js" as Utils

Rectangle {
    id: sfs
    property string theText: qsTr("Attention!")
    property var nextCmd: function(){}

    anchors.fill: parent
    color: Utils.mainBgColor
    visible: false
    Timer {
        interval: 1000
        running: parent.visible
        onTriggered: {console.log("hiding start-finish screen"); visible = false; nextCmd();}
    }
    Text{
        text: theText
        anchors.centerIn: parent
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
        font.pixelSize: theMainWindow.width / 7
        font.family: Utils.fontFamily
    }
}

