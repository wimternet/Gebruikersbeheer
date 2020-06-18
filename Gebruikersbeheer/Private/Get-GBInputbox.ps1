<#
.Synopsis
   Inputbox tonen
.EXAMPLE
   $var = Get-GBInputbox -Title TITEL -Message BOODSCHAP
#>
function Get-GBInputbox
{
    [CmdletBinding()]
    Param
    (
        # Title
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Title,

        # Message
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message
    )

    Begin
    {
        Add-Type -AssemblyName Microsoft.VisualBasic
    }
    Process
    {
        $User = [Microsoft.VisualBasic.Interaction]::InputBox($Message, $Title)
    }
    End
    {
    }
}