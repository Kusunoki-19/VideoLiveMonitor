import QtQuick 2.0
import QtQuick.Layouts 1.12

Item {

    GridLayout {
        anchors.fill: parent
        columns : 3 + 1 // 列数.
        rows    : 2 + 1 // 行数.

        // meta item.
        Item { Layout.row:0; Layout.column:0; Layout.fillHeight: false; Layout.fillWidth: false; }
        // 列設定.
        Item { Layout.row:0;/* ↓ */ Layout.column:1;/* → */ Layout.fillHeight: true; Layout.fillWidth: false; }
        Item { Layout.row:0;/* ↓ */ Layout.column:2;/* → */ Layout.fillHeight: true; Layout.fillWidth: false; }
        Item { Layout.row:0;/* ↓ */ Layout.column:3;/* → */ Layout.fillHeight: true; Layout.fillWidth: false; }
        // 行設定.
        Item { Layout.row:1;/* ↓ */ Layout.column:0;/* → */ Layout.fillHeight: false; Layout.fillWidth: true; }
        Item { Layout.row:2;/* ↓ */ Layout.column:0;/* → */ Layout.fillHeight: false; Layout.fillWidth: true; }

    }
}
