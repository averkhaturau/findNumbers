import QtQuick 2.3
import "controls"
import "utils.js" as Utils

Rectangle {
    id: root
    color: Utils.mainBgColor
    anchors.fill: parent
    anchors.topMargin: actionBar.height
    anchors.leftMargin: Utils.scaled(20)

    ScrollBar{ flickable: aFlickable }
    Flickable{
        id: aFlickable;
        anchors.fill: parent
        contentWidth: aText.contentWidth
        contentHeight: aText.contentHeight
        clip: true
        Text{
            id: aText
            text: qsTr(
                      "This simple and cute game is specially designed to demonstrate you the power of Qt QML.\n\n"+
                      "Start the game and click on the numbers from 1 to the biggest one by one. Try to make it the sooner the better.\n\n"
                      )
            wrapMode: Text.WordWrap
            color: Utils.mainFrColor
            font.family: Utils.fontFamily
            font.pointSize: 16
            width: root.width - 40
            horizontalAlignment: Text.AlignJustify
        }}
    MouseArea{
        anchors.fill: parent
        onClicked: mainLoader.source = "PlayScreen.qml"
    }

    Component.onDestruction: theSettings.howToPlayShown = true
    // code to exit on backspace pressed
    Connections {
        target: theMainWindow
        onBackPressed: mainLoader.source = "PlayScreen.qml"
    }
}
