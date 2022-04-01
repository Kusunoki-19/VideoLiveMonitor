import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtMultimedia 5.15
import VideoSourceComponents 1.0

Rectangle {
    color:"white"

    GridLayout {
        id:grid
        width :parent.width  + this.columnSpacing
        height:parent.height + this.rowSpacing
        columns : 3 + 1 // 列数.
        rows    : 2 + 1 // 行数.

        rowSpacing   : 5
        columnSpacing: 5

        // meta item.
        Item { Layout.row:parent.rows - 1;         Layout.column:parent.columns - 1;        Layout.fillHeight: false;   Layout.fillWidth: false;  implicitWidth:0; implicitHeight: 0;}
        // 列設定.
        Item { Layout.row:parent.rows - 1;/* ↓ */ Layout.column:0;                 /* → */ id:c0;implicitWidth: 150;                                                           implicitHeight:0; Layout.fillHeight: true;    Layout.fillWidth: false; }
        Item { Layout.row:parent.rows - 1;/* ↓ */ Layout.column:1;                 /* → */ id:c1;implicitWidth: (parent.height - c0.implicitWidth) / 2 - parent.columnSpacing; implicitHeight:0; Layout.fillHeight: true;    Layout.fillWidth: false; }
        Item { Layout.row:parent.rows - 1;/* ↓ */ Layout.column:2;                 /* → */ id:c2;implicitWidth: (parent.height - c0.implicitWidth) / 2 - parent.columnSpacing; implicitHeight:0; Layout.fillHeight: true;    Layout.fillWidth: false; }
        // 行設定.
        Item { Layout.row:0;              /* ↓ */ Layout.column:parent.columns - 1;/* → */ id:r0;implicitHeight: parent.height -  r1.implicitHeight - parent.rowSpacing;        implicitWidth:0;  Layout.fillHeight: false;   Layout.fillWidth: true;  }
        Item { Layout.row:1;              /* ↓ */ Layout.column:parent.columns - 1;/* → */ id:r1;implicitHeight: 100;                                                           implicitWidth:0;  Layout.fillHeight: false;   Layout.fillWidth: true;  }

        Rectangle { Layout.row:0;/* ↓ */    Layout.column:0;/* → */ Layout.fillHeight: true;    Layout.fillWidth: true; color:"gray";
            Layout.rowSpan:2
            // devicd list.
            Column {
                id:propertiesColumn
                width : parent.width
                Text { text:"View_1" }
                Text {
                    text:"available cameras"
                    font.bold:true
                }
                Text {
                    width : parent.width
                    text:"current camera properties \n" +
                         "deviceID:" + camera.deviceId
                    font.bold:true
                    wrapMode: Text.WrapAnywhere
                }
                GridView {
                    id:cameraInfoGrid
                    width : parent.width
                    height: cellHeight * QtMultimedia.availableCameras.length * 4
                    cellHeight: 20
                    cellWidth: parent.width
                    model:QtMultimedia.availableCameras.length * 4
                    delegate: Item{
                        width:cameraInfoGrid.cellWidth
                        height:cameraInfoGrid.cellHeight
                        Button {
                            anchors.fill: parent
                            visible: index%4 === 0
                            onClicked: {
                                console.log("onselected QtMultimedia.availableCameras[~~(index/4)].deviceId")
                                camera.deviceId = QtMultimedia.availableCameras[~~(index/4)].deviceId
                            }
                        }
                        Text {
                            visible: index%4 === 0
                            text: "* deviceID:"       + QtMultimedia.availableCameras[~~(index/4)].deviceId
                            anchors.fill: parent
                            wrapMode: Text.NoWrap
                            elide: Text.ElideRight
                        }
                        Text {
                            visible: index%4 === 1
                            text: "    displayName:"  + QtMultimedia.availableCameras[~~(index/4)].displayName
                            anchors.fill: parent
                            wrapMode: Text.NoWrap
                            elide: Text.ElideRight
                        }
                        Text {
                            visible: index%4 === 2
                            text: "    position:"     + QtMultimedia.availableCameras[~~(index/4)].position
                            anchors.fill: parent
                            wrapMode: Text.NoWrap
                            elide: Text.ElideRight
                        }
                        Text {
                            visible: index%4 === 3
                            text: "    orientation:"  + QtMultimedia.availableCameras[~~(index/4)].orientation
                            anchors.fill: parent
                            wrapMode: Text.NoWrap
                            elide: Text.ElideRight
                        }
                    }
                }


            }
        }

        Rectangle { Layout.row:0;/* ↓ */    Layout.column:1;/* → */ Layout.fillHeight: true;    Layout.fillWidth: true; color:"gray";
            // camera source (invisible).
            Layout.columnSpan: 2
            Camera {
                id: camera
                deviceId: "" // set by user.
                onDeviceIdChanged:  {
                    console.log("deviceIdChanged to " + deviceId)
                }

                captureMode: Camera.CaptureVideo
                Component.onCompleted: {
                    VideoSourceService.setMonitorSource(this)
                }
            }

            // media display.
            VideoOutput {
                id:videoMonitor
                source: camera
                anchors.fill: parent
            }
        }

        Rectangle { Layout.row:1;/* ↓ */    Layout.column:1;/* → */ Layout.fillHeight: true;    Layout.fillWidth: true; color:"gray";
            VideoOutput {
                source: videoMonitor.videoSurface
                anchors.fill: parent
            }
        }
        Rectangle { Layout.row:1;/* ↓ */    Layout.column:2;/* → */ Layout.fillHeight: true;    Layout.fillWidth: true; color:"gray";
            VideoOutput {
                source: camera
                anchors.fill: parent
            }
        }

    }



}
