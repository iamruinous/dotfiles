Import-Module ".\font-management.ps1"
param ($ComputerName = $(throw "ComputerName parameter is required."))

$currentDirectory = [System.AppDomain]::CurrentDomain.BaseDirectory.TrimEnd('\') 
if ($currentDirectory -eq $PSHOME.TrimEnd('\')) 
{     
    $currentDirectory = $PSScriptRoot 
}

function InstallPackages
{
    $error.Clear()

    winget install `
        --exact `
        7zip.7zip `
        Agilebits.1Password `
        GitHub.GitHubDesktop `
        Google.Chrome.EXE `
        JesseDuffield.lazygit `
        LGUG2Z.komorebi `
        LGUG2Z.whkd `
        Microsoft.Git `
        Microsoft.PowerToys `
        Microsoft.VisualStudioCode `
        Microsoft.WSL `
        Microsoft.WindowsTerminal `
        Neovim.Neovim `
        OpenJS.NodeJS `
        Plex.Plex `
        PrivateInternetAccess.PrivateInternetAccess `
        Tailscale.Tailscale `
        Valve.Steam

    $MINGW_ID="MartinStorsjo.LLVM-MinGW.UCRT"
    winget list -q $MINGW_ID | Out-Null
    if (-not($?))
    {  
        winget install `
            --exact `
            --no-upgrade `
            $MINGW_ID
    }
}

function InstallFiles
{
    $error.Clear()

    $NVIM_CONFIG_DIR="$env:LOCALAPPDATA\nvim"
    if (-not (Test-Path -Path "$NVIM_CONFIG_DIR"))
    {
        git clone --depth 1 https://github.com/AstroNvim/template "$NVIM_CONFIG_DIR"
        Remove-Item $NVIM_CONFIG_DIR\.git -Recurse -Force
    }

    $XDG_CONFIG_DIR="$env:USERPROFILE\.config"
    $KOMOREBI_CONFIG_DIR="$XDG_CONFIG_DIR\komorebi"
    $DOTFILES_DIR="$env:USERPROFILE\Projects\github\iamruinous\dotfiles\win-config"
    if (-not (Test-Path -Path "$KOMOREBI_CONFIG_DIR"))
    {
        mkdir -Force "$KOMOREBI_CONFIG_DIR"
    }
    Copy-Item "$DOTFILES_DIR\files\configs\komorebi\*.json" "$KOMOREBI_CONFIG_DIR"
    Copy-Item "$DOTFILES_DIR\files\configs\whkdrc" "$XDG_CONFIG_DIR"
    komorebic enable-autostart --config "$KOMOREBI_CONFIG_DIR\komorebi.json" --whkd
}

function DownloadInstallFonts
{
    $error.Clear()

    $FONT_DOWNLOAD_DIR="$currentDirectory\downloads\fonts"
    if (-not (Test-Path -Path "$FONT_DOWNLOAD_DIR"))
    {
        # git clone --depth 1 https://github.com/AstroNvim/template "$NVIM_CONFIG_DIR"
        # Remove-Item $NVIM_CONFIG_DIR\.git -Recurse -Force
    }
    #Loop through fonts in the same directory as the script and install/uninstall them
    foreach ($FontItem in (Get-ChildItem -Path "$currentDirectory\downloads\fonts" | 
                Where-Object {($_.Name -like '*.ttf') -or ($_.Name -like '*.otf') }))
    {  
        Install-Font -fontFile $FontItem.FullName  
    }
}

InstallPackages $computerName
InstallFiles $computerName
DownloadInstallFonts $computerName
