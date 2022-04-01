import QtQuick 2.12
import QtQuick.Controls 2.12

import QtQuick.Window 2.12
import QtMultimedia 5.15

Rectangle {
    color:"gray"
    Camera {
        videoRecorder.audioEncodingMode: CameraRecorder.ConstantBitrateEncoding;
        videoRecorder.audioBitRate: 128000
        videoRecorder.mediaContainer: "mp4"
    }                                                                                   
    Text {
        text:"View_2"
    }
}
