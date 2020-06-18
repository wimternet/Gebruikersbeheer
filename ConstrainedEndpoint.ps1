<# Normale gang van zaken
    Enter-PSSession -ComputerName AD05
    $env:Computername
    Exit-PSSession
#>

# Variabelen
    # Huidige locatie
$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path

# Invoer
$DirName = Read-Host -Prompt "Wat is de naam van de folder?"
    $ConfigDir = "$ScriptDir\$DirName"
$FileName = Read-Host -Prompt "Hoe noemt het gewenste eindpunt?"
    $ConfigFile = "$ConfigDir\$FileName.pssc"

# Maak de folder PSSC als die niet bestaat
If (-Not(Test-Path -Path $ConfigDir))
{
    New-Item -Path $ConfigDir -ItemType Directory
}

# Verwijderd de Session Configuration File indien reeds aanwezig
If (Test-Path -Path $ConfigFile)
{
    Remove-Item -Path $ConfigFile -Force -Confirm:$false
}

# Maak een nieuw Session Configuration File voor een beperkte endpoint
#New-PSSessionConfigurationFile -Path $ConfigFile -ExecutionPolicy Restricted -LanguageMode NoLanguage -ModulesToImport ADSync -SessionType RestrictedRemoteServer -VisibleCmdlets Start-ADSyncSyncCycle,Import-Module,Get-Location,Set-Location,Get-Date -VisibleExternalCommands 'C:\Program Files\Google Cloud Directory Sync\sync-cmd.exe' -VisibleProviders FileSystem
New-PSSessionConfigurationFile -Path $ConfigFile -ExecutionPolicy Restricted -LanguageMode ConstrainedLanguage

# Behandel de Session Configuration File enkel indien OK
If (Test-PSSessionConfigurationFile -Path $ConfigFile)
{
    # Verwijder de Registratie van het endpoint indien reeds aanwezig
    If ((Get-PSSessionConfiguration -Name $FileName -ErrorAction SilentlyContinue) -ne $null)
    {
        Unregister-PSSessionConfiguration -Name $FileName -Force -Confirm:$false
    }

    # Registreer een nieuwe endpoint met de gewenste naam $FileName dat commando's uitvoert met beheerdersrechten
    Register-PSSessionConfiguration -Name $FileName -Path $ConfigFile -RunAsCredential admin@school.rozenbergmol.be -ShowSecurityDescriptorUI -Force -Confirm:$false
}