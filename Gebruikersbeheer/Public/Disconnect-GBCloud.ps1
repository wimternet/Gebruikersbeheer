<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
		Verbind verbreken met de cloud
	.DESCRIPTION
		Verbind verbreken met AzureAD, Gsuite, Smartschool of Alle
	.EXAMPLE
		Disconnect-GBCloud -Cloud Alle/Azure/Gsuite/Smartschool
#>
function Disconnect-GBCloud
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
        $Cloud
    )

    Begin
    {
        Write-Verbose -Message 'Begin called Disconnect-GBCloud'
    }
    Process
    {
        Write-Verbose -Message 'Process called Disconnect-GBCloud'

        # Verbinding verbreken met de cloud
        If (($Cloud -eq 'Azure') -or ($Cloud -eq 'Alle'))
        {
            # Verbinding vebreken met Azure
            Disconnect-AzureAD
            Write-Verbose -Message 'Verbinding verbroken met Azure'
        }
        If (($Cloud -eq 'Gsuite') -or ($Cloud -eq 'Alle'))
        {
            # Verbinding vebreken met Gsuite
            Write-Verbose -Message 'Verbinding verbroken met Gsuite'
        }
    }
    End
    {
        Write-Verbose -Message 'End called Disconnect-GBCloud'
    }
}