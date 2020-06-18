<#
.Synopsis
    Formulier van de licenties starten
.EXAMPLE
    New-GBFormLicenses
#>
function New-GBFormLicenses
{
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
        $frmLicenses.ClientSize          = '400,400'
        $frmLicenses.text                = "Gebruikersbeheer - Licenties"
        $frmLicenses.TopMost             = $false

        # Label
        $lblUser                         = New-Object system.Windows.Forms.Label
        $lblUser.text                    = "Welkom $env:USERNAME"
        $lblUser.AutoSize                = $true
        $lblUser.width                   = 25
        $lblUser.height                  = 10
        $lblUser.location                = New-Object System.Drawing.Point(203,20)
        $lblUser.Font                    = 'Microsoft Sans Serif,10'

        $lblTitleLLN                        = New-Object system.Windows.Forms.Label
        $lblTitleLLN.text                   = "Licenties leerlingen:"
        $lblTitleLLN.AutoSize               = $true
        $lblTitleLLN.width                  = 25
        $lblTitleLLN.height                 = 10
        $lblTitleLLN.location               = New-Object System.Drawing.Point(31,46)
        $lblTitleLLN.Font                   = 'Microsoft Sans Serif,10'

        $lblTitleLKR                        = New-Object system.Windows.Forms.Label
        $lblTitleLKR.text                   = "Licenties leerkrachten:"
        $lblTitleLKR.AutoSize               = $true
        $lblTitleLKR.width                  = 25
        $lblTitleLKR.height                 = 10
        $lblTitleLKR.location               = New-Object System.Drawing.Point(181,46)
        $lblTitleLKR.Font                   = 'Microsoft Sans Serif,10'

        # Listbox
        $lstLicensesLLN                     = New-Object system.Windows.Forms.ListBox
        $lstLicensesLLN.text                = "Licenses students"
        $lstLicensesLLN.width               = 150
        $lstLicensesLLN.height              = 252
        $lstLicensesLLN.location            = New-Object System.Drawing.Point(31,71)
        $lstLicensesLLN.SelectionMode       = 'MultiExtended'

        $lstLicensesLKR                     = New-Object system.Windows.Forms.ListBox
        $lstLicensesLKR.text                = "Licenses teachers"
        $lstLicensesLKR.width               = 150
        $lstLicensesLKR.height              = 252
        $lstLicensesLKR.location            = New-Object System.Drawing.Point(181,71)
        $lstLicensesLKR.SelectionMode       = 'MultiExtended'

        # Button
        $btnSave                         = New-Object system.Windows.Forms.Button
        $btnSave.text                    = "Opslaan"
        $btnSave.width                   = 65
        $btnSave.height                  = 30
        $btnSave.location                = New-Object System.Drawing.Point(303,345)
        $btnSave.Font                    = 'Microsoft Sans Serif,10'

        $btnCancel                       = New-Object system.Windows.Forms.Button
        $btnCancel.text                  = "Annuleren"
        $btnCancel.width                 = 80
        $btnCancel.height                = 30
        $btnCancel.location              = New-Object System.Drawing.Point(219,345)
        $btnCancel.Font                  = 'Microsoft Sans Serif,10'

        # Add controls to form
        $frmLicenses.controls.AddRange(@($lstLicensesLLN,$lstLicensesLKR,$lblUser,$lblTitleLLN,$lblTitleLKR,$btnSave,$btnCancel))

        # Events
        $frmLicenses.Add_Activated({
            $licenties = Get-GBLicenses
            foreach($licentie in $licenties)
            {
                $lstLicensesLLN.Items.Add($licentie)
            }
        })

        # Assign the Accept and Cancel options in the form to the corresponding buttons
        $frmLicenses.AcceptButton = $btnSave
        $frmLicenses.CancelButton = $btnCancel

        # Show form
        $frmLicenses.ShowDialog()
    }
    End
    {
        Write-Verbose -Message 'End called New-GBFormLicenses'
    }
}