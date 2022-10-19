import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
Row {
    id: root
    //////////////////////////////////////////////////////
    // Properties
    //////////////////////////////////////////////////////
    property alias graphBackgroundDataBrush: graph.backgroundDataBrush
    property alias graphBackgroundDataColor: graph.backgroundDataColor
    property alias graphForegroundDataBrush: graph.foregroundDataBrush
    property alias graphForegroundDataColor: graph.foregroundDataColor
    property alias graphBackgroundDataName: graph.backgroundDataName
    property alias graphForegroundDataName: graph.foregroundDataName
    property alias dataLabelValue: valueText.text
    property alias unitsValue: unitsText.text;
    property alias graphName: graphDataName.text
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
        valueText.text = parseFloat(newY).toFixed(1)
    }
    function onForegroundDataChanged(newX, newY, newMaxValue)
    {
        graph.deleteOldData(graph.foregroundData)
        graph.setNewData(graph.foregroundData, newX, newY, newMaxValue)
        valueText.text = parseFloat(newY).toFixed(1)
    }
    Column
    {
        id: graphNameAndMaxLimitButtonLayout
        width: 120
        Text
        {
            id: graphDataName
        }
        Button
        {
            id: numberBox
            text: "1.0%"
            padding: 0
            background: Rectangle
            {
                color: "white"
                border.color: graphForegroundDataColor
                border.width: 2
            }
            height: graph.height /2
            width: 80
        }
    }
    Item
    {
        id: wholeGraph
        height: parent.height
        width: graphNameAndMaxLimitButtonLayout.implicitWidth + row.spacing + graph.width
        anchors.left: graphDataName.anchors.right
        Row
        {
            id: row
            anchors.fill: parent
            spacing: 16
            Rectangle
            {
                id: graphBoundaryBox
                anchors.right: parent.right
                anchors.top: parent.top
                border.color: "black"
                color: "transparent"
                height: root.height
                width: root.width / 2
                ReusableAreaGraph
                {
                    id: graph
                    width: parent.width
                    height: parent.height
                }
            }

            Image
            {
                id: limitIcon
                source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
                anchors.verticalCenter: indicatorLine.verticalCenter
                x: indicatorLine.x - 50
            }
            Rectangle
            {
                id: indicatorLine
                anchors.left: numberBox.right
                anchors.right: graphBoundaryBox.right
                anchors.top: graphBoundaryBox.top
                anchors.topMargin: graphBoundaryBox.height - graphBoundaryBox.height/1.2
                color: "black"
                height: 4
                width: graph.width + row.spacing + 8
            }
        }
    }
    RowLayout
    {
       spacing: 8
        Image
        {
            source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        }
        ColumnLayout
        {
            id: rightContainer
            spacing: 0
            Text
            {
                id: valueText
                text:"---"
                font.pointSize: 22
                font.bold: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            }
            Text
            {
                id: unitsText
                font.pointSize: 18
                font.bold: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                visible: text.length > 0
            }
        }
    }
}
