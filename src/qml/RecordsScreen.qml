import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
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
        frameVisible: false

        style: TableViewStyle{
            // control: parent
            textColor : Utils.mainFrColor
            backgroundColor: Utils.mainBgColor
            alternateBackgroundColor: Utils.mainBgColor
            activateItemOnSingleClick: false
            highlightedTextColor: Utils.mainFrColor
            headerDelegate: Column{
                height: headerText.height + 2
                width: headerText.width
                Text{
                    id: headerText
                    height: implicitHeight
                    width: implicitWidth
                    text: styleData.value
                    color: Utils.randomColor()
                }
            }
        }

        //        TableViewColumn { title: qsTr("Size"); role: "playSize"
        //            delegate: Item {Text{color:Utils.randomColor(); text: styleData.value}}
        //        }

        //property var secColor: Utils.randomColor()
        section{
            criteria: ViewSection.FullString
            property: "playSize"
            labelPositioning: ViewSection.InlineLabels
            delegate: Rectangle {
                width: recordsView.width
                height: childrenRect.height
                color: "transparent"
                Text {
                    text: section
                    font.bold: true
                    font.pixelSize: 20
                    color: Utils.randomColor()
                }
            }
        }

        TableViewColumn { title: qsTr("Records"); role: "playTime"
            delegate: Item {Text{ color: Utils.randomColor(); text: Qt.formatDateTime(new Date(styleData.value), "mm:ss")}}
        }

        TableViewColumn { title: qsTr("When"); role: "when"
            delegate: Item{Text{color: Utils.randomColor(); text: Qt.formatDateTime(new Date(styleData.value), "yyyy-MM-ss h:mm")}}
        }
    }

    Component.onCompleted: recordsView.resizeColumnsToContents();

    Rectangle {
        id: btnPlay
        anchors.bottom: root.bottom
        anchors.right: root.right
        color: Utils.randomColor()

        width: btnText.contentWidth + root.anchors.margins
        height: btnText.contentHeight + root.anchors.margins
        radius: height / 2.5

        Text {
            id: btnText
            text: qsTr("Play again")
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

    Rectangle {
        id: clearBtn
        anchors.bottom: root.bottom
        anchors.left: root.left
        color: Utils.randomColor()

        width: btnText.contentWidth + root.anchors.margins
        height: btnText.contentHeight + root.anchors.margins
        radius: height / 2.5

        Text {
            text: qsTr("Clear")
            anchors.centerIn: parent
            color: Utils.mainFrColor
            font.pixelSize: Utils.scaled(18)
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                recordsModel.clear()
            }
        }
    }

    // code to exit on backspace pressed
    Connections {
        target: theMainWindow
        onBackPressed: Qt.quit()
    }
}
