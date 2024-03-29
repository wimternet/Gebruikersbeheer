﻿<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
		Nieuwe gebruikers ophalen
	.EXAMPLE
		Dit geeft de nieuwe gebruikers terug voor het mail-domein "rozenbergmol.be":
		Get-GBNewUsersPassword -MailSuffix "*@rozenbergmol.be"
	.EXAMPLE
		Dit geeft de nieuwe gebruikers terug voor het mail-domein "student.rozenbergmol.be":
		Get-GBNewUsersPassword
#>
function Get-GBNewUsers
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Lowercase: Aantal kleine letters
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $MailSuffix="*@student.rozenbergmol.be"
    )

    Begin
    {
        Write-Verbose -Message 'Begin called Get-GBNewUsers'
    }
    Process
    {
        Write-Verbose -Message 'Process called Get-GBNewUsers'

        # Gebruikers zonder licentie in Microsoft 365 ophalen (= nieuwe gebruikers)
        Write-Verbose -Message 'Nieuwe gebruikers zoeken'
        $Script:Users = Get-MsolUser -All -UnlicensedUsersOnly -Synchronized | Where-Object {$_.UserPrincipalName -like $MailSuffix}


        <#
            Huidig gedacht gaat naar: Get-AzureADUser | Where-Object {$_.UserPrincipalName -like "*@someemail.com"}
            Hierbij moet er nog worden gefilterd op aanmaakdatum

            Mogelijkheid:
                1) https://docs.microsoft.com/en-us/answers/questions/179029/get-all-azure-ad-users-which-are-updated-in-the-pa.html
                        Past 24 hours
                        createdDateTime
                        Get-AzureADUser --> objectID + te bewaren
                        Get-AzureADUserExtension --> indien createdDateTime klopt

                        Get-AzureADUser | Where {$_.LastDirSyncTime -gt (Get-Date).AddDays(-1)}



                        $Everyone = Get-AzureADUser -All $true
                        Foreach( $Account in $Everyone )
                        {
                            (Get-AzureADUserExtension -ObjectID ($Account).ObjectID).createdDateTime
                        }


                2) https://docs.microsoft.com/en-us/azure/active-directory/hybrid/reference-connect-adsync
                       Get last sync cycle
        #>
    }
    End
    {
        Write-Verbose -Message 'End called Get-GBNewUsers'

        # Gebruikers verzenden
        Write-Verbose -Message 'Nieuwe gebruikers verzenden'
        Return $Script:Users
    }
}