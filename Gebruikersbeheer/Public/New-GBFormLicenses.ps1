<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
		Formulier van de licenties starten
	.EXAMPLE
		Nieuwe licentiebestanden maken

		New-GBFormLicenses
	.EXAMPLE
		Licentiebestanden bijwerken

		New-GBFormLicenses -fileTeachers PATH -fileStudensts PATH
#>
function New-GBFormLicenses
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # fileTeachers: File with licenses for the teachers
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [string]
        $fileTeachers,

        # fileStudents: File with licenses for the students
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [string]
        $fileStudents
    )
    
    Begin
    {
        Write-Verbose -Message 'Begin called New-GBFormLicenses'

        # Formulier mogelijk maken
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.Application]::EnableVisualStyles()
    }
    Process
    {
        Write-Verbose -Message 'Process called New-GBFormLicenses'

        # Form
        $frmLicenses                     = New-Object system.Windows.Forms.Form
        $frmLicenses.ClientSize          = '700,400'
        $frmLicenses.text                = "Gebruikersbeheer - Licenties"
        $frmLicenses.TopMost             = $false

        # Label
        $lblUser                         = New-Object system.Windows.Forms.Label
        $lblUser.text                    = "Welkom $env:USERNAME"
        $lblUser.AutoSize                = $true
        $lblUser.width                   = 25
        $lblUser.height                  = 10
        $lblUser.location                = New-Object System.Drawing.Point(30,20)
        $lblUser.Font                    = 'Microsoft Sans Serif,10'

        $lblTitleLLN                        = New-Object system.Windows.Forms.Label
        $lblTitleLLN.text                   = "Licenties leerlingen:"
        $lblTitleLLN.AutoSize               = $true
        $lblTitleLLN.width                  = 25
        $lblTitleLLN.height                 = 10
        $lblTitleLLN.location               = New-Object System.Drawing.Point(30,45)
        $lblTitleLLN.Font                   = 'Microsoft Sans Serif,10'

        $lblTitleLKR                        = New-Object system.Windows.Forms.Label
        $lblTitleLKR.text                   = "Licenties leerkrachten:"
        $lblTitleLKR.AutoSize               = $true
        $lblTitleLKR.width                  = 25
        $lblTitleLKR.height                 = 10
        $lblTitleLKR.location               = New-Object System.Drawing.Point(350,45)
        $lblTitleLKR.Font                   = 'Microsoft Sans Serif,10'

        # Listbox
        $global:lstLicensesLLN              = New-Object system.Windows.Forms.ListBox
        $lstLicensesLLN.text                = "Licenses students"
        $lstLicensesLLN.width               = 300
        $lstLicensesLLN.height              = 250
        $lstLicensesLLN.location            = New-Object System.Drawing.Point(30,70)
        $lstLicensesLLN.SelectionMode       = 'MultiExtended'

        $global:lstLicensesLKR              = New-Object system.Windows.Forms.ListBox
        $lstLicensesLKR.text                = "Licenses teachers"
        $lstLicensesLKR.width               = 300
        $lstLicensesLKR.height              = 250
        $lstLicensesLKR.location            = New-Object System.Drawing.Point(350,70)
        $lstLicensesLKR.SelectionMode       = 'MultiExtended'

        # Button
        $btnSave                         = New-Object system.Windows.Forms.Button
        $btnSave.text                    = "Opslaan"
        $btnSave.width                   = 65
        $btnSave.height                  = 30
        $btnSave.location                = New-Object System.Drawing.Point(600,345)
        $btnSave.Font                    = 'Microsoft Sans Serif,10'

        $btnCancel                       = New-Object system.Windows.Forms.Button
        $btnCancel.text                  = "Annuleren"
        $btnCancel.width                 = 80
        $btnCancel.height                = 30
        $btnCancel.location              = New-Object System.Drawing.Point(500,345)
        $btnCancel.Font                  = 'Microsoft Sans Serif,10'

        # Add controls to form
        $frmLicenses.controls.AddRange(@($lstLicensesLLN,$lstLicensesLKR,$lblUser,$lblTitleLLN,$lblTitleLKR,$btnSave,$btnCancel))

        # Events
        $frmLicenses.Add_Load({ Get-GBLicenses -fileTeachers $fileTeachers -fileStudents $fileStudents | Out-Null })
        $btnSave.Add_Click({
            Save-GBFormLicenses -fileLLN $fileStudents -fileLKR $fileTeachers
            $frmLicenses.Close()
        })

        # Assign the Accept and Cancel options in the form to the corresponding buttons
        $frmLicenses.CancelButton = $btnCancel

        # Show form
        $frmLicenses.ShowDialog()
    }
    End
    {
        Write-Verbose -Message 'End called New-GBFormLicenses'
    }
}