import QtQuick 2.3
import "../utils.js" as Utils

Rectangle {
    color: "transparent"
    width: Utils.scaled(55)
    height: width

    signal clicked
    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
    }

    // TODO: rewrite using Repeater on [top,verticalCenter,bottom]
    Rectangle {
        color: Utils.mainFrColor
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height / 5
    }
    Rectangle {
        color: Utils.mainFrColor
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height / 5
    }
    Rectangle {
        color: Utils.mainFrColor
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height / 5
    }
}
