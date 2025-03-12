function Install-Font
{  
  param  
  (  
    [System.IO.FileInfo]$fontFile  
  )  
      
  try
  { 

    #get font name
    $gt = [Windows.Media.GlyphTypeface]::new($fontFile.FullName)
    $family = $gt.Win32FamilyNames['en-us']
    if ($null -eq $family)
    { $family = $gt.Win32FamilyNames.Values.Item(0) 
    }
    $face = $gt.Win32FaceNames['en-us']
    if ($null -eq $face)
    { $face = $gt.Win32FaceNames.Values.Item(0) 
    }
    $fontName = ("$family $face").Trim() 
           
    switch ($fontFile.Extension)
    {  
      ".ttf"
      {$fontName = "$fontName (TrueType)"
      }  
      ".otf"
      {$fontName = "$fontName (OpenType)"
      }  
    }  

    write-host "Installing font: $fontFile with font name '$fontName'"

    If (!(Test-Path ("$($env:windir)\Fonts\" + $fontFile.Name)))
    {  
      write-host "Copying font: $fontFile"
      Copy-Item -Path $fontFile.FullName -Destination ("$($env:windir)\Fonts\" + $fontFile.Name) -Force 
    } else
    {  write-host "Font already exists: $fontFile" 
    }

    If (!(Get-ItemProperty -Name $fontName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -ErrorAction SilentlyContinue))
    {  
      write-host "Registering font: $fontFile"
      New-ItemProperty -Name $fontName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $fontFile.Name -Force -ErrorAction SilentlyContinue | Out-Null  
    } else
    {  write-host "Font already registered: $fontFile" 
    }
           
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($oShell) | out-null 
    Remove-Variable oShell               
             
  } catch
  {            
    write-host "Error installing font: $fontFile. " $_.exception.message
  }
	
} 
 

function Uninstall-Font
{  
  param  
  (  
    [System.IO.FileInfo]$fontFile  
  )  
      
  try
  { 

    #get font name
    $gt = [Windows.Media.GlyphTypeface]::new($fontFile.FullName)
    $family = $gt.Win32FamilyNames['en-us']
    if ($null -eq $family)
    { $family = $gt.Win32FamilyNames.Values.Item(0) 
    }
    $face = $gt.Win32FaceNames['en-us']
    if ($null -eq $face)
    { $face = $gt.Win32FaceNames.Values.Item(0) 
    }
    $fontName = ("$family $face").Trim()
           
    switch ($fontFile.Extension)
    {  
      ".ttf"
      {$fontName = "$fontName (TrueType)"
      }  
      ".otf"
      {$fontName = "$fontName (OpenType)"
      }  
    }  

    write-host "Uninstalling font: $fontFile with font name '$fontName'"

    If (Test-Path ("$($env:windir)\Fonts\" + $fontFile.Name))
    {  
      write-host "Removing font: $fontFile"
      Remove-Item -Path "$($env:windir)\Fonts\$($fontFile.Name)" -Force 
    } else
    {  write-host "Font does not exist: $fontFile" 
    }

    If (Get-ItemProperty -Name $fontName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -ErrorAction SilentlyContinue)
    {  
      write-host "Unregistering font: $fontFile"
      Remove-ItemProperty -Name $fontName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -Force                      
    } else
    {  write-host "Font not registered: $fontFile" 
    }
           
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($oShell) | out-null 
    Remove-Variable oShell               
             
  } catch
  {            
    write-host "Error uninstalling font: $fontFile. " $_.exception.message
  }        
}  
