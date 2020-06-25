<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
	   Rammel de string
	.EXAMPLE
	   Get-GBScrambleString -InputString STRING
#>
function Get-GBScrambleString
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # InputString: De string die wordt gescrambeld
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $InputString
    )

    Begin
    {
        Write-Verbose -Message 'Begin called Get-GBScrambleString'
    }
    Process
    {
        Write-Verbose -Message 'Process called Get-GBScrambleString'

        # String door elkaar halen
        Write-Verbose -Message 'String wordt gescrambled'
        $characterArray = $InputString.ToCharArray()   
        $scrambledStringArray = $characterArray | Get-Random -Count $characterArray.Length     
        $OutputString = -join $scrambledStringArray
    }
    End
    {
        Write-Verbose -Message 'End called Get-GBScrambleString'

        # String terug sturen als antwoord
        Write-Verbose -Message 'String wordt verzonden'
        return $OutputString
    }
}