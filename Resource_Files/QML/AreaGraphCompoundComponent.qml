import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
Row {
    id: root
    //////////////////////////////////////////////////////
    // Properties
    //////////////////////////////////////////////////////
    property alias graphBackgroundDataColor: graph.backgroundDataColor
    property alias graphForegroundDataColor: graph.foregroundDataColor
    property alias graphBackgroundDataName: graph.backgroundDataName
    property alias graphForegroundDataName: graph.foregroundDataName
    property alias dataLabelValue: word.text
    //////////////////////////////////////////////////////
    /// Sizing
    //////////////////////////////////////////////////////
    //implicitHeight:
    //implicitWidth:
    //////////////////////////////////////////////////////
    /// Creation
    //////////////////////////////////////////////////////
    spacing: 8

    function onBackgroundDataChanged(newX, newY, newMaxValue)
    {
        graph.deleteOldData(graph.backgroundData)
        graph.setNewData(graph.backgroundData, newX, newY, newMaxValue)
    }
    function onForegroundDataChanged(newX, newY, newMaxValue)
    {
        graph.deleteOldData(graph.foregroundData)
        graph.setNewData(graph.foregroundData, newX, newY, newMaxValue)
        word.text = parseFloat(newY).toFixed(1) + "%"
    }

    Image {
        id: leftContainer
        source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
    }
    Item {
        id: wholeGraph
        height: parent.height
        width: maxText.implicitWidth + row.spacing + graph.width
        Row {
            id: row
            anchors.fill: parent
            spacing: 16
            Column {
                id: maxAcceptableInput
                height: parent.height
                width: maxText.implicitWidth
                spacing: 8
                Item{
                    id: spacer
                    height: parent.height / 5
                    width: numberBox.width
                }
                Rectangle {
                    id: numberBox
                    anchors.horizontalCenter: parent.horizontalCenter
                    border.color: graphForegroundDataColor
                    border.width: 2
                    height: numberText.implicitHeight + 8
                    width: parent.width - 16
                    Text {
                        id: numberText
                        anchors.fill: parent
                        font.pointSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        text: "1.0%"
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Text {
                    id: maxText
                    font.pointSize: 7
                    horizontalAlignment: Text.AlignHCenter
                    text: "Max Acceptable ⓘ"
                    width: parent.width
                }
            }
            ReusableAreaGraph
            {
                id: graph
                width: root.width - rightContainer.width - maxAcceptableInput.width - leftContainer.width - row.spacing*2
                height: parent.height
            }
        }
        Rectangle {
            id: indicatorLine
            anchors.left: numberBox.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: (numberBox.height / 2) + spacer.height + 4
            color: numberBox.border.color
            height: 2
            width: graph.width + row.spacing + 8
        }
    }
    Column {
        id: rightContainer
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: word
            text:" 0.4%"
            font.pointSize: 22
            font.bold: true
        }
        Image {
            source: "qrc:///PFCApp/Resource_Files/Images/SpeedLimit_50x50.png"
            anchors.horizontalCenter: word.horizontalCenter
        }
    }
}

























//RowLayout {
//    //////////////////////////////////////////////////////
//    // Properties
//    //////////////////////////////////////////////////////
//    property alias graphBackgroundDataColor: graph.backgroundDataColor
//    property alias graphForegroundDataColor: graph.foregroundDataColor
//    property alias graphTitle: graph.title
//    height: 200
//    //////////////////////////////////////////////////////
//    /// Sizing
//    //////////////////////////////////////////////////////
//    //implicitHeight:
//    //implicitWidth:
//    //////////////////////////////////////////////////////
//    /// Creation
//    //////////////////////////////////////////////////////
//    id: layout
//    spacing: 10
//    anchors.margins: 5
//    anchors.leftMargin: 20

//    Image {
//        id: leftSideIcon
//        horizontalAlignment: Image.AlignLeft
//        verticalAlignment: Image.AlignTop
//        source: "tilt_hill.svg"
//        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
////        anchors.TopAnchor: parent.left
//    }
//    ColumnLayout{
//        id: sliderLayout
//        spacing: 5
//        width: graph.implicitWidth + slider.implicitWidth
//        Rectangle {
//           id: slider
//           width: 100
//           height: 50
////           background: Item {
////               anchors.fill: graph
////           }
////                handle: Item {
//                Column
//                {
//                id: sliderColumnLayout
//                spacing: 8
//                height: numberBox.height + maxText.implicitHeight + spacing
//                width: 120
//                Row{
//                    id: row
//                    width: parent.width
//                    height: parent.height
//                    spacing: 8
//                    Rectangle {
//                       id: numberBox
//                       border.width: 2
//                       border.color: graph.backgroundDataColor
//                       width: parent.width + 16
//                       height: parent.height + 16
//                       anchors.horizontalCenter: parent.horizontalCenter
////                       Layout.alignment: Qt.AlignHCenter
//                       Text {
//                         id: numberText
//                         anchors.fill: parent
////                             Layout.fillHeight: parent.width
////                             Layout.fillWidth: parent.height
//                         horizontalAlignment: Text.AlignHCenter
//                         verticalAlignment: Text.AlignVCenter
////                         Layout.alignment:  Qt.AlignCenter
//                         font.pointSize: 20
//                         font.bold: true
//                         text: "1.0%"
//                       }
//                    }
//                }
//                Text {
//                id: maxText
//                width: numberBox.width
//                text: "Max Acceptable ⓘ"
//                font.pointSize: 16
//                horizontalAlignment: Text.AlignHCenter
//                verticalAlignment: Text.AlignVCenter
////                Layout.alignment: Qt.AlignHCenter
//                }
//               }
////            }
//        }
//    }
//    ReusableAreaGraph
//    {
//        id: graph
//        width: (parent.width / 3) -50
//        Layout.fillWidth: true
//        Layout.preferredWidth: (parent.width / 3) -50
//        Layout.maximumWidth: parent.width
//        Layout.minimumHeight: parent.height -5
//    }
//    ColumnLayout{

//        Text{
//            id: rightSideText
//            horizontalAlignment: Text.AlignHCenter
//            verticalAlignment: Text.AlignVCenter
//            font.bold: true
//            font.pointSize: 22
//            text: "0.4%"
//            width: parent.width
//        }
//        Image {
//            id: rightSideIcon
//            source: "tilt_hill.svg"
//            horizontalAlignment: Text.AlignHCenter
//            verticalAlignment: Text.AlignVCenter
//            Layout.alignment: Qt.AlignHCenter
////            anchors.verticalCenter: rightSideText.verticalCenter
////            anchors.top: rightSideText.anchors.bottom + 5
////            anchors.horizontalCenterOffset: 5
//            width: rightSideText.width
//        }
//    }
//}


