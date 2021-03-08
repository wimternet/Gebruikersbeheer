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
        $frmFormPassword                 = New-Object system.Windows.Forms.Form
        $frmFormPassword.ClientSize      = '350,180'
        $frmFormPassword.text            = "Gebruikersbeheer - Wachtwoord"
        $frmFormPassword.TopMost         = $false

        # Group box
        $grpRequirements                 = New-Object System.Windows.Forms.GroupBox
        $grpRequirements.Location        = New-Object System.Drawing.Size(30,45) 
        $grpRequirements.size            = New-Object System.Drawing.Size(200,125)
        $grpRequirements.text            = "Vereisten"
        $frmFormPassword.Controls.Add($grpRequirements) 

        # Label
        $lblUser                         = New-Object system.Windows.Forms.Label
        $lblUser.text                    = "Welkom $env:USERNAME"
        $lblUser.AutoSize                = $true
        $lblUser.width                   = 25
        $lblUser.height                  = 10
        $lblUser.location                = New-Object System.Drawing.Point(30,20)
        $lblUser.Font                    = 'Microsoft Sans Serif,10'
        $frmFormPassword.Controls.Add($lblUser)

        $lblLowercase                    = New-Object system.Windows.Forms.Label
        $lblLowercase.text               = "Aantal kleine letters:"
        $lblLowercase.AutoSize           = $true
        $lblLowercase.width              = 25
        $lblLowercase.height             = 10
        $lblLowercase.location           = New-Object System.Drawing.Point(15,15)
        $lblLowercase.Font               = 'Microsoft Sans Serif,10'
        $grpRequirements.Controls.Add($lblLowercase)

        $lblUppercase                    = New-Object system.Windows.Forms.Label
        $lblUppercase.text               = "Aantal hoofdletters:"
        $lblUppercase.AutoSize           = $true
        $lblUppercase.width              = 25
        $lblUppercase.height             = 10
        $lblUppercase.location           = New-Object System.Drawing.Point(15,35)
        $lblUppercase.Font               = 'Microsoft Sans Serif,10'
        $grpRequirements.Controls.Add($lblUppercase)

        $lblNumbers                      = New-Object system.Windows.Forms.Label
        $lblNumbers.text                 = "Aantal cijfers:"
        $lblNumbers.AutoSize             = $true
        $lblNumbers.width                = 25
        $lblNumbers.height               = 10
        $lblNumbers.location             = New-Object System.Drawing.Point(15,55)
        $lblNumbers.Font                 = 'Microsoft Sans Serif,10'
        $grpRequirements.Controls.Add($lblNumbers)

        $lblSpecial                      = New-Object system.Windows.Forms.Label
        $lblSpecial.text                 = "Aantal speciale tekens:"
        $lblSpecial.AutoSize             = $true
        $lblSpecial.width                = 25
        $lblSpecial.height               = 10
        $lblSpecial.location             = New-Object System.Drawing.Point(15,75)
        $lblSpecial.Font                 = 'Microsoft Sans Serif,10'
        $grpRequirements.Controls.Add($lblSpecial)

        # Textbox
        $txtLowercase                    = New-Object System.Windows.Forms.TextBox
        $txtLowercase.Location           = New-Object System.Drawing.Point(165,15)
        $txtLowercase.Size               = New-Object System.Drawing.Size(20,20)
        $txtLowercase.Multiline          = $false
        $grpRequirements.Controls.Add($txtLowercase)

        $txtUppercase                    = New-Object System.Windows.Forms.TextBox
        $txtUppercase.Location           = New-Object System.Drawing.Point(165,35)
        $txtUppercase.Size               = New-Object System.Drawing.Size(20,20)
        $txtUppercase.Multiline          = $false
        $grpRequirements.Controls.Add($txtUppercase)

        $txtNumbers                      = New-Object System.Windows.Forms.TextBox
        $txtNumbers.Location             = New-Object System.Drawing.Point(165,55)
        $txtNumbers.Size                 = New-Object System.Drawing.Size(20,20)
        $txtNumbers.Multiline            = $false
        $grpRequirements.Controls.Add($txtNumbers)

        $txtSpecial                      = New-Object System.Windows.Forms.TextBox
        $txtSpecial.Location             = New-Object System.Drawing.Point(165,75)
        $txtSpecial.Size                 = New-Object System.Drawing.Size(20,20)
        $txtSpecial.Multiline            = $false
        $grpRequirements.Controls.Add($txtSpecial)

        # Radiobutton
        $chkSecure                       = New-Object System.Windows.Forms.CheckBox
        $chkSecure.Location              = New-Object System.Drawing.Point(15,95)
        $chkSecure.Text                  = "Verborgen"
        $grpRequirements.Controls.Add($chkSecure)

        # Button
        $btnSave                         = New-Object system.Windows.Forms.Button
        $btnSave.text                    = "Opslaan"
        $btnSave.width                   = 80
        $btnSave.height                  = 30
        $btnSave.location                = New-Object System.Drawing.Point(250,140)
        $btnSave.Font                    = 'Microsoft Sans Serif,10'
        $frmFormPassword.Controls.Add($btnSave)

        $btnCancel                       = New-Object system.Windows.Forms.Button
        $btnCancel.text                  = "Annuleren"
        $btnCancel.width                 = 80
        $btnCancel.height                = 30
        $btnCancel.location              = New-Object System.Drawing.Point(250,110)
        $btnCancel.Font                  = 'Microsoft Sans Serif,10'
        $frmFormPassword.Controls.Add($btnCancel)

        # Events
        $btnSave.Add_Click({
            $Script:Password = New-GBPassword -Lowercase $txtLowercase.Text -Uppercase $txtUppercase.Text -Numbers $txtNumbers.Text -Special $txtSpecial.Text -Secure $chkSecure.Checked
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