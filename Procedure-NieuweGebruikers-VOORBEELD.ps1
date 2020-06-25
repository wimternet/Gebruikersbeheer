# Example written by wimternet (https://github.com/wimternet)
# Modules
Import-Module -Name Logging
Import-Module -Name Gebruikersbeheer

# Variabelen
## Externe pc benaderen
$pc = **SERVER**
$configSession = **CONFIGNAAM**
## Benodigde cloud-omgevingen
$cloud = 'Alle'
$typeSync = 'Delta'
$mfa = $true
$mailSuffixLLN = "*@**IETS**"
$mailSuffixLKR = "*@**IETS**"
## Mappen
$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
$logfile = **BESTANDSNAAM**
$temppath = **MAPNAAM**
## Mail
$mailSMTP = **SMTPSERVER**
$mailFROM = **MAILADRES**
$mailTO = **MAILADRES**
$mailSUBJECT = 'Wachtwoorden voor de gebruikers'
$mailBODY = '<p>Beste<br><br>In bijlage zitten de wachtwoorden voor de nieuwe gebruikers.<br><br>Groetjes<br><br><br>PowerShell</p>'
## Wachtwoord vereisten
$aantalKlein = 7
$aantalGroot = 1
$aantalCijfers = 2
$aantalSpeciaal = 0

# Programma
## Sync forceren
Write-Log -Boodschap "Start sync voor $cloud" -Bestand "$ScriptDir\$logfile"
Start-GBSync -Server $pc -Config $configSession -Cloud $cloud -TypeSync $typeSync

## Verbinden met de cloud
Write-Log -Boodschap "Verbinden met $cloud" -Bestand "$ScriptDir\$logfile"
Connect-GBCloud -Cloud $cloud -MFA $mfa | Out-Null

# Nieuwe gebruikers ophalen
Write-Log -Boodschap "Nieuwe gebruikers ophalen" -Bestand "$ScriptDir\$logfile"
$lln = Get-GBNewUsers -MailSuffix $mailSuffixLLN
$lkr = Get-GBNewUsers -MailSuffix $mailSuffixLKR

# Wachtwoorden resetten en exporteren naar csv (Voornaam, Achternaam, Gebruikersnaam, WW, ObjectID)
Write-Log -Boodschap "Wachtwoorden resetten en exporteren naar csv" -Bestand "$ScriptDir\$logfile"
Set-GBUsersPassword -Users $lln -Lowercase 7 -Uppercase 1 -Numbers 2 -Special 0 | Select-Object FirstName,LastName,Mail,Password,ObjectID | Export-Csv -Path "$temppath\lln.csv"
Set-GBUsersPassword -Users $lkr -Lowercase 7 -Uppercase 1 -Numbers 2 -Special 0 | Select-Object FirstName,LastName,Mail,Password,ObjectID | Export-Csv -Path "$temppath\lkr.csv"

# Licenties bijweren
Write-Log -Boodschap "Licentiebestanden bijwerken en wegschrijven" -Bestand "$ScriptDir\$logfile"
New-GBFormLicenses -fileTeachers "$temppath\licLKR.csv" -fileStudents "$temppath\licLLN.csv" | Out-Null

# Licenties instellen
Write-Log -Boodschap "Licenties toepassen a.h.v. de licentiesbestanden" -Bestand "$ScriptDir\$logfile"
Set-GBUSersLicenses -Users $lkr -FileLicenses "$temppath\licLKR.csv"
Set-GBUSersLicenses -Users $lln -FileLicenses "$temppath\licLLN.csv"

# CSV's worden verstuurd
Write-Log -Boodschap "Csv versturen per mail" -Bestand "$ScriptDir\$logfile"
Send-MailMessage -SmtpServer $mailSMTP -From $mailFROM -To $mailTO -Subject $mailSUBJECT -Body $mailBODY -BodyAsHtml -Attachments "$temppath\lkr.csv","$temppath\lln.csv"

# CSV's verwijderen
Write-Log -Boodschap "Csv's verwijderen" -Bestand "$ScriptDir\$logfile"
Remove-Item -Path "$temppath\lln.csv"
Remove-Item -Path "$temppath\lkr.csv"

## Verbinden verbreken met de cloud
Write-Log -Boodschap "Verbinding verbeken met $cloud" -Bestand "$ScriptDir\$logfile"
Disconnect-GBCloud -Cloud $cloud