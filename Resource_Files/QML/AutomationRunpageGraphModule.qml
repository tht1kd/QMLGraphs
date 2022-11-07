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
        spacing:8
        Layout.bottomMargin: 8
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
            Layout.fillHeight: true
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.minimumHeight: 100
            Layout.maximumHeight: layout.height / 7 + (6*8)
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
            Layout.fillHeight: true
            Layout.minimumHeight: 100
            Layout.preferredHeight: (root.height - productivityDivider.height - qualityDivider.height - (layout.spacing * 6)) / 6
            Layout.maximumHeight: (root.height - productivityDivider.height - qualityDivider.height - (layout.spacing * 6)) / 6
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            backgroundDataIconLegendSource: "qrc:/PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
            graphBackgroundDataName: "Total (Separator) Loss"
            graphBackgroundDataColor: "#D7D4B8"
            graphBackgroundDataBorderColor: "#D7D4B8"
            graphForegroundDataBrush: ":/PFCApp/Resource_Files/Images/graph_fill_pattern.svg"
            graphForegroundDataName: "Shoe Loss"
            graphForegroundDataBorderColor: "#BFBD99"
            foregroundDataIconLegendSource: "qrc:/PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
            foregroundDataFillPatternLegendSource: "qrc:/PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
            graphName: "Grain Loss"
            graphIconSource: "qrc:/PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
            unitsValue: "%"
            iconLegendVisible: true
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
            Layout.fillHeight: true
            Layout.minimumHeight: 100
            Layout.preferredHeight: (root.height - productivityDivider.height - qualityDivider.height - (layout.spacing * 6)) / 6
            Layout.maximumHeight: (root.height - productivityDivider.height - qualityDivider.height - (layout.spacing * 6)) / 6
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            graphForegroundDataColor: "#D7D4B8"
            graphForegroundDataName: "Foreign Material"
            graphForegroundDataBorderColor: "#D7D4B8"
            graphName: "Foreign Material"
            graphIconSource: "qrc:/PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
            iconLegendVisible: false
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
            Layout.fillHeight: true
            Layout.minimumHeight: 100
            Layout.preferredHeight: (root.height - productivityDivider.height - qualityDivider.height - (layout.spacing * 6)) / 6
            Layout.maximumHeight: (root.height - productivityDivider.height - qualityDivider.height - (layout.spacing * 6)) / 6
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.bottomMargin: 8
            graphForegroundDataColor: "#D7D4B8"
            graphForegroundDataName: "Broken Grain"
            graphForegroundDataBorderColor: "#D7D4B8"
            graphName: "Broken Grain"
            graphIconSource: "qrc:/PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
            iconLegendVisible: false
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
