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
    .EXAMPLE
		Dit roept de cmdlet New-GBFormPassword op:
        New-GBPassword -Form $true
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
                   ParameterSetName = 'CLI',
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Lowercase,

        # Uppercase: Aantal hoofdletters
        [Parameter(Mandatory=$false, 
                   ParameterSetName = 'CLI',
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Uppercase='0',

        # Numbers: Aantal cijfers
        [Parameter(Mandatory=$false, 
                   ParameterSetName = 'CLI',
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=2)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Numbers='0',

        # Special: Aantal speciale tekens
        [Parameter(Mandatory=$false, 
                   ParameterSetName = 'CLI',
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=3)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Special='0',

        # Secure: Maak een securestring of een gewone string
        [Parameter(Mandatory=$false,
                   ParameterSetName = 'CLI',
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=4)]
        [bool]
        $Secure=$true,

        # Form: Gebruik de GUI
        [Parameter(Mandatory=$true,
                   ParameterSetName = 'Form',
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=4)]
        [bool]
        $Form=$false
    )

    Begin
    {
        Write-Verbose -Message 'Begin called New-GBPassword'
    }
    Process
    {
        Write-Verbose -Message 'Process called New-GBPassword'

        If ($Form)
        {
            # GUI oproepen
            Write-Verbose -Message "Formulier openen"
            Write-Host "De GUI wordt opgeroepen."

            # Variabele aanpassen en functie aanroepen
            $password = New-GBFormPassword
        } Else {
            # String samenstellen
            Write-Verbose -Message 'String wordt samengesteld'
            $temp = Get-GBRandomCharacters -Number $Lowercase -TypeOfCharacter LOWER
            $temp += Get-GBRandomCharacters -Number $Uppercase -TypeOfCharacter UPPER
            $temp += Get-GBRandomCharacters -Number $Numbers -TypeOfCharacter NUMBERS
            $temp += Get-GBRandomCharacters -Number $Special -TypeOfCharacter SPECIAL

            # String door elkaar halen
            Write-Verbose -Message 'String wordt gescrambled'
            $temp = Get-GBScrambleString -InputString $temp

            If($Secure)
            {
                # String vervangen naar een secure-string
                Write-Verbose -Message 'String wordt bewaard als secure-string'
                $temp = $temp | ConvertTo-SecureString -AsPlainText -Force
            }
        }
    }
    End
    {
        Write-Verbose -Message 'End called New-GBPassword'

        # Wachtwoord terug sturen als antwoord
        Write-Verbose -Message 'Wachtwoord als antwoord verzenden'
        
        If ($Form)
        {
            Write-Verbose -Message $Script:Password
            $Script:Password
        } Else {
            Write-Verbose -Message $temp
            $Script:Password = $temp
            Return $Script:Password
        }
    }
}