import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
Item
{
    id: root
    //////////////////////////////////////////////////////
    // Properties
    //////////////////////////////////////////////////////
    property alias graphBackgroundDataBrush: graph.backgroundDataBrush
    property alias graphBackgroundDataColor: graph.backgroundDataColor
    property alias graphBackgroundDataBorderColor: graph.backgroundDataBorderColor
    property alias graphBackgroundDataName: graph.backgroundDataName
    property alias graphForegroundDataBrush: graph.foregroundDataBrush
    property alias graphForegroundDataColor: graph.foregroundDataColor
    property alias graphForegroundDataBorderColor: graph.foregroundDataBorderColor
    property alias graphForegroundDataName: graph.foregroundDataName
    property alias dataLabelValue: valueText.text
    property alias unitsValue: unitsText.text;
    property alias graphName: graphDataName.text
    property alias iconLegendVisible: legendImagesContainer.visible
    property alias backgroundDataIconLegendSource: backgroundDataIconLegend.source
    property alias foregroundDataIconLegendSource: foregroundDataIconLegend.source
    property alias foregroundDataFillPatternLegendSource: foregroundDataFillPatternLegend.source
    property alias graphIconSource: graphIcon.source
    //////////////////////////////////////////////////////
    /// Sizing
    //////////////////////////////////////////////////////
//    implicitHeight: graphNameAndLegendLayout.height + graphLayout.height
//    implicitWidth: numberBox.width + Math.max(graphNameAndLegendLayout.width, graph.width) + rightLayout.width
    anchors.leftMargin: 8
    anchors.rightMargin: 8

    //////////////////////////////////////////////////////
    /// Functions
    //////////////////////////////////////////////////////
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

    //////////////////////////////////////////////////////
    /// Creation
    //////////////////////////////////////////////////////
    Row
    {
        spacing: 8
        Column
        {
            id: graphNameAndLegendLayout
            Row
            {
                width: legendImagesContainer.width - 8 + graph.width - 56
                height: graphDataName.height
                spacing: 8
                Text
                {
                    id: graphDataName
                    width: parent.width - legendImagesContainer.width + 8
                }
                Row
                {
                    id: legendImagesContainer
                    height: parent.height
                    Image
                    {
                        id: backgroundDataIconLegend
                        height: parent.height
                        sourceSize: Qt.size(25, parent.height)
                    }
                    Rectangle
                    {
                        id: backgroundDataFillPatternLegend
                        height: parent.height
                        width: 25
                        color: graphBackgroundDataColor
                    }
                    Image
                    {
                        id: foregroundDataIconLegend
                        height: parent.height
                        sourceSize: Qt.size(25, parent.height)
                    }
                    Image
                    {
                        id: foregroundDataFillPatternLegend
                        height: parent.height
                        width: 25
                        sourceSize: Qt.size(25, 25)
                    }
                }
            }
            Row
            {
                id: graphLayout
                spacing: 8
                Button
                {
                    id: numberBox
                    text: "1.0%"
                    font.bold: true
                    padding: 0
                    background: Rectangle
                    {
                        color: "white"
                        border.color: "black"
                        border.width: 2
                    }
                    height: graph.height /2
                    width: 90
                }
                ReusableAreaGraph
                {
                    id: graph
                    width: root.width - numberBox.width - rightLayout.implicitWidth - 16
                    height: parent.height
                }
                RowLayout
                {
                   id: rightLayout
                   height: root.height
                   spacing: 8
                    Image
                    {
                        id: graphIcon
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        sourceSize: Qt.size(40,40)
                    }
                    ColumnLayout
                    {
                        id: rightValueLayout
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
        }
    }

}
