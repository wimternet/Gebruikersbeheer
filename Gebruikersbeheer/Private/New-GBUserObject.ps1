<#
.Synopsis
   Create a new object
.EXAMPLE
   $var = New-GBUserObject -User USEROBJECT -Password PASSWORD
#>
function New-GBUserObject
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([System.Object])]
    Param
    (
        # ObjectID: ID van Microsoft 365
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ObjectID,

        # Firstname
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Firstname,

        # Lastname
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=2)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Lastname,

        # Mail: E-mailadres/UserPrincipalName
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=3)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Mail,

        # Password: De string bevat het wachtwoord
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=4)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Password
    )

    Begin
    {
        Write-Verbose -Message 'Begin called New-GBUserObject'
    }
    Process
    {
        Write-Verbose -Message 'Process called New-GBUserObject'

        # Create a new object
        Write-Verbose -Message 'Nieuw object wordt gemaakt'
        New-Object PsObject -Property @{
            ObjectID = $ObjectID;
            FirstName = $Firstname;
            LastName = $Lastname;
            Mail = $Mail;
            Password = $Password
        }
    }
    End
    {
        Write-Verbose -Message 'End called New-GBUserObject'
    }
}