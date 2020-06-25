<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
		Wachtwoord genereren
	.EXAMPLE
		Dit geeft een wachtwoord van 8 tekens lang met alleen maar kleine letters:
		New-GBPassword -Lowercase 8
	.EXAMPLE
		Dit geeft een wachtwoord met 5 kleine letters, 3 hoofdletters, 2 cijfers en 1 speciaal teken. Tevens is het wachtwoord leesbaar voor verdere verwerking.
		New-GBPassword -Lowercase 5 -Uppercase 3 -Numbers 2 -Special 1 -Secure $false
#>
function New-GBPassword
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Lowercase: Aantal kleine letters
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Lowercase,

        # Uppercase: Aantal hoofdletters
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Uppercase='0',

        # Numbers: Aantal cijfers
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=2)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Numbers='0',

        # Special: Aantal speciale tekens
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=3)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Special='0',

        # Secure: Maak een securestring of een gewone string
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=4)]
        [bool]
        $Secure=$true
    )

    Begin
    {
        Write-Verbose -Message 'Begin called New-GBPassword'
    }
    Process
    {
        Write-Verbose -Message 'Process called New-GBPassword'

        # String samenstellen
        Write-Verbose -Message 'String wordt samengesteld'
        $password = Get-GBRandomCharacters -Number $Lowercase -TypeOfCharacter LOWER
        $password += Get-GBRandomCharacters -Number $Uppercase -TypeOfCharacter UPPER
        $password += Get-GBRandomCharacters -Number $Numbers -TypeOfCharacter NUMBERS
        $password += Get-GBRandomCharacters -Number $Special -TypeOfCharacter SPECIAL

        # String door elkaar halen
        Write-Verbose -Message 'String wordt gescrambled'
        $password = Get-GBScrambleString -InputString $password

        If($Secure)
        {
            # String vervangen naar een secure-string
            Write-Verbose -Message 'String wordt bewaard als secure-string'
            $password = $password | ConvertTo-SecureString -AsPlainText -Force
        }
    }
    End
    {
        Write-Verbose -Message 'End called New-GBPassword'

        # Wachtwoord terug sturen als antwoord
        Write-Verbose -Message 'Wachtwoord als antwoord verzenden'
        Return $password
    }
}