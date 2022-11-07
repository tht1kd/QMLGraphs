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
    spacing: 8
    anchors.leftMargin: 8
    anchors.rightMargin: 8
    //////////////////////////////////////////////////////
    /// Functions
    //////////////////////////////////////////////////////

    function onSeriesOneChanged(newX, newY, newMaxValue)
    {
        graph.deleteOldData(graph.exposedSeries1)
        graph.setNewData(graph.exposedSeries1, newX, newY, newMaxValue)
        valueText.text = parseFloat(newY).toFixed(1)
    }
    function onSeriesTwoChanged(newX, newY, newMaxValue)
    {
        graph.deleteOldData(graph.exposedSeries2)
        graph.setNewData(graph.exposedSeries2, newX, newY, newMaxValue)
    }

    //////////////////////////////////////////////////////
    /// Creation
    //////////////////////////////////////////////////////
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
            width: parent.width - 8
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
                spacing: 0
                Image
                {
                    source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
                    sourceSize: Qt.size(40,40)
                }
                ColumnLayout
                {
                    spacing:0
                    Text
                    {
                        id: speedLimitValue
                        font.pointSize: 12
                        font.bold: true
                        text: "6.5"
                        Layout.rightMargin: 8
                        Layout.fillWidth: true
                   }
                    Text
                    {
                        id: speedLimitUnits
                        font.pointSize: 10
                        font.bold: true
                        text: "mi/h"
                        verticalAlignment: Qt.AlignTop
                        Layout.rightMargin: 8
                        Layout.fillWidth: true
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
            width: parent.width - 8
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
                spacing: 0
                Image
                {
                    source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
                    sourceSize: Qt.size(40,40)
                }
                ColumnLayout
                {
                    spacing:0
                    Text
                    {
                        id: powerLimitValue
                        font.pointSize: 12
                        font.bold: true
                        text: "105"
                        Layout.rightMargin: 8
                        Layout.fillWidth: true
                   }
                    Text
                    {
                        id: powerLimitUnits
                        font.pointSize: 10
                        font.bold: true
                        text: "%"
                        Layout.rightMargin: 8
                        Layout.fillWidth: true
                   }
                }
            }
        }
    }
    ReusableLineGraph
    {
        id: graph
        width: root.width - leftButtonsLayout.width - rightLayout.width - 16
        height: parent.height
    }
    ColumnLayout
    {
        spacing: 8
        id: rightLayout
        width: 120
        height: root.height
        Button
        {
            id: productivityButton
            background: Rectangle
            {
                color: "white"
                border.color: "black"
                border.width: 2
            }
            width: parent.width - 8
            height: parent.height / 2.5
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
