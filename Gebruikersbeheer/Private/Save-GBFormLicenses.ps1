<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
		Licenties opslaan die in het formulier zijn aangeduid
	.EXAMPLE
		Save-GBFormLicenses
#>
function Save-GBFormLicenses
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # fileLLN: Bestand om de licenties op te slaan
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [string]
        $fileLLN = $null,

        # fileLKR: Bestand om de licenties op te slaan
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [string]
        $fileLKR = $null
    )
    
    Begin
    {
        Write-Verbose -Message 'Begin called Get-GBLicenses'
    }
    Process
    {
        Write-Verbose -Message 'Process called Get-GBLicenses'
        
        # Aangeduide licenties bewaren
        Write-Verbose -Message 'Licenties bewaren'
        $lstLicensesLLN.SelectedItems | Out-File $fileLLN
        $lstLicensesLKR.SelectedItems | Out-File $fileLKR
    }
    End
    {
        Write-Verbose -Message 'End called Get-GBLicenses'
    }
}