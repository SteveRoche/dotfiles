import QtQuick
import QtQuick.Layouts
import Quickshell

Scope {
  id: bar

  PanelWindow {
    color: "white"

    anchors {
      right: true
      top: true
      bottom: true
    }

    implicitWidth: 30

    Item {
      id: barContent

      implicitWidth: 30

      component BarSeparator: Rectangle {
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        Layout.fillWidth: true

        implicitHeight: 2
        color: "black"
      }

      Column {
        id: section
        anchors.centerIn: parent
        spacing: 4

        BarSeparator {}
      }
    }
  }
}
