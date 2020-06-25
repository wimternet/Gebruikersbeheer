<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
	   Messagebox tonen
	.EXAMPLE
	   Get-GBMessagebox -Icon Error/Warning/Information/Asterisk/Exclamation/Hand/None/Question/Stop -Buttons OK/OKCancel/YesNo/YesNoCancel -Title TITEL -Message BOODSCHAP
#>
function Get-GBMessagebox
{
    [CmdletBinding()]
    Param
    (
        # Icon
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [ValidateCount(0,15)]
        [ValidateSet("Error","Warning","Information","Asterisk","Exclamation","Hand","None","Question","Stop")]
        $Icon,

         # Button
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNullOrEmpty()]
        [ValidateCount(0,15)]
        [ValidateSet("OK","OKCancel","YesNo","YesNoCancel")]
        $Button,

        # Title
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=2)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Title,

        # Message
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=3)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message
    )

    Begin
    {
        Add-Type -AssemblyName PresentationCore,PresentationFramework
    }
    Process
    {
        $ButtonType = [System.Windows.MessageBoxButton]::$Button	
        $MessageIcon = [System.Windows.MessageBoxImage]::$Icon

        [System.Windows.MessageBox]::Show($Message,$Title,$ButtonType,$MessageIcon)
    }
    End
    {
    }
}