<#
.Synopsis
    Verbind met de cloud
.DESCRIPTION
   Verbind met AzureAD en/of Gsuite
.EXAMPLE
    Connect-GBCloud -Cloud Beide/Azure/Gsuite
#>
function Connect-GBCloud
{
    [CmdletBinding()]
    Param
    (
        # Cloud: Kiezen welke cloud moet syncen (Beide, Azure, Gsuite)
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("Beide", "Azure", "Gsuite")]
        $Cloud
    )

    Begin
    {
        Write-Verbose -Message 'Begin called Connect-GBCloud'

        # Modules
        Write-Verbose -Message 'Modules inladen'
        If (($Cloud -eq 'Azure') -or ($Cloud -eq 'Beide'))
        {
            # Azure
            Import-Module -Name AzureAD -Scope Global
            Import-Module -Name MSOnline -Scope Global
            Write-Verbose -Message 'Azure modules zijn ingeladen'
        }
        If (($Cloud -eq 'Gsuite') -or ($Cloud -eq 'Beide'))
        {
            # Gsuite
            Write-Verbose -Message 'Gsuite module is ingeladen'
        }
    }
    Process
    {
        Write-Verbose -Message 'Process called Connect-GBCloud'

        # Verbind met de cloud
        If (($Cloud -eq 'Azure') -or ($Cloud -eq 'Beide'))
        {
            # Eerst een mededeling
            Get-GBMessagebox -Icon 'Information' -Button 'OK' -Title 'Aanmelden en MFA' -Message 'Wegens MFA moet u zo dadelijk 2 keer aanmelden en is dit niet geautomatiseerd.' | Out-Null
            
            # Verbind met Azure
            Connect-AzureAD
            Connect-MsolService
            Write-Verbose -Message 'Verbonden met Azure'
        }
        If (($Cloud -eq 'Gsuite') -or ($Cloud -eq 'Beide'))
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