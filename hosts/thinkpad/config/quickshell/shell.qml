//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1

import QtQuick
import Quickshell

ShellRoot {
    // LazyLoader { active: true; component: Bar {} }
    LazyLoader { active: true; component: VerticalBar{} }
}
