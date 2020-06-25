<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
		Licenties van de gebruikers aanpassen
	.EXAMPLE
		Set-GBUsersLicenses -Users USERS -FileLicenses FILE
#>
function Set-GBUsersLicenses
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([System.Object[]])]
    Param
    (
        # Users: Gebruikers om aan te passen
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNullOrEmpty()]
        [System.Object[]]
        $Users,

        # fileStudents: File with licenses for the students
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [string]
        $FileLicenses
    )

    Begin
    {
        Write-Verbose -Message 'Begin called Set-GBUsersLicenses'

        # Bestaande licentietoewijzingen verwijderen
        Write-Verbose -Message 'Huidige licenties verwijderen'
        foreach ($User in $Users)
        {
            $temp = (Get-MsolUser -UserPrincipalName $User.UserPrincipalName).Licenses.AccountSkuId
            foreach ($tmp in $temp)
            {
                Set-MsolUserLicense -UserPrincipalName $User.UserPrincipalName -RemoveLicenses $tmp
            }
        }

        # Voorgaande licenties bijwerken als die al bestaan
        Write-Verbose -Message 'Licenties lezen uit het bestand'
        $Licenses = Get-Content -Path $FileLicenses

        # Locatie instellen
        Write-Verbose -Message 'Locatie instellen'
        $Users | Set-MsolUser -UsageLocation "BE"
    }
    Process
    {
        Write-Verbose -Message 'Process called Set-GBUsersLicenses'

        # Licenties instellen
        Write-Verbose -Message 'Licenties instellen'
        foreach ($lic in $Licenses)
        {
            # Set license
            $Users | Set-MsolUserLicense -AddLicenses $lic
        }
    }
    End
    {
        Write-Verbose -Message 'End called Set-GBUsersLicenses'
    }
}