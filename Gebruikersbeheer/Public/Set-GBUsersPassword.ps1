<#
.Synopsis
    Nieuwe gebruikers een wachtwoord geven
.EXAMPLE
    Dit geeft de gebruikers een wachtwoord van 8 tekens lang met alleen maar kleine letters:
    Set-GBNewUsersPassword -Lowercase 8
.EXAMPLE
    Dit geeft de gebruikers een wachtwoord met 5 kleine letters, 3 hoofdletters, 2 cijfers en 1 speciaal teken:
    Set-GBNewUsersPassword -Lowercase 5 -Uppercase 3 -Numbers 2 -Special 1
#>
function Set-GBUsersPassword
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([System.Object[]])]
    Param
    (
        # Users: Gebruikers aanpassen
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNullOrEmpty()]
        [System.Object[]]
        $Users,

        # Lowercase: Aantal kleine letters
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Lowercase,

        # Uppercase: Aantal hoofdletters
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=2)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Uppercase='0',

        # Numbers: Aantal cijfers
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=3)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Numbers='0',

        # Special: Aantal speciale tekens
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=4)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Special='0'
    )

    Begin
    {
        Write-Verbose -Message 'Begin called Set-GBUsersPassword'
    }
    Process
    {
        Write-Verbose -Message 'Process called Set-GBUsersPassword'

        # Array maken
        Write-Verbose -Message 'Array maken'
        $arrUserWW = @()

        # Array vullen --> nog te veranderen in een achtergrondtaak
        Write-Verbose -Message 'Array vullen met wachtwoorden'
        ForEach ($person in $Users)
        {
            $ww = New-GBPassword -Lowercase $Lowercase -Uppercase $Uppercase -Numbers $Numbers -Special $Special -Secure $false
            $arrUserWW += New-GBUserObject -ObjectID $person.ObjectID -Firstname $person.Firstname -Lastname $person.Lastname -Mail $person.UserPrincipalName -Password $ww
        }

        # Array overlopen
        Write-Verbose -Message 'Gebruikers een nieuw wachtwoord geven'
        For($i=0;$i -lt ($arrLKR).Count;$i++)
        {
            # Wachtwoord wijzigen
            ($arrUserWW[$i]).Password
            $tempWW = ($arrUserWW[$i]).Password | ConvertTo-SecureString -AsPlainText -Force
            Set-AzureADUserPassword -ObjectId $Users[$i].ObjectId -Password $tempWW -ForceChangePasswordNextLogin $true
        }
    }
    End
    {
        Write-Verbose -Message 'End called Set-GBUsersPassword'

        # Array met wachtwoorden sturen
        Write-Verbose -Message 'Array met wachtwoorden versturen'
        Return $arrUserWW
    }
}