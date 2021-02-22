<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
		Formulier om een nieuw wachtwoord in te stellen
	.EXAMPLE
		Formulier aanroepen

		New-GBFormPassword
#>
function New-GBFormPassword
{
    Begin
    {
        Write-Verbose -Message 'Begin called New-GBFormPassword'

        # Formulier mogelijk maken
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.Application]::EnableVisualStyles()
    }
    Process
    {
        Write-Verbose -Message 'Process called New-GBFormPassword'

        # Form
        $frmFormPassword                     = New-Object system.Windows.Forms.Form
        $frmFormPassword.ClientSize          = '700,400'
        $frmFormPassword.text                = "Gebruikersbeheer - Wachtwoord"
        $frmFormPassword.TopMost             = $false

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
        $frmFormPassword.controls.AddRange(@($lblUser,$btnSave,$btnCancel))

        # Events
        $btnSave.Add_Click({
            $Script:Password = New-GBPassword -Lowercase 5 -Secure $false
            $frmFormPassword.Close()
        })

        # Assign the Accept and Cancel options in the form to the corresponding buttons
        $frmFormPassword.CancelButton = $btnCancel

        # Show form
        $frmFormPassword.ShowDialog()
    }
    End
    {
        Write-Verbose -Message 'End called New-GBFormPassword'
    }
}