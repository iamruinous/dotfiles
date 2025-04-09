if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList "-File `"$($MyInvocation.MyCommand.Path)`""
    exit
}

function InstallFonts
{
    $error.Clear()

    Get-InstalledPSResource -Name NerdFonts -Scope AllUsers | Out-Null
    if (-not($?))
    {
        Set-PSResourceRepository -Name "PSGallery" -Priority 25 -Trusted -PassThru
        Install-PSResource -Name Fonts -Scope AllUsers -Reinstall -Version '1.1.18'
        Install-PSResource -Name NerdFonts -Scope AllUsers -Reinstall
    }
    Import-Module -Name NerdFonts
    Get-NerdFont -Name 'FiraCode' -Scope AllUsers
    if (-not($?))
    {  
        Install-NerdFont -Name 'FiraCode' -Scope AllUsers
    }
}

InstallFonts
