<#
.Synopsis
    Licenties opvragen
.EXAMPLE
    Get-GBLicenses
#>
function Get-GBLicenses
{
    Begin
    {
        Write-Verbose -Message 'Begin called Get-GBLicenses'
    }
    Process
    {
        Write-Verbose -Message 'Process called Get-GBLicenses'
        Get-MsolAccountSku
    }
    End
    {
        Write-Verbose -Message 'End called Get-GBLicenses'
    }
}