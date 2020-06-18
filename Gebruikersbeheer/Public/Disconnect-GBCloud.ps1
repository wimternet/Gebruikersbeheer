<#
.Synopsis
    Verbind verbreken met de cloud
.DESCRIPTION
    Verbind verbreken met AzureAD en/of Gsuite
.EXAMPLE
    Disconnect-GBCloud -Cloud Beide/Azure/Gsuite
#>
function Disconnect-GBCloud
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
        Write-Verbose -Message 'Begin called Disconnect-GBCloud'
    }
    Process
    {
        Write-Verbose -Message 'Process called Disconnect-GBCloud'

        # Verbinding verbreken met de cloud
        If (($Cloud -eq 'Azure') -or ($Cloud -eq 'Beide'))
        {
            # Verbinding vebreken met Azure
            Disconnect-AzureAD
            Write-Verbose -Message 'Verbinding verbroken met Azure'
        }
        If (($Cloud -eq 'Gsuite') -or ($Cloud -eq 'Beide'))
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