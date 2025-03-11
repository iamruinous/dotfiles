param ($ComputerName = $(throw "ComputerName parameter is required."))

function InstallPackages
{
    $error.Clear()

    winget install `
        --exact `
        7zip.7zip `
        Agilebits.1Password `
        GitHub.GitHubDesktop `
        Google.Chrome.EXE `
        LGUG2Z.komorebi `
        LGUG2Z.whkd `
        MartinStorsjo.LLVM-MinGW.UCRT `
        Microsoft.Git `
        Microsoft.PowerToys `
        Microsoft.VisualStudioCode `
        Microsoft.WSL `
        Microsoft.WindowsTerminal `
        Neovim.Neovim `
        OpenJS.NodeJS `
        Tailscale.Tailscale `
        Valve.Steam
}

function InstallFiles
{
    $error.Clear()

    NVIM_CONFIG_DIR=$env:LOCALAPPDATA\nvim
    if (-not (Test-Path -Path $NVIM_CONFIG_DIR))
    {
        git clone --depth 1 https://github.com/AstroNvim/template $NVIM_CONFIG_DIR
        Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force
    }

    $KOMOREBI_CONFIG_DIR=~/.config/komorebi
    if (-not (Test-Path -Path $NVIM_CONFIG_DIR))
    {
        mkdir -Force $KOMOREBI_CONFIG_DIR
    }
    Copy-Item ~/Projects/github/iamruinous/dotfiles/win-config/files/configs/komorebi/*.json $KOMOREBI_CONFIG_DIR
    Copy-Item ~/Projects/github/iamruinous/dotfiles/win-config/files/configs/whkdrc ~/.config
}


InstallPackages $computerName
InstallFiles $computerName
