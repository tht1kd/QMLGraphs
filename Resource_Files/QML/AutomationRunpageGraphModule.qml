import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
Rectangle
{
    anchors.fill: parent
    color: "whiteSmoke"
    ColumnLayout
    {
        id: layout
        anchors.fill: parent
        Rectangle
        {
            id: productivityDivider
            color: "#BFBD99"
            Layout.fillWidth: true
            height: productivityDividerText.implicitHeight
            Text
            {
                id: productivityDividerText
                anchors.centerIn: parent
                text: "Productivity"
                font.bold: true
            }
        }
        LineGraphCompoundComponent
        {
            id: productivityGraph
            graphSeries1Color: "black"
            Layout.fillWidth: true
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.minimumHeight: 100
            Layout.maximumHeight: 200
            Connections
            {
                target: pfcData
                onProductivityValueChanged:
                {
                   productivityGraph.onSeriesOneChanged(pfcData.productivityValue.x, pfcData.productivityValue.y, pfcData.productivityMaxValue)
                }
            }
        }
        Rectangle
        {
            id: qualityDivider
            color: "#BFBD99"
            Layout.fillWidth: true
            height: qualityDividerText.implicitHeight
            Text
            {
                id: qualityDividerText
                anchors.centerIn: parent
                text: "Job Quality"
                font.bold: true
            }
        }
        AreaGraphCompoundComponent
        {
            id: grainLossGraph
            Layout.fillWidth: true
            Layout.minimumHeight: 100
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            graphBackgroundDataBrush: ":/PFCApp/Resource_Files/Images/graph_fill_pattern.svg"
            graphForegroundDataColor: "#D7D4B8"
            graphBackgroundDataName: "MOG Light"
            graphForegroundDataName: "MOG Heavy"
            graphName: "Grain Loss"
            unitsValue: "%"
            Connections
            {
                target: pfcData
                onGrainLossBackgroundDataValueChanged:
                {
                   grainLossGraph.onBackgroundDataChanged(pfcData.grainLossBackgroundDataValue.x, pfcData.grainLossBackgroundDataValue.y, pfcData.grainLossMaxValue)
                }
                onGrainLossForegroundDataValueChanged:
                {
                   grainLossGraph.onForegroundDataChanged(pfcData.grainLossForegroundDataValue.x, pfcData.grainLossForegroundDataValue.y, pfcData.grainLossMaxValue)
                }
            }
        }
        AreaGraphCompoundComponent
        {
            id: foreignMaterialGraph
            Layout.fillWidth: true
            Layout.minimumHeight: 100
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            graphForegroundDataColor: "#D7D4B8"
            graphForegroundDataName: "Foreign Material"
            graphName: "Foreign Material"
            Connections
            {
                target: pfcData
                onForeignMaterialValueChanged:
                {
                   foreignMaterialGraph.onForegroundDataChanged(pfcData.foreignMaterialValue.x, pfcData.foreignMaterialValue.y, pfcData.foreignMaterialMaxValue)
                }
            }
        }
        AreaGraphCompoundComponent
        {
            id: brokenGrainGraph
            Layout.fillWidth: true
            Layout.minimumHeight: 100
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            graphForegroundDataColor: "#D7D4B8"
            graphForegroundDataName: "Broken Grain"
            graphName: "Broken Grain"
            Connections
            {
                target: pfcData
                onBrokenGrainValueChanged:
                {
                   brokenGrainGraph.onForegroundDataChanged(pfcData.brokenGrainValue.x, pfcData.brokenGrainValue.y, pfcData.brokenGrainMaxValue)
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
