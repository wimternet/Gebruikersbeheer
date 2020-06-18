# Modules
Import-Module -Name Logging
Import-Module -Name 'C:\Users\calw0.SCHOOL\OneDrive - Rozenberg SO\Scripts\Gebruikersbeheer'

# Variabelen
## Externe pc benaderen
$pc = 'AD05'
$configSession = 'IT'
## Benodigde cloud-omgevingen
$cloud = 'Beide'
$typeSync = 'Delta'
## Mappen
$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
$logfile = 'log.txt'
$csvpath = 'C:\TEMP'
## Mail
$mailSMTP = 'uit.telenet.be'
$mailFROM = 'ict-melding@rozenbergmol.be'
$mailTO = 'cbf9ccef.rozenbergmol.be@emea.teams.ms'
$mailSUBJECT = 'Wachtwoorden voor de gebruikers'
$mailBODY = '<p>Beste<br><br>In bijlage zitten de wachtwoorden voor de nieuwe gebruikers.<br><br>Groetjes<br><br><br>PowerShell</p>'
## Wachtwoord vereisten
$aantalKlein = 7
$aantalGroot = 1
$aantalCijfers = 2
$aantalSpeciaal = 0

# Programma
## Sync forceren
#######Write-Log -Boodschap "Start sync voor $cloud" -Bestand "$ScriptDir\$logfile"
#######Start-GBSync -Server $pc -Config $configSession -Cloud $cloud -TypeSync $typeSync

## Verbinden met de cloud
Write-Log -Boodschap "Verbinden met $cloud" -Bestand "$ScriptDir\$logfile"
Connect-GBCloud -Cloud $cloud

# Nieuwe gebruikers ophalen
#######Write-Log -Boodschap "Nieuwe gebruikers ophalen" -Bestand "$ScriptDir\$logfile"
#######$lln = Get-GBNewUsers -MailSuffix "*@student.rozenbergmol.be"
#######$lkr = Get-GBNewUsers -MailSuffix "*@rozenbergmol.be"

# Wachtwoorden resetten en exporteren naar csv (Voornaam, Achternaam, Gebruikersnaam, WW, ObjectID)
#######Write-Log -Boodschap "Wachtwoorden resetten en exporteren naar csv" -Bestand "$ScriptDir\$logfile"
#######Set-GBUsersPassword -Users $lln -Lowercase 7 -Uppercase 1 -Numbers 2 -Special 0 | Select-Object FirstName,LastName,Mail,Password,ObjectID | Export-Csv -Path "$csvpath\lln.csv"
#######Set-GBUsersPassword -Users $lkr -Lowercase 7 -Uppercase 1 -Numbers 2 -Special 0 | Select-Object FirstName,LastName,Mail,Password,ObjectID | Export-Csv -Path "$csvpath\lkr.csv"

############################################################################################

<#
# Licenties ophalen
Get-MsolAccountSku

# Licenties toewijzen
$lkr
$lkr | Set-MsolUser -UsageLocation "BE"
$lkr | Set-MsolUserLicense -AddLicenses "rozenbergmol:STANDARDWOFFPACK_IW_FACULTY"
$lkr | Set-MsolUserLicense -AddLicenses "rozenbergmol:INTUNE_EDU"
$lkr | Set-MsolUserLicense -AddLicenses "rozenbergmol:AAD_PREMIUM_P2"
$lkr | Set-MsolUserLicense -AddLicenses "rozenbergmol:POWER_BI_STANDARD"
$lkr | Set-MsolUserLicense -AddLicenses "rozenbergmol:EMS"

$lln
$lln | Set-MsolUser -UsageLocation "BE"
$lln | Set-MsolUserLicense -AddLicenses "rozenbergmol:STANDARDWOFFPACK_IW_STUDENT"
$lln | Set-MsolUserLicense -AddLicenses "rozenbergmol:INTUNE_EDU"
$lln | Set-MsolUserLicense -AddLicenses "rozenbergmol:AAD_PREMIUM_P2"
$lln | Set-MsolUserLicense -AddLicenses "rozenbergmol:POWER_BI_STANDARD"
$lln | Set-MsolUserLicense -AddLicenses "rozenbergmol:EMS"
#>

New-GBFormLicenses

############################################################################################

# CSV's worden verstuurd
####Write-Log -Boodschap "Csv versturen per mail" -Bestand "$ScriptDir\$logfile"
####Send-MailMessage -SmtpServer $mailSMTP -From $mailFROM -To $mailTO -Subject $mailSUBJECT -Body $mailBODY -BodyAsHtml -Attachments "$csvpath\lkr.csv","$csvpath\lln.csv"

# Csv's verwijderen
####Write-Log -Boodschap "Csv's verwijderen" -Bestand "$ScriptDir\$logfile"
####Remove-Item -Path "$csvpath\lln.csv"
####Remove-Item -Path "$csvpath\lkr.csv"

## Verbinden verbreken met de cloud
#######Write-Log -Boodschap "Verbinding verbeken met $cloud" -Bestand "$ScriptDir\$logfile"
#######Disconnect-GBCloud -Cloud $cloud