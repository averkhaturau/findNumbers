import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "utils.js" as Utils

Rectangle {
    id: root
    color: "transparent"
    anchors.fill: parent
    anchors.margins: Utils.scaled(30)

    TableView {
        id: recordsView
        model: recordsModel
        anchors.top: root.top
        anchors.bottom: btnPlay.top
        anchors.left: root.left
        anchors.right: root.right
        anchors.topMargin: 20
        backgroundVisible: false
        alternatingRowColors: false

       // headerDelegate: Item{}

        style: TableViewStyle{
           // control: parent
            textColor : Utils.mainFrColor
            backgroundColor: Utils.mainBgColor
            alternateBackgroundColor: Utils.mainBgColor
            highlightedTextColor: Utils.mainFrColor
        }

        TableViewColumn { title: "Size"; role: "playSize"  }
        TableViewColumn { title: "When"; role: "when"; delegate: Item{Text{color: styleData.textColor; text: Qt.formatDateTime(new Date(styleData.value), "yyyy-MM-ss h:mm")}} }
        TableViewColumn { title: "Time"; role: "playTime"
            delegate: Item {Text{ color: styleData.textColor; text: Qt.formatDateTime(new Date(styleData.value), "mm:ss")}}
        }

        section.property: "playSize"
    }

    Component.onCompleted: recordsView.resizeColumnsToContents();

    Rectangle {
        id: btnPlay
        anchors.bottom: root.bottom
        anchors.right: root.right
        //		anchors.margins: - root.anchors.margins / 4
        color: Utils.actionBarColor

        width: btnText.contentWidth + root.anchors.margins
        height: btnText.contentHeight + root.anchors.margins
        radius: height / 2.5

        Text {
            id: btnText
            text: "Play again"
            anchors.centerIn: parent
            color: Utils.mainFrColor
            font.pixelSize: Utils.scaled(18)
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainLoader.source = "PlayScreen.qml"
                startNewGame()
            }
        }
    }

    // code to exit on backspace pressed
    Connections {
        target: theMainWindow
        onBackPressed: Qt.quit()
    }
}
