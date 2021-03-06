# Check the requirements
If(-Not(Get-Module -ListAvailable -Name AzureAD))
{
    Install-Module -Name AzureAD
}
If(-Not(Get-Module -ListAvailable -Name MSOnline))
{
    Install-Module -Name MSOnline
}

# Module variables
#New-Variable -Name Users -Value "Initieel" -Scope Global -Force
#New-Variable -Name Passwords -Value "Initieel" -Scope Global -Force
New-Variable -Name Users -Value "InitieelScript" -Scope Script -Force
New-Variable -Name Password -Value "InitieelScript" -Scope Script -Force

# Load the functions
Get-ChildItem -Path "$PSScriptRoot\Public" | Unblock-File
Get-ChildItem -Path "$PSScriptRoot\Private" | Unblock-File
Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" | Foreach-Object{ . $_.FullName }
Get-ChildItem -Path "$PSScriptRoot\Private\*.ps1" | Foreach-Object{ . $_.FullName }

# Make the functions public
##Comment the rule beneath to make the function private
Export-ModuleMember -Function Connect-GBCloud -Alias *
Export-ModuleMember -Function Disconnect-GBCloud -Alias *
Export-ModuleMember -Function Start-GBSync -Alias *
#Export-ModuleMember -Function Get-GBInputbox -Alias *
#Export-ModuleMember -Function Get-GBMessagebox -Alias *
#Export-ModuleMember -Function Get-GBScrambleString -Alias *
#Export-ModuleMember -Function Get-GBRandomCharacters -Alias *
Export-ModuleMember -Function New-GBPassword -Alias *
Export-ModuleMember -Function Set-GBUsersPassword -Alias *
Export-ModuleMember -Function Get-GBNewUsers -Alias *
#Export-ModuleMember -Function New-GBUserObject -Alias *
#Export-ModuleMember -Function Get-GBLicenses -Alias *
Export-ModuleMember -Function New-GBFormLicenses -Alias *
Export-ModuleMember -Function New-GBForm -Alias *
Export-ModuleMember -Function New-GBFormPassword -Alias *
#Export-ModuleMember -Function Save-GBFormLicenses -Alias *
Export-ModuleMember -Function Set-GBUsersLicenses -Alias *