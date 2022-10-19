import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
Row
{
    id: root
    //////////////////////////////////////////////////////
    // Properties
    //////////////////////////////////////////////////////
    property alias graphDataColor: graph.dataColor
    property alias graphDataName: graph.dataName
    property alias graphData2Color: graph.data2Color
    property alias graphData2Name: graph.data2Name
    //////////////////////////////////////////////////////
    /// Sizing
    //////////////////////////////////////////////////////
    //implicitHeight:
    //implicitWidth:
    //////////////////////////////////////////////////////
    /// Creation
    //////////////////////////////////////////////////////
    spacing: 8
    function onDataOneChanged(newX, newY, newMaxValue)
    {
        graph.deleteOldData(graph.series1)
        graph.setNewData(graph.series1, newX, newY, newMaxValue)
        valueText.text = parseFloat(newY).toFixed(1)
    }
    function onDataTwoChanged(newX, newY, newMaxValue)
    {
        graph.deleteOldData(graph.series2)
        graph.setNewData(graph.series2, newX, newY, newMaxValue)
    }
    ColumnLayout
    {
        id: leftButtonsLayout
        width: 120
        height: root.implicitHeight
        spacing: 8
        Button
        {
            id: speedLimit
            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
            Layout.fillWidth: true
            height: graph.height /2 - 8
            background: Rectangle
            {
                color: "white"
                border.color: "black"
                border.width: 2
            }
            RowLayout
            {
                id: speedLimitLayout
                Image
                {
                    source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
                }
                ColumnLayout
                {
                    Text
                    {
                        id: speedLimitValue
                        font.pointSize: 16
                        font.bold: true
                        text: "6.5"
                   }
                    Text
                    {
                        id: speedLimitUnits
                        font.pointSize: 14
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
            height: graph.height /2 - 8
            background: Rectangle
            {
                color: "white"
                border.color: "black"
                border.width: 2
            }
            RowLayout
            {
                id: powerLimitLayout
                Image
                {
                    source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
                }
                ColumnLayout
                {
                    Text
                    {
                        id: powerLimitValue
                        font.pointSize: 16
                        font.bold: true
                        text: "105"
                   }
                    Text
                    {
                        id: powerLimitUnits
                        font.pointSize: 14
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
        anchors.left: graphDataName.anchors.right
        RowLayout
        {
            id: row
            anchors.fill: parent
            spacing: 16
            Rectangle
            {
                id: graphBoundaryBox
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                Layout.fillWidth: true
                border.color: "black"
                color: "transparent"
                height: parent.height
                width: parent.width
                ReusableLineGraph
                {
                    id: graph
                    anchors.fill: parent
                }
            }
        }
    }
    ColumnLayout
    {
        id: rightContainer
        height: root.height
        width: 75
        Button
        {
            id: productivityButton
            background: Rectangle
            {
                color: "white"
                border.color: "black"
                border.width: 2
            }
            height: graph.height / 2
            Layout.preferredHeight: productivityButtonLayout.implicitHeight
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            ColumnLayout
            {
                id: productivityButtonLayout
                spacing: 0
                Text
                {
                    id: valueText
                    text:"---"
                    font.pointSize: 22
                    font.bold: true
                    Layout.fillWidth: true
                }
                Text
                {
                    id: unitsText
                    font.pointSize: 18
                    font.bold: true
                    Layout.fillWidth: true
                    visible: text.length > 0
                    text: "ac/h"
                }
            }
        }
    }
}
