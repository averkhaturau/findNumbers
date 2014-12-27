import QtQuick 2.3
import 'utils.js' as Utils
import "controls"

Rectangle{
    anchors.left: parent.left
    anchors.right: parent.right
    property int defaultHeight: Utils.scaled(33)
    height: visible ? defaultHeight : 0
    onVisibleChanged: height = visible ? defaultHeight : 0

    color: Utils.actionBarColor

    signal actionButtonClicked()

    property string title: ""

    MenuBtn{
        id: actionBtn
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: Utils.scaled(8)
        width: parent.height - 2*anchors.margins

        MouseArea{
            anchors.fill: parent
            onClicked: actionButtonClicked()
        }
    }

    Text{
        anchors.margins: Utils.scaled(8)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: actionBtn.right
        anchors.right: timerView.left

        horizontalAlignment: Text.AlignHCenter

        color: Utils.mainFrColor
        text: title

        font.pixelSize: defaultHeight/3
        font.bold: true
    }

    Rectangle{
        id: timerView
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: parent.height / 10
        radius: parent.height / 5
        color: Utils.mainBgColor
        width: timerText.contentWidth + 2*anchors.margins
        Text {
            id: timerText
            text: "00:00"
            width: contentWidth
            color: Utils.mainFrColor
            font.pixelSize: parent.height*0.9
            anchors.centerIn: parent
        }
        property var startTime: null
        Timer{
            id: timer
            interval: 1000
            repeat : true; running : false; triggeredOnStart : true
            onTriggered: if (typeof timerView.startTime !== "undefined"){
                             var dateDiff = new Date() - timerView.startTime
                             var seconds = Math.floor(dateDiff / 1000) % 60
                             var minutes = Math.floor(dateDiff / 60000)
                             timerText.text = "%1:%2".arg(("00" + minutes).slice (-2)).arg(('00'+seconds).slice(-2))
                         }else{
                             timerText.text = "00:00"
                         }
        }
    }
    function startTimer(){
        console.log("startTimer-begin")
        timerView.startTime = new Date()
        timer.start();
        console.log(typeof timerView.startTime)
        console.log("startTimer-end")
    }
    function stopTimer(){
        timer.stop();
        return new Date() - timerView.startTime
    }
}
