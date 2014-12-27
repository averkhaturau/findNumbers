import QtQuick 2.3
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import QtQuick.Controls 1.2

import "qml"
import "qml/utils.js" as Utils


Rectangle {
    id: theMainWindow
    objectName: "theMainWindow"
    anchors.fill: parent
    visible: true
    color: "black"

    ActionBar {
        id: actionBar
        visible: false

        title: ''

        onActionButtonClicked: mainMenu.popup()
    }

    MouseArea{
        anchors.fill: parent
        propagateComposedEvents: true // do not still events
        onPressAndHold: mainMenu.popup()
    }

    Menu {
        id: mainMenu
        MenuItem{
            text: "Start new game"
            onTriggered: {mainLoader.source = "qml/PlayScreen.qml"; startNewGame()}
        }
        MenuItem{
            text: "Set Field Size"
            onTriggered: {mainLoader.source = "qml/PlayScreen.qml"; setFieldSize()}
        }
        MenuItem{
            text: "View Records"
            onTriggered: {actionBar.stopTimer(); mainLoader.source = "qml/RecordsScreen.qml"}
        }
        MenuItem{
            text: "How To Play?"
            onTriggered: {actionBar.stopTimer(); mainLoader.source = "qml/HowToPlay.qml"}
        }
    }
    signal startNewGame()
    signal setFieldSize()


    Loader {
        id: mainLoader
        anchors.fill: parent
        onLoaded: {
            console.log("Loader", mainLoader.source, mainLoader.status)
            actionBar.visible = true
        }
    }

    function nextScreen() {
        mainLoader.source = theSettings.howToPlayShown ? "qml/PlayScreen.qml" : "qml/HowToPlay.qml"
        console.log("Switching to PlayScreen")
    }

    Settings {
        id: theSettings
        property int maxNumber: 9; // must be possible to place this number of squares to screen
        property string numbersOrder: ""
        property bool howToPlayShown: false
        property string records: ""
    }
    RecordsModel{
        id: recordsModel
        onCountChanged: theSettings.records = Utils.serializeListModel(recordsModel)
    }
    Component.onCompleted: {
        mainLoader.source = "qml/Splash.qml"
        Utils.deserializeListModel(theSettings.records, recordsModel)
    }


    // needed to reload page in debug
    FocusScope {
        focus: true
        Keys.onPressed: {
            if (debug && event.key === Qt.Key_F5) {
                reloadScreen()
            }
        }
        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                console.log("Back button pressed.")
                event.accepted = true
                backPressed()
            }
        }
    }
    signal backPressed()
    signal clearComponentCache()
    function reloadScreen() {
        // reload page (seems its not working for now)
        clearComponentCache()
        var src = mainLoader.source
        mainLoader.source = ''
        mainLoader.source = src
    }
}
