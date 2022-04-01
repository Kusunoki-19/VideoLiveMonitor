import QtQuick 2.12
import QtQuick.Controls 2.12

import QtQuick.Window 2.12
import QtMultimedia 5.15

Window {
    width: 640
    height: 480
    visible: true

    Loader {
        anchors.fill: parent
        id: cameraComponentLoader
        sourceComponent: cameraComponent
        asynchronous: true // 非同期読み込み.
        active: true // is Load Component.
    }

    Component {
        id: cameraComponent
        View_1 {
            anchors.fill: parent
        }
        // View_2 {
        // }

    }
}
