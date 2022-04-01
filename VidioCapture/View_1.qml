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
                ListView {
                    id:cameraInfoGrid
                    width : parent.width
                    height: 200
                    spacing:5
                    model:VideoSourceService.camerasInfo
                    delegate: Item{
                        width:parent.width
                        height:50
                        Button {
                            anchors.fill: parent
                            text:"set:"+modelData.description
                            onClicked: {
                                VideoSourceService.setCameraDeviceID(modelData.id)
                            }
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
