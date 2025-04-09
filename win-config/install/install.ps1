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
        eza-community.eza `
        GitHub.GitHubDesktop `
        Google.Chrome.EXE `
        JesseDuffield.lazygit `
        LGUG2Z.komorebi `
        LGUG2Z.whkd `
        Microsoft.Git `
        Microsoft.PowerShell `
        Microsoft.PowerToys `
        Microsoft.VisualStudioCode `
        Microsoft.WSL `
        Microsoft.WindowsTerminal `
        Neovim.Neovim `
        OpenJS.NodeJS `
        Plex.Plex `
        PrivateInternetAccess.PrivateInternetAccess `
        Starship.Starship `
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

    ## Nvim
    $NVIM_CONFIG_DIR="$env:LOCALAPPDATA\nvim"

    if (-not (Test-Path -Path "$NVIM_CONFIG_DIR"))
    {
        git clone --depth 1 https://github.com/AstroNvim/template "$NVIM_CONFIG_DIR"
        Remove-Item $NVIM_CONFIG_DIR\.git -Recurse -Force
    }

    $XDG_CONFIG_DIR="$env:USERPROFILE\.config"
    $DOTFILES_DIR="$env:USERPROFILE\Projects\github\iamruinous\dotfiles\win-config"


    ## Komorebi
    $KOMOREBI_CONFIG_DIR="$XDG_CONFIG_DIR\komorebi"

    if (-not (Test-Path -Path "$KOMOREBI_CONFIG_DIR"))
    {
        mkdir -Force "$KOMOREBI_CONFIG_DIR"
    }
    Copy-Item "$DOTFILES_DIR\files\configs\komorebi\*.json" "$KOMOREBI_CONFIG_DIR"
    Copy-Item "$DOTFILES_DIR\files\configs\whkdrc" "$XDG_CONFIG_DIR"
    komorebic enable-autostart --config "$KOMOREBI_CONFIG_DIR\komorebi.json" --whkd

    ## Starship
    $STARSHIP_PROFILE="Invoke-Expression (&starship init powershell)"

    if (-not (Test-Path -Path "$PROFILE"))
    { 
        New-Item -Path "$PROFILE" -ItemType File
    }

    if ( (Get-Content -Path "$PROFILE") -notcontains "$STARSHIP_PROFILE")
    {
        Add-Content -Path "$PROFILE" -Value "$STARSHIP_PROFILE"
    }
}

function InstallFiles
{
    $error.Clear()

    Set-Alias -Name ll -Value "eza --git --icons --long"
}

InstallPackages $computerName
InstallFiles $computerName
InstallAliases $computerName
