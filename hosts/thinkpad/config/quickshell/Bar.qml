import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.UPower

Scope {
  id: bar

  PanelWindow {
    id: barRoot

    implicitHeight: 20

    anchors {
      bottom: true
      left: true
      right: true
    }

    RowLayout {
      id: barContent
      anchors.fill: parent

      RowLayout {
        id: workspaces
        Layout.alignment: Qt.AlignLeft
        uniformCellSizes: true
        spacing: 0
        Repeater {
          model: Hyprland.workspaces.values.filter(workspace => /^[0-9]+$/.test(workspace.id))
          Rectangle {
            color: (modelData.id == Hyprland.focusedWorkspace.id) ? "#dddddd" : "#aaaaaa"
            width: 100
            height: 20
            border.color: "#888888"
            border.width: 1
            Text {
              anchors.centerIn: parent
              text: modelData.name
              font.pixelSize: 12
            }
          }
        }
      }

      Text {
        Layout.alignment: Qt.AlignHCenter
        horizontalAlignment: Text.AlignHCenter

        text: {
          var activeWindow = Hyprland.focusedWorkspace.toplevels.values.filter(t => t.activated)[0]
          if (activeWindow)
            return activeWindow.title
          else
            return ""
        }
        font.pixelSize: 14
      }

      RowLayout {
        id: batteryIndicator 
        Layout.alignment: Qt.AlignRight
        uniformCellSizes: true
        spacing: 0
        Repeater {
          model: UPower.devices.values.filter(d => d.isLaptopBattery)
          Rectangle {
            color: "lightgreen"
            width: 50
            height: 20
            border.color: "#888888"
            border.width: 1
            Text {
              anchors.centerIn: parent
              text: (modelData.percentage * 100) + "%"
              font.pixelSize: 12
            }
          }
        }
      }
    }
  }
}
