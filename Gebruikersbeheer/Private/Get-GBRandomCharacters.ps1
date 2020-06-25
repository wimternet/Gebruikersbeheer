<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
	   Kies willekeurig tussen de aangeboden tekens
	.EXAMPLE
	   $password = Get-GBRandomCharacters -Number 5 -TypeOfCharacters LOWER/UPPER/NUMBERS/SPECIAL
#>
function Get-GBRandomCharacters
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Number: Aantal tekens
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Number,

        # TypeOfCharacter: Type van de gewenste tekens
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("LOWER", "UPPER", "NUMBERS", "SPECIAL")]
        $TypeOfCharacter
    )

    Begin
    {
        Write-Verbose -Message 'Begin called Get-GBRandomCharacters'

        # Constanten maken
        New-Variable -Name 'cLOWER' -Value 'a','b','c','d','e','f','g','h','i','j','k','m','n','p','q','r','s','t','u','v','w','x','y','z' -Option Constant
        New-Variable -Name 'cUPPER' -Value 'A','B','C','D','E','F','G','H','K','L','M','N','P','R','S','T','U','V','W','X','Y','Z' -Option Constant
        New-Variable -Name 'cNUMBERS' -Value '1','2','3','4','5','6','7','8','9' -Option Constant
        New-Variable -Name 'cSPECIAL' -Value '!','"','§','$','%','&','/','(',')','=','?','}',']','[','{','@','#','*','+' -Option Constant

        # Tekens leegmaken
        Write-Verbose -Message 'Tekens leegmaken'
        $tekens = ''
    }
    Process
    {
        Write-Verbose -Message 'Process called Get-GBRandomCharacters'

        # Tekens klaarzetten
        Write-Verbose -Message 'Tekens worden klaargezet'
        Switch ($TypeOfCharacter)
        {
            "LOWER" { $Characters = $cLOWER}
            "UPPER" { $Characters = $cUPPER}
            "NUMBERS" { $Characters = $cNUMBERS}
            "SPECIAL" { $Characters = $cSPECIAL}
        }
        

        # Tekens willekeurig kiezen
        Write-Verbose -Message 'Tekens worden gekozen'
        For ($i=0;$i -le ($Number-1);$i++)
        {
            $tekens += Get-Random -InputObject $Characters
        }
    }
    End
    {
        Write-Verbose -Message 'End called Get-GBRandomCharacters'

        # Tekens terug sturen als antwoord
        Write-Verbose -Message 'Gekozen tekens worden verzonden'
        return [String]$tekens
    }
}