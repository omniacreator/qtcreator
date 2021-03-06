import qbs 1.0
import QtcTool

QtcTool {
    name: "qtcdebugger"
    condition: qbs.targetOS.contains("windows")

    cpp.includePaths: base.concat(["../../shared/registryaccess"])
    cpp.dynamicLibraries: [
        "psapi",
        "advapi32"
    ]

    Depends { name: "Qt.widgets" }
    Depends { name: "app_version_header" }

    files: [
        "main.cpp",
        "../../shared/registryaccess/registryaccess.cpp",
        "../../shared/registryaccess/registryaccess.h",
    ]
}
