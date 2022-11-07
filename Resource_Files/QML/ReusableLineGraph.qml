import QtCharts 2.3
import QtGraphicalEffects 1.15
import QtQuick 2.12

Rectangle
{
    //////////////////////////////////////////////////////
    // Properties
    //////////////////////////////////////////////////////
    property alias series1Color: series1.color
    property alias series1Name: series1.name
    property alias series2Color: series2.color
    property alias series2Name: series2.name
    property alias exposedSeries1: series1
    property alias exposedSeries2: series2

    readonly property int numberOfDataPoints: 120
    //////////////////////////////////////////////////////
    /// Sizing
    //////////////////////////////////////////////////////
    implicitHeight: chartView.height + valueXAxisLegendLayout.height
    implicitWidth: chartView.width + valueYAxisLegendLayout.width + 16
    //////////////////////////////////////////////////////
    /// Creation
    //////////////////////////////////////////////////////
    id: root
    color: "green"

    function deleteOldData(series)
    {
        if(series.count >= numberOfDataPoints)
        {
           series.remove(0);
        }
        if(series.count === 0)
        {
            for(var index = 0; index < numberOfDataPoints; ++index)
            {
                series.append(index,-1)
            }
        }
    }
    function setNewData(series, newX, newY, maxData)
    {
        series.append(newX+numberOfDataPoints, newY)
        valueXAxis.min = series.at(0).x
        valueXAxis.max = series.at(series.count-1).x
        valueYAxis.max = maxData
        yAxisMaxLegend.text = (maxData).toFixed(1);
        updateXAxis(numberOfDataPoints)
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
        return isMidpoint ? numberOfDataPoints/2 : numberOfDataPoints
    }
    function getAxisUnit(newX)
    {
        return newX <= 1 ? " min" : " mins"
    }
    Rectangle
    {
        id: boundingBox
        color: "blue"
        border.color: "black"
        height: root.height - valueXAxisLegendLayout.height
        width: root.width - valueYAxisLegendLayout.width
        ChartView
        {
            id: chartView
            anchors.fill: parent
            antialiasing: true
            backgroundRoundness: 0
            backgroundColor: "white"
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
            SplineSeries
            {
                id: series1
                axisX: valueXAxis
                axisYRight: valueYAxis
                width: 3
            }
            SplineSeries
            {
                id: series2
                axisX: valueXAxis
                axisYRight: valueYAxis
                width: 3
            }
            Rectangle
            {
                id: valueXAxisLegendLayout
                x: chartView.plotArea.x
                y: chartView.plotArea.y + chartView.plotArea.height + 4
                width: chartView.plotArea.width
                anchors.horizontalCenter: chartView.plotArea.Center
                height: Math.max(xAxisMaxLegendWrapper.height, xAxisMidLegendWrapper.height)
                color: "red"
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
                color: "red"
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
}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.25;height:480;width:780}D{i:2}D{i:3}D{i:4}D{i:1}
}
##^##*/
