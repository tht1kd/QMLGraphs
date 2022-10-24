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
    property alias graphForegroundDataBrush: graph.foregroundDataBrush
    property alias graphForegroundDataColor: graph.foregroundDataColor
    property alias graphBackgroundDataName: graph.backgroundDataName
    property alias graphForegroundDataName: graph.foregroundDataName
    property alias dataLabelValue: valueText.text
    property alias unitsValue: unitsText.text;
    property alias graphName: graphDataName.text
    property alias iconLegendVisible: legendImagesContainer.visible
    property alias backgroundDataIconLegendSource: backgroundDataIconLegend.source
    property alias backgroundDataFillPatternLegendSource: backgroundDataFillPatternLegend.source
    property alias foregroundDataIconLegendSource: foregroundDataIconLegend.source
    //////////////////////////////////////////////////////
    /// Sizing
    //////////////////////////////////////////////////////
    //implicitHeight:
    //implicitWidth:
    //////////////////////////////////////////////////////
    /// Creation
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

    Column
    {
        anchors.fill: parent
        Row
        {
            width: parent.width - rightLayout.width
            height: graphDataName.height
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
                Image
                {
                    id: backgroundDataFillPatternLegend
                    height: parent.height
                    width: 25
                    sourceSize: Qt.size(25, parent.height)
                }
                Image
                {
                    id: foregroundDataIconLegend
                    height: parent.height
                    sourceSize: Qt.size(25, parent.height)
                }
                Rectangle
                {
                    id: foregroundDataFillPatternLegend
                    height: parent.height
                    width: 25
                    color: graphForegroundDataColor
                }
            }
        }
        Row
        {
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
                width: 80
            }
            ReusableAreaGraph
            {
                id: graph
                width: root.width - numberBox.implicitWidth - rightLayout.implicitWidth - 16
                height: parent.height
            }
            RowLayout
            {
               id: rightLayout
               height: root.height
               spacing: 8
                Image
                {
                    source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
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
