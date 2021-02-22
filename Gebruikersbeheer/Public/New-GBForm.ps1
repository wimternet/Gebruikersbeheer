<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
		Formulier van de module gebruikersbeheer
	.EXAMPLE
		Formulier aanroepen

		New-GBForm
#>
function New-GBForm
{
    Begin
    {
        Write-Verbose -Message 'Begin called New-GBForm'

        # Formulier mogelijk maken
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.Application]::EnableVisualStyles()
    }
    Process
    {
        Write-Verbose -Message 'Process called New-GBForm'

        # Form
        $frmForm                     = New-Object system.Windows.Forms.Form
        $frmForm.ClientSize          = '700,400'
        $frmForm.text                = "Gebruikersbeheer - Overzicht"
        $frmForm.TopMost             = $false

        # Label
        $lblUser                         = New-Object system.Windows.Forms.Label
        $lblUser.text                    = "Welkom $env:USERNAME"
        $lblUser.AutoSize                = $true
        $lblUser.width                   = 25
        $lblUser.height                  = 10
        $lblUser.location                = New-Object System.Drawing.Point(30,20)
        $lblUser.Font                    = 'Microsoft Sans Serif,10'

        # Button
        $btnSave                         = New-Object system.Windows.Forms.Button
        $btnSave.text                    = "Opslaan"
        $btnSave.width                   = 100
        $btnSave.height                  = 30
        $btnSave.location                = New-Object System.Drawing.Point(600,345)
        $btnSave.Font                    = 'Microsoft Sans Serif,10'

        $btnCancel                       = New-Object system.Windows.Forms.Button
        $btnCancel.text                  = "Annuleren"
        $btnCancel.width                 = 100
        $btnCancel.height                = 30
        $btnCancel.location              = New-Object System.Drawing.Point(480,345)
        $btnCancel.Font                  = 'Microsoft Sans Serif,10'

        $btnPassword                         = New-Object system.Windows.Forms.Button
        $btnPassword.text                    = "Wachtwoord maken"
        $btnPassword.width                   = 100
        $btnPassword.height                  = 30
        $btnPassword.location                = New-Object System.Drawing.Point(360,345)
        $btnPassword.Font                    = 'Microsoft Sans Serif,10'

        # Add controls to form
        $frmForm.controls.AddRange(@($lblUser,$btnSave,$btnCancel,$btnPassword))

        # Events
        $btnSave.Add_Click({
            $frmForm.Close()
        })

        $btnPassword.Add_Click({
            New-GBFormPassword
        })

        # Assign the Accept and Cancel options in the form to the corresponding buttons
        $frmForm.CancelButton = $btnCancel

        # Show form
        $frmForm.ShowDialog()
    }
    End
    {
        Write-Verbose -Message 'End called New-GBForm'
    }
}