import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
Row
{
    id: root
    //////////////////////////////////////////////////////
    // Properties
    //////////////////////////////////////////////////////
    property alias graphSeries1Color: graph.series1Color
    property alias graphSeries1Name: graph.series1Name
    property alias graphSeries2Color: graph.series2Color
    property alias graphSeries2Name: graph.series2Name
    //////////////////////////////////////////////////////
    /// Sizing
    //////////////////////////////////////////////////////
    //implicitHeight:
    //implicitWidth:
    //////////////////////////////////////////////////////
    /// Creation
    //////////////////////////////////////////////////////
    spacing: 8
    anchors.leftMargin: 8
    anchors.rightMargin: 8

    function onSeriesOneChanged(newX, newY, newMaxValue)
    {
        graph.deleteOldData(graph.series1)
        graph.setNewData(graph.series1, newX, newY, newMaxValue)
        valueText.text = parseFloat(newY).toFixed(1)
    }
    function onSeriesTwoChanged(newX, newY, newMaxValue)
    {
        graph.deleteOldData(graph.series2)
        graph.setNewData(graph.series2, newX, newY, newMaxValue)
    }

    Column
    {
        id: leftButtonsLayout
        width: 120
        height: root.implicitHeight
        spacing: 8
        Button
        {
            id: speedLimit
            height: speedLimitLayout.implicitHeight
            width: parent.width
            background: Rectangle
            {
                color: "white"
                border.color: "black"
                border.width: 2
            }
            RowLayout
            {
                id: speedLimitLayout
                width:parent.width
                Image
                {
                    source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
                }
                ColumnLayout
                {
                    Text
                    {
                        id: speedLimitValue
                        font.pointSize: 12
                        font.bold: true
                        text: "6.5"
                   }
                    Text
                    {
                        id: speedLimitUnits
                        font.pointSize: 10
                        font.bold: true
                        text: "mi/h"
                   }
                }
            }
        }
        Button
        {
            id: powerLimit
            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
            Layout.fillWidth: true
            height: powerLimitLayout.implicitHeight
            width: parent.width
            background: Rectangle
            {
                color: "white"
                border.color: "black"
                border.width: 2
            }
            RowLayout
            {
                id: powerLimitLayout
                width:parent.width
                Image
                {
                    source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
                }
                ColumnLayout
                {
                    Text
                    {
                        id: powerLimitValue
                        font.pointSize: 12
                        font.bold: true
                        text: "105"
                   }
                    Text
                    {
                        id: powerLimitUnits
                        font.pointSize: 10
                        font.bold: true
                        text: "%"
                   }
                }
            }
        }
    }
    Item
    {
        id: wholeGraph
        height: root.height
        width: root.width - leftButtonsLayout.width - rightContainer.width - 100
//        anchors.left: graphSeries1Name.anchors.right
        anchors.leftMargin: 70
        Row
        {
            id: row
            anchors.fill: parent
            spacing: 16
            Rectangle
            {
                id: graphBoundaryBox
                Layout.fillWidth: true
                border.color: "black"
                color: "transparent"
                height: parent.height
                width: root.width /2
                ReusableLineGraph
                {
                    id: graph
                    width: parent.width
                    height: parent.height
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.fill: parent
                    series1Color: "black"
                }
            }
        }
    }
    ColumnLayout
    {
        anchors.left: wholeGraph.anchors.right + 32
        spacing: 8
        id: rightContainer
        height: root.height
        width: 150
        Button
        {
            id: productivityButton
            background: Rectangle
            {
                color: "white"
                border.color: "black"
                border.width: 2
            }
            width: parent.width
            height: wholeGraph.height / 2
            Layout.preferredHeight: productivityButtonLayout.implicitHeight
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            ColumnLayout
            {
                id: productivityButtonLayout
                spacing: 0
                width: parent.width
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                Text
                {
                    id: valueText
                    text:"---"
                    font.pointSize: 22
                    font.bold: true
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                }
                Text
                {
                    id: unitsText
                    font.pointSize: 18
                    font.bold: true
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                    visible: text.length > 0
                    text: "ac/h"
                }
            }
        }
    }
}
