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
                id: grainLossGraph
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
                Layout.preferredWidth: parent.width
                Layout.maximumWidth: parent.width
                Layout.minimumHeight: parent.height / 3 - 5
                graphForegroundDataColor: "lightblue"
                graphForegroundDataName: "Foreign Material"
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
                Layout.preferredWidth: parent.width
                Layout.maximumWidth: parent.width
                Layout.minimumHeight: parent.height / 3 - 5
                graphForegroundDataColor: "tomato"
                graphForegroundDataName: "Broken Grain"
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
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:3}D{i:4}D{i:5}D{i:2}D{i:1}
}
##^##*/
