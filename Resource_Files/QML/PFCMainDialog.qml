import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Rectangle {
    id: root
    color: "#F1EFE4"
    border.color: "#ffffff"
    Rectangle
    {
        anchors.fill: parent
        color: "whiteSmoke"       
        ColumnLayout {
            id: layout
            anchors.fill: parent
            spacing: 1
            anchors.margins: 0
            AreaGraphCompoundComponent
            {
                id: areaSeriesOneGraph
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width
                Layout.maximumWidth: parent.width
                Layout.minimumHeight: parent.height / 3 - 5
                graphBackgroundDataColor: "#a900ff"
                graphForegroundDataColor: "#8c00d3"
                graphBackgroundDataName: "MOG Light"
                graphForegroundDataName: "MOG Heavy"
                Connections
                {
                    target: pfcData
                    onAreaSeriesOneUpperValueChanged:
                    {
                       areaSeriesOneGraph.onBackgroundDataChanged(pfcData.areaSeriesOneUpperValue.x, pfcData.areaSeriesOneUpperValue.y, pfcData.areaSeriesOneMaxValue)
                    }
                    onAreaSeriesOneLowerValueChanged:
                    {
                       areaSeriesOneGraph.onForegroundDataChanged(pfcData.areaSeriesOneLowerValue.x, pfcData.areaSeriesOneLowerValue.y, pfcData.areaSeriesOneMaxValue)
                    }
                }
            }
            AreaGraphCompoundComponent
            {
                id: areaSeriesTwoGraph
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width
                Layout.maximumWidth: parent.width
                Layout.minimumHeight: parent.height / 3 - 5
                graphBackgroundDataColor: "lightblue"
                graphForegroundDataColor: "blue"
                graphBackgroundDataName: "Separator Loss"
                graphForegroundDataName: "Grain Loss"
                Connections
                {
                    target: pfcData
                    onAreaSeriesOneUpperValueChanged:
                    {
                       areaSeriesTwoGraph.onBackgroundDataChanged(pfcData.areaSeriesTwoUpperValue.x, pfcData.areaSeriesTwoUpperValue.y, pfcData.areaSeriesTwoMaxValue)
                    }
                    onAreaSeriesOneLowerValueChanged:
                    {
                       areaSeriesTwoGraph.onForegroundDataChanged(pfcData.areaSeriesTwoLowerValue.x, pfcData.areaSeriesTwoLowerValue.y, pfcData.areaSeriesTwoMaxValue)
                    }
                }
            }
            LineGraphCompoundComponent
            {
                id: lineSeriesGraph
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width
                Layout.maximumWidth: parent.width
                Layout.minimumHeight: parent.height / 3 - 5
                graphDataColor: "tomato"
                graphDataName: "Power Target"
                graphData2Color: "lightblue"
                graphData2Name: "Power Rate"
                Connections
                {
                    target: pfcData
                    onLineSeriesOneValueChanged:
                    {
                       lineSeriesGraph.onDataOneChanged(pfcData.lineSeriesOneValue.x, pfcData.lineSeriesOneValue.y, pfcData.lineSeriesOneMax)
                    }
                    onLineSeriesTwoValueChanged:
                    {
                       lineSeriesGraph.onDataTwoChanged(pfcData.lineSeriesTwoValue.x, pfcData.lineSeriesTwoValue.y, pfcData.lineSeriesOneMax)
                    }
                }
            }
     }
}
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:3}D{i:4}D{i:5}D{i:2}D{i:1}
}
##^##*/
