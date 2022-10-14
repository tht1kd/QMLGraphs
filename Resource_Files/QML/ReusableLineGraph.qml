import QtQuick 2.12
import QtCharts 2.3
import QtGraphicalEffects 1.15

Rectangle {
    //////////////////////////////////////////////////////
    // Properties
    //////////////////////////////////////////////////////
    property alias dataColor: graphData.color
    property alias dataName: graphData.name
    property alias data2Color: graphData2.color
    property alias data2Name: graphData2.name
    property alias series1: graphData
    property alias series2: graphData2
    //////////////////////////////////////////////////////
    /// Sizing
    //////////////////////////////////////////////////////
    //implicitHeight:
    //implicitWidth:
    //////////////////////////////////////////////////////
    /// Creation
    //////////////////////////////////////////////////////
    id: root
    color: chartView.backgroundColor
    function deleteOldData(series)
    {
        if(series.count >=30)
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
    function setNewData(series, newX, newY, newMaxValue)
    {
        series.append(newX+30, newY)
        valueXAxis.min = series.at(0).x
        valueXAxis.max = series.at(series.count-1).x
        valueYAxis.max = newMaxValue
        updateXAxis(30)
    }
    function updateXAxis(newX)
    {
        var maxAxisValue = getAxisValue(newX, false);
        var midAxisValue = getAxisValue(newX, true);
        axisMaxLegend.text = maxAxisValue + getAxisUnit(maxAxisValue)
        axisMidLegend.text = midAxisValue + getAxisUnit(midAxisValue)
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
        animationOptions: ChartView.NoAnimation
        backgroundRoundness: 0
        backgroundColor: "White"
        margins.top: 0
        margins.bottom: 0
        margins.left: 0
        margins.right: 0
        legend.alignment: Qt.AlignBottom
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
        }
        ValueAxis
        {
            id: valueYAxis
            gridVisible: false
            min: 0
            max: 1.2
            tickCount: 2
            color: "gray"
        }
        SplineSeries
        {
            id: graphData
            axisX: valueXAxis
            axisYRight: valueYAxis
        }
        SplineSeries
        {
            id: graphData2
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
            height: 30
            Rectangle
            {
                height: parent.height
                x: valueXAxisLegendLayout.x
                width: 150
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
                width: 150
                x: valueXAxisLegendLayout.x + parseInt(valueXAxisLegendLayout.width/2)
                anchors.horizontalCenter: parent.horizontalCenter
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
                width: 150
                Text
                {
                    text: "0 min"
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignRight
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
