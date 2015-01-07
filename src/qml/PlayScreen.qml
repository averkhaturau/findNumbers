import QtQuick 2.3
import QtQuick.Controls 1.2
import "utils.js" as Utils


Rectangle {
    anchors.fill: parent
    anchors.topMargin: actionBar.height
    color: Utils.mainBgColor

    readonly property real aspectRatio: width / height

    Connections{
        target: theMainWindow
        onStartNewGame: startNewGame()
        onSetFieldSize: {actionBar.stopTimer();playSizeMenu.popup()}
    }

    function startNewGame(){
        console.log("Show start screen")
        startFinishScreen.theText = qsTr("Attention!")
        startFinishScreen.visible = true

        console.log("Restarting the game")
        var numVals = theSettings.maxNumber
        theSettings.numbersOrder = ''
        theSettings.maxNumber = numVals
        playField.lastFoundVal = 0

        startFinishScreen.nextCmd = function(){
            actionBar.startTimer();
        }
        console.log("Restarting the game - done.")
    }
    function stopGame(){

        startFinishScreen.theText = qsTr("Congrats!")
        startFinishScreen.visible = true

        console.log("Game Stopped")
        var timeSpan = actionBar.stopTimer()

        // TODO: update records - with sort
        var newRecord = {
            playSize: playField.lastFoundVal,
            playTime: timeSpan,
            when: new Date().toString()
        }
        recordsModel.addItem(newRecord)

        startFinishScreen.nextCmd = function(){

            // TODO: show congrats screen
            mainLoader.source = "RecordsScreen.qml"
            // TODO: play congrats sound
        }
    }

    Menu {
        id: playSizeMenu
        function fillMenu(){
            console.log("fillMenu-begin")
            var maxI = Math.min(80, Math.min(parent.width, parent.height) / 20)
            var i,j;
            for (i = 2; i < maxI; ++i){
                j = Math.ceil(i * aspectRatio)
                // capture val by value
                var setHandler = function(val){
                    var mi = playSizeMenu.addItem("" + val)
                    mi.triggered.connect(function(){theSettings.maxNumber = val; startNewGame();})
                };
                setHandler(i * j)
            }
            console.log("fillMenu-end")
        }
    }

    Rectangle {
        id: playField
        anchors.centerIn: parent
        color: "transparent"

        readonly property int colsR: Math.round(Math.sqrt(theSettings.maxNumber * aspectRatio))
        readonly property int rowsR: Math.round(Math.sqrt(theSettings.maxNumber / aspectRatio))
        readonly property bool colsPriority: colsR < rowsR
        readonly property int cols: colsPriority ? colsR : theSettings.maxNumber / rowsR
        readonly property int rows: colsPriority ? theSettings.maxNumber / colsR : rowsR


        readonly property int cellSize: Math.min(parent.width/cols, parent.height/rows)

        width:  cellSize * cols
        height: cellSize * rows

        readonly property int lastValue: rows * cols
        readonly property var valuesOrder: {
            var result = []
            var savedOrder = theSettings.numbersOrder.split(',');
            if (savedOrder.length !== lastValue) {
                if (!!theSettings.maxNumber){
                    console.log("Regenerating values")
                    result = Utils.shuffle(Utils.generateIntArray(lastValue))
                }
            }
            else {
                console.log("Using values from settings: "+theSettings.numbersOrder)
                result = savedOrder
            }
            return result
        }

        Column{
            Repeater{
                model: playField.rows
                Row {
                    readonly property int rowInd: index
                    Repeater{
                        id: rawRep
                        model: playField.cols
                        Rectangle{
                            readonly property int ind: rowInd * playField.cols + index
                            readonly property int val: playField.valuesOrder[ind] || 0
                            width: playField.cellSize
                            height: playField.cellSize
                            color: "transparent"
                            Rectangle{
                                id: coloredRect
                                anchors.fill: parent
                                anchors.margins: Math.max(1, playField.cellSize/10)
                                color: Qt.hsla(Math.random(), Math.random(), 0.3, 0.6)
                                border.width: Math.max(1, playField.cellSize/10)
                                border.color: "transparent"
                                radius: border.width
                                smooth: true
                            }
                            Text{
                                id: theText
                                text: ''+parent.val
                                anchors.centerIn: parent
                                color: Utils.mainFrColor
                                font.pixelSize: parent.height / 4
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:
                                    if (playField.checkLogic(parent.val)){
                                        coloredRect.color = "transparent"
                                        theText.visible = false
                                    }
                                    else{
                                        // emit sound
                                    }
                            }
                        }
                    }
                }
            }
        }
        property int lastFoundVal: 0

        StartFinishScreen{
            id: startFinishScreen
            visible: true
        }


        function checkLogic(ind){
            console.log("clicked on " + ind);
            if (lastFoundVal + 1 === ind){
                if (++lastFoundVal === lastValue){
                    stopGame()
                }
                return true
            }
            else return false
        }

        Component.onCompleted:{
            if (theSettings.maxNumber < 4)
                theSettings.maxNumber = 4

            playSizeMenu.fillMenu()
            actionBar.startTimer()
        }

        Component.onDestruction: theSettings.numbersOrder = valuesOrder.join()
    }

    // code to exit on backspace pressed
    Connections {
        target: theMainWindow
        onBackPressed: Qt.quit()
    }
}
