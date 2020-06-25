<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
		Verbind met de cloud
	.DESCRIPTION
	   Verbind met AzureAD en/of Gsuite
	.EXAMPLE
		Connect-GBCloud -Cloud Alle/Azure/Gsuite/Smartschool
#>
function Connect-GBCloud
{
    [CmdletBinding()]
    Param
    (
        # Cloud: Kiezen welke cloud moet syncen (Alle, Azure, Gsuite)
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("Alle", "Azure", "Gsuite", "Smartschool")]
        $Cloud,

        # MFA: Gebruikt de gebruiker MFA?
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNullOrEmpty()]
        [bool]
        $MFA = $false
    )

    Begin
    {
        Write-Verbose -Message 'Begin called Connect-GBCloud'

        # Modules
        Write-Verbose -Message 'Modules inladen'
        If (($Cloud -eq 'Azure') -or ($Cloud -eq 'Alle'))
        {
            # Azure
            Import-Module -Name AzureAD -Scope Global
            Import-Module -Name MSOnline -Scope Global
            Write-Verbose -Message 'Azure modules zijn ingeladen'
        }
        If (($Cloud -eq 'Gsuite') -or ($Cloud -eq 'Alle'))
        {
            # Gsuite
            Write-Verbose -Message 'Gsuite module is ingeladen'
        }

        # Heeft de gebruiker MFA?
        If (-not($mfa))
        {
            # Credenties opslaan
            Write-Verbose -Message 'Geen MFA: credenties opslaan'
            $cred = Get-Credential -UserName $env:USERNAME
            $cred.Password = $cred.Password | ConvertFrom-SecureString
        }
    }
    Process
    {
        Write-Verbose -Message 'Process called Connect-GBCloud'

        # Verbind met de cloud
        If (($Cloud -eq 'Azure') -or ($Cloud -eq 'Alle'))
        {
            # Verbind met Azure
            If ($mfa)
            {
                # Eerst een mededeling
                Write-Verbose -Message 'Eerst een mededeling over mfa'
                Get-GBMessagebox -Icon 'Information' -Button 'OK' -Title 'Aanmelden en MFA' -Message 'Wegens MFA moet u zo dadelijk 2 keer aanmelden en is dit niet geautomatiseerd.' | Out-Null
                
                # Verbinden met MFA
                Write-Verbose -Message 'Verbonden met Azure met MFA'
                Connect-AzureAD
                Connect-MsolService
            }
            Else
            {
                # Verbinden zonder MFA
                Write-Verbose -Message 'Verbonden met Azure zonder MFA'
                Connect-AzureAD -Credential $cred
                Connect-MsolService -Credential $cred
            }
        }
        If (($Cloud -eq 'Gsuite') -or ($Cloud -eq 'Alle'))
        {
            # Verbind met Gsuite
            Write-Verbose -Message 'Verbonden met Gsuite'
        }
    }
    End
    {
        Write-Verbose -Message 'End called Connect-GBCloud'
    }
}