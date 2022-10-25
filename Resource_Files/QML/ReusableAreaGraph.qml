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
    //implicitHeight:
    //implicitWidth:
    //////////////////////////////////////////////////////
    /// Creation
    //////////////////////////////////////////////////////
    id: root
//    color: "transparent"
    color: "green"
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
    Rectangle
    {
        id: boundaryBox
        border.color: "black"
        color: "blue"
        width: root.width - limitIcon.width
        height: root.height

        ChartView
        {
            id: chartView
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
//                x: chartView.plotArea.x
                y: chartView.plotArea.y + chartView.plotArea.height + 5
                width: chartView.plotArea.width
                anchors.left: chartView.left
                anchors.right: chartView.right
                anchors.horizontalCenter: chartView.plotArea.Center
                height: 20
                color: "red"
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
//                        anchors.fill: parent
                        height: parent.height
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
                        height: parent.height
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
                        height: parent.height
                        horizontalAlignment: Text.AlignRight
                    }
                }
            }
            Rectangle
            {
                id: valueYAxisLegendLayout
//                x: chartView.plotArea.x + chartView.plotArea.width + 4
//                y: chartView.plotArea.y - 8
                width: 50
                anchors.left: chartView.right
                anchors.right: root.right
                anchors.top: chartView.top
                anchors.bottom: chartView.bottom
                anchors.horizontalCenter: chartView.Center
                height: boundaryBox.height
                color: "red"
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
        Image
        {
            id: limitIcon
            source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
            anchors.verticalCenter: indicatorLine.verticalCenter
            anchors.right: boundaryBox.left
        }
        Rectangle
        {
            id: indicatorLine
            anchors.left: limitIcon.right
            anchors.right: boundaryBox.right
            anchors.top: boundaryBox.top
            anchors.topMargin: boundaryBox.height - boundaryBox.height/1.2
            color: "black"
            height: 4
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.25;height:480;width:780}D{i:2}D{i:3}D{i:4}D{i:37}
D{i:1}
}
##^##*/
