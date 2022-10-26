import QtCharts 2.3
import QtGraphicalEffects 1.15
import QtQuick 2.12

Rectangle
{
    //////////////////////////////////////////////////////
    // Properties
    //////////////////////////////////////////////////////
    property alias backgroundDataBrush: backgroundData.brushFilename
    property alias backgroundDataColor: backgroundData.color
    property alias foregroundDataBrush: foregroundData.brushFilename
    property alias foregroundDataColor: foregroundData.color
    property alias backgroundDataName: backgroundData.name
    property alias foregroundDataName: foregroundData.name
    property alias backgroundData: backgroundData.upperSeries
    property alias foregroundData: foregroundData.upperSeries
    //////////////////////////////////////////////////////
    /// Sizing
    //////////////////////////////////////////////////////
    implicitHeight: chartView.height + valueXAxisLegendLayout.height
    implicitWidth: limitIcon.width + chartView.width + valueYAxisLegendLayout.width + 24
    //////////////////////////////////////////////////////
    /// Creation
    //////////////////////////////////////////////////////
    id: root
    color: "transparent"

    function deleteOldData(series)
    {
        if(series.count >= 30)
        {
           series.remove(0);
        }
        if(series.count === 0)
        {
            for(var index = 0; index < 30; ++index)
            {
                series.append(index,-1)
            }
        }
    }
    function setNewData(series, newX, newY, maxData)
    {
        series.append(newX+30, newY)
        valueXAxis.min = series.at(0).x
        valueXAxis.max = series.at(series.count-1).x
        valueYAxis.max = maxData
        yAxisMaxLegend.text = (maxData).toFixed(1);
        updateXAxis(30)
    }
    function updateXAxis(newX)
    {
        var maxAxisValue = getAxisValue(newX, false);
        var midAxisValue = getAxisValue(newX, true);
        xAxisMidLegend.text = midAxisValue
        xAxisMaxLegend.text = maxAxisValue + getAxisUnit(midAxisValue)
    }
    function getAxisValue(newXValue, isMidpoint)
    {
        return isMidpoint ? (newXValue >= 30 ? 15 : newXValue/2) : (newXValue >= 30 ? 30 : newXValue)
    }
    function getAxisUnit(newX)
    {
        return newX <= 1 ? " min" : " mins"
    }
    Rectangle
    {
        id: boundingBox
        color: "white"
        border.color: "black"
        height: root.height - valueXAxisLegendLayout.height
        width: root.width - limitIcon.width - valueYAxisLegendLayout.width
        x: limitIcon.width
        ChartView
        {
            id: chartView
            anchors.fill: parent
            antialiasing: true
            backgroundRoundness: 0
            backgroundColor: "transparent"
            legend.visible: false
            anchors { fill: parent; centerIn: parent; margins: -15}
            margins { right: 0; bottom: 0; left: 0; top: 0 }
            ValueAxis
            {
                id: valueXAxis
                gridVisible: false
                reverse: false
                min: 0
                max: 30
                tickCount: 3
                labelsVisible: false
                color: "gray"
                visible:false
            }
            ValueAxis
            {
                id: valueYAxis
                gridVisible: false
                min: 0
                max: 1.2
                tickCount: 2
                labelsVisible: false
                color: "gray"
                visible: false
            }
            AreaSeries
            {
                id: backgroundData
                axisX: valueXAxis
                axisYRight: valueYAxis
                borderColor: "#BFBD99"
                upperSeries: LineSeries {}
            }
            AreaSeries
            {
                id: foregroundData
                axisX: valueXAxis
                axisYRight: valueYAxis
                borderColor: "#D7D4B8"
                upperSeries: LineSeries {}
            }
            Rectangle
            {
                id: valueXAxisLegendLayout
                x: chartView.plotArea.x
                y: chartView.plotArea.y + chartView.plotArea.height + 4
                width: chartView.plotArea.width
                anchors.horizontalCenter: chartView.plotArea.Center
                height: Math.max(xAxisMaxLegendWrapper.height, xAxisMidLegendWrapper.height)
                color: "transparent"
                Rectangle
                {
                    id: xAxisMaxLegendWrapper
                    height: xAxisMaxLegend.height
                    x: valueXAxisLegendLayout.x
                    anchors.left: parent.left
                    width: xAxisMaxLegend.width
                    color: "transparent"
                    Text
                    {
                        id: xAxisMaxLegend
                        horizontalAlignment: Text.AlignLeft
                    }
                }
                Rectangle
                {
                    id: xAxisMidLegendWrapper
                    height: xAxisMidLegend.height
                    width: xAxisMidLegend.width
                    x: valueXAxisLegendLayout.x + parseInt(valueXAxisLegendLayout.width/2)
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    Text
                    {
                        id: xAxisMidLegend
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Rectangle
                {
                    anchors.right: parent.right
                    height: xAxisOriginLegend.height
                    width: xAxisOriginLegend.width
                    color: "transparent"
                    Text
                    {
                        id: xAxisOriginLegend
                        text: "0"
                        horizontalAlignment: Text.AlignRight
                    }
                }
            }
            Rectangle
            {
                id: valueYAxisLegendLayout
                x: chartView.plotArea.x + chartView.plotArea.width + 4
                y: chartView.plotArea.y - 4
                width: Math.max(yAxisMaxLegendWrapper.width, yAxisOriginLegendWrapper.width) + 8
                height: chartView.plotArea.height + 8
                color: "transparent"
                Rectangle
                {
                    id: yAxisMaxLegendWrapper
                    height: yAxisMaxLegend.height
                    anchors.top: parent.top
                    width: yAxisMaxLegend.width
                    color: "transparent"
                    Text
                    {
                        id: yAxisMaxLegend
                        verticalAlignment: Text.AlignTop
                    }
                }
                Rectangle
                {
                    id: yAxisOriginLegendWrapper
                    anchors.bottom: parent.bottom
                    height: yAxisOriginLegend.height
                    width: yAxisOriginLegend.width
                    color: "transparent"
                    Text
                    {
                        id: yAxisOriginLegend
                        text: "0"
                    }
                }
            }
        }
    }
    Image
    {
        id: limitIcon
        source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
        anchors.verticalCenter: indicatorLine.verticalCenter
        anchors.left: root.left
    }
    Rectangle
    {
        id: indicatorLine
        anchors.left: limitIcon.right
        anchors.right: boundingBox.right
        anchors.top: root.top
        anchors.topMargin: root.height - root.height/1.2
        color: "black"
        height: 4
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.25;height:480;width:780}D{i:2}D{i:3}D{i:4}D{i:37}
D{i:1}
}
##^##*/
