import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
Row {
    id: root
    //////////////////////////////////////////////////////
    // Properties
    //////////////////////////////////////////////////////
    property alias graphBackgroundDataColor: graph.backgroundDataColor
    property alias graphForegroundDataColor: graph.foregroundDataColor
    property alias graphBackgroundDataName: graph.backgroundDataName
    property alias graphForegroundDataName: graph.foregroundDataName
    property alias dataLabelValue: word.text
    //////////////////////////////////////////////////////
    /// Sizing
    //////////////////////////////////////////////////////
    //implicitHeight:
    //implicitWidth:
    //////////////////////////////////////////////////////
    /// Creation
    //////////////////////////////////////////////////////
    spacing: 8

    function onBackgroundDataChanged(newX, newY, newMaxValue)
    {
        graph.deleteOldData(graph.backgroundData)
        graph.setNewData(graph.backgroundData, newX, newY, newMaxValue)
    }
    function onForegroundDataChanged(newX, newY, newMaxValue)
    {
        graph.deleteOldData(graph.foregroundData)
        graph.setNewData(graph.foregroundData, newX, newY, newMaxValue)
        word.text = parseFloat(newY).toFixed(1) + "%"
    }

    Image {
        id: leftContainer
        source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
    }
    Item {
        id: wholeGraph
        height: parent.height
        width: maxText.implicitWidth + row.spacing + graph.width
        Row {
            id: row
            anchors.fill: parent
            spacing: 16
            Column {
                id: maxAcceptableInput
                height: parent.height
                width: maxText.implicitWidth
                spacing: 8
                Item{
                    id: spacer
                    height: parent.height / 5
                    width: numberBox.width
                }
                Rectangle {
                    id: numberBox
                    anchors.horizontalCenter: parent.horizontalCenter
                    border.color: graphForegroundDataColor
                    border.width: 2
                    height: numberText.implicitHeight + 8
                    width: parent.width - 16
                    Text {
                        id: numberText
                        anchors.fill: parent
                        font.pointSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        text: "1.0%"
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Text {
                    id: maxText
                    font.pointSize: 7
                    horizontalAlignment: Text.AlignHCenter
                    text: "Max Acceptable ⓘ"
                    width: parent.width
                }
            }
            ReusableAreaGraph
            {
                id: graph
                width: root.width - rightContainer.width - maxAcceptableInput.width - leftContainer.width - row.spacing*2
                height: parent.height
            }
        }
        Rectangle {
            id: indicatorLine
            anchors.left: numberBox.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: (numberBox.height / 2) + spacer.height + 4
            color: "black"
            height: 2
            width: graph.width + row.spacing + 8
        }
    }
    Column {
        id: rightContainer
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: word
            text:" 0.4%"
            font.pointSize: 22
            font.bold: true
        }
        Image {
            source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
            anchors.horizontalCenter: word.horizontalCenter
        }
    }
}
