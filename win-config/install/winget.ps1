param ($ComputerName = $(throw "ComputerName parameter is required."))

function InstallPackages {
  $error.Clear()

  winget install `
    Microsoft.WindowsTerminal `
    Microsoft.PowerToys `
    Microsoft.VisualStudioCode `
    LGUG2Z.komorebi `
    LGUG2Z.whkd
}

InstallPackages $computerName
