import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtCharts 2.3

Rectangle {
    //////////////////////////////////////////////////////
    // Properties
    //////////////////////////////////////////////////////
    property alias backgroundDataColor: backgroundData.color
    property alias foregroundDataColor: foregroundData.color
    property alias backgroundDataName: backgroundData.name
    property alias foregroundDataName: foregroundData.name
    property alias backgroundData: backgroundData.upperSeries
    property alias foregroundData: foregroundData.upperSeries
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
    function setNewData(series, newX, newY, maxData)
    {
        series.append(newX+30, newY)
        valueXAxis.min = series.at(0).x
        valueXAxis.max = series.at(series.count-1).x
        valueYAxis.max = maxData
        updateXAxis(30)
    }
    function updateXAxis(newX)
    {
        var maxAxisValue = getAxisValue(newX, false);
        var midAxisValue = getAxisValue(newX, true);
        axisMaxLegend.text = maxAxisValue + getAxisUnit(maxAxisValue)
        axisMidLegend.text = midAxisValue
    }
    function getAxisValue(newXValue, isMidpoint)
    {
        return isMidpoint ? (newXValue >= 30 ? 15 : newXValue/2) : (newXValue >= 30 ? 30 : newXValue)
    }
    function getAxisUnit(newX)
    {
        return newX <= 1 ? " min" : " mins"
    }

    ChartView {
        id: chartView
        anchors.fill: parent
        antialiasing: true
        backgroundRoundness: 0
        backgroundColor: "White"
        margins.top: 0
        margins.bottom: 0
        margins.left: 0
        margins.right: 0
        legend.visible: false
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
        AreaSeries {
            id: backgroundData
            name: backgroundDataName
            axisX: valueXAxis
            axisYRight: valueYAxis
            borderColor: color
            upperSeries: LineSeries {
            }
        }
        AreaSeries {
            id: foregroundData
            name: foregroundDataName
            axisX: valueXAxis
            axisYRight: valueYAxis
            borderColor: color
            upperSeries: LineSeries {
             }
        }
        Row
        {
            id: valueXAxisLegendLayout
            x: chartView.plotArea.x
            y: chartView.plotArea.y + chartView.plotArea.height + 5
            width: chartView.plotArea.width
            height: 20
            Rectangle
            {
                height: parent.height
                x: valueXAxisLegendLayout.x
                anchors.left: parent.left
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
                    text: "0"
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignRight
                }
            }
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.25;height:480;width:780}D{i:2}D{i:3}D{i:4}D{i:37}
D{i:1}
}
##^##*/
