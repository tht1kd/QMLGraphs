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
    property alias series1: series1
    property alias series2: series2
    //////////////////////////////////////////////////////
    /// Sizing
    //////////////////////////////////////////////////////
    //implicitHeight:
    //implicitWidth:
    //////////////////////////////////////////////////////
    /// Creation
    //////////////////////////////////////////////////////
    id: root
    border.color: "black"
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
        axisYMaxLegend.text = (maxData).toFixed(1);
        updateXAxis(30)
    }
    function updateXAxis(newX)
    {
        var maxAxisValue = getAxisValue(newX, false);
        var midAxisValue = getAxisValue(newX, true);
        axisMidLegend.text = midAxisValue
        axisMaxLegend.text = maxAxisValue + getAxisUnit(midAxisValue)
    }
    function getAxisValue(newXValue, isMidpoint)
    {
        return isMidpoint ? (newXValue >= 30 ? 15 : newXValue/2) : (newXValue >= 30 ? 30 : newXValue)
    }
    function getAxisUnit(newX)
    {
        return newX <= 1 ? " min" : " mins"
    }

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
        SplineSeries
        {
            id: series1
            axisX: valueXAxis
            axisYRight: valueYAxis
        }
        SplineSeries
        {
            id: series2
            axisX: valueXAxis
            axisYRight: valueYAxis
        }
        Row
        {
            id: valueXAxisLegendLayout
            x: chartView.plotArea.x
            y: chartView.plotArea.y + chartView.plotArea.height + 5
            width: chartView.plotArea.width
            anchors.horizontalCenter: chartView.plotArea.Center
            height: 20
            Rectangle
            {
                height: parent.height
                x: valueXAxisLegendLayout.x
                anchors.left: parent.left
                width: 50
                color: "transparent"
                Text
                {
                    id: axisMaxLegend
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                }
            }
            Rectangle
            {
                height: parent.height
                width: 50
                x: valueXAxisLegendLayout.x + parseInt(valueXAxisLegendLayout.width/2)
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                Text
                {
                    id: axisMidLegend
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle
            {
                anchors.right: parent.right
                height: parent.height
                width: 50
                color: "transparent"
                Text
                {
                    text: "0"
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignRight
                }
            }
        }
        Column
        {
            id: valueYAxisLegendLayout
            x: chartView.plotArea.x + chartView.plotArea.width + 4
            y: chartView.plotArea.y - 8
            width: 50
            anchors.horizontalCenter: chartView.plotArea.Center
            height: chartView.plotArea.height + 8
            Rectangle
            {
                height: 20
                anchors.top: parent.top
                width: parent.width
                color: "transparent"
                Text
                {
                    id: axisYMaxLegend
                    anchors.fill: parent
                    verticalAlignment: Text.AlignTop
                }
            }
            Rectangle
            {
                anchors.bottom: parent.bottom
                height: 20
                width: parent.width
                color: "transparent"
                Text
                {
                    text: "0"
                    anchors.fill: parent
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
