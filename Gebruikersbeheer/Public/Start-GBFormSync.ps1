<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
		Formulier om de sync te starten
	.EXAMPLE
		Formulier aanroepen

		Start-GBFormSync
#>
function Start-GBFormSync
{
    Begin
    {
        Write-Verbose -Message 'Begin called Start-GBFormSync'

        # Formulier mogelijk maken
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.Application]::EnableVisualStyles()
    }
    Process
    {
        Write-Verbose -Message 'Process called Start-GBFormSync'

        # Form
        $frmFormSync                 = New-Object system.Windows.Forms.Form
        $frmFormSync.ClientSize      = '315,180'
        $frmFormSync.text            = "Gebruikersbeheer - Sync"
        $frmFormSync.TopMost         = $false

        # Group box
        $grpOptions                 = New-Object System.Windows.Forms.GroupBox
        $grpOptions.Location        = New-Object System.Drawing.Size(30,45) 
        $grpOptions.size            = New-Object System.Drawing.Size(165,125)
        $grpOptions.text            = "Opties"
        $frmFormSync.Controls.Add($grpOptions) 

        # Label
        $lblUser                         = New-Object system.Windows.Forms.Label
        $lblUser.text                    = "Welkom $env:USERNAME"
        $lblUser.AutoSize                = $true
        $lblUser.width                   = 25
        $lblUser.height                  = 10
        $lblUser.location                = New-Object System.Drawing.Point(30,20)
        $lblUser.Font                    = 'Microsoft Sans Serif,10'
        $frmFormSync.Controls.Add($lblUser)

        $lblServer                    = New-Object system.Windows.Forms.Label
        $lblServer.text               = "Sync-server:"
        $lblServer.AutoSize           = $true
        $lblServer.width              = 25
        $lblServer.height             = 10
        $lblServer.location           = New-Object System.Drawing.Point(15,15)
        $lblServer.Font               = 'Microsoft Sans Serif,10'
        $grpOptions.Controls.Add($lblServer)

        $lblConfig                    = New-Object system.Windows.Forms.Label
        $lblConfig.text               = "Config:"
        $lblConfig.AutoSize           = $true
        $lblConfig.width              = 25
        $lblConfig.height             = 10
        $lblConfig.location           = New-Object System.Drawing.Point(15,35)
        $lblConfig.Font               = 'Microsoft Sans Serif,10'
        $grpOptions.Controls.Add($lblConfig)

        # Textbox
        $txtServer                    = New-Object System.Windows.Forms.TextBox
        $txtServer.Location           = New-Object System.Drawing.Point(100,15)
        $txtServer.Size               = New-Object System.Drawing.Size(50,20)
        $txtServer.Multiline          = $false
        $grpOptions.Controls.Add($txtServer)

        $txtConfig                    = New-Object System.Windows.Forms.TextBox
        $txtConfig.Location           = New-Object System.Drawing.Point(100,35)
        $txtConfig.Size               = New-Object System.Drawing.Size(50,20)
        $txtConfig.Multiline          = $false
        $txtConfig.Text               = "IT"
        $grpOptions.Controls.Add($txtConfig)
        
        # Radiobutton
        
        # Button
        $btnSave                         = New-Object system.Windows.Forms.Button
        $btnSave.text                    = "Starten"
        $btnSave.width                   = 80
        $btnSave.height                  = 30
        $btnSave.location                = New-Object System.Drawing.Point(215,140)
        $btnSave.Font                    = 'Microsoft Sans Serif,10'
        $frmFormSync.Controls.Add($btnSave)

        $btnCancel                       = New-Object system.Windows.Forms.Button
        $btnCancel.text                  = "Annuleren"
        $btnCancel.width                 = 80
        $btnCancel.height                = 30
        $btnCancel.location              = New-Object System.Drawing.Point(215,110)
        $btnCancel.Font                  = 'Microsoft Sans Serif,10'
        $frmFormSync.Controls.Add($btnCancel)

        # Events
        $btnSave.Add_Click({
            Get-GBMessagebox -Icon Information -Button OK -Title "Goed zo!" -Message ("De sync is 'vertrokken' op server '" + $txtServer.Text + "' met config '" + $txtConfig.Text + "'")
            $frmFormSync.Close()
        })

        # Assign the Accept and Cancel options in the form to the corresponding buttons
        $frmFormSync.CancelButton = $btnCancel

        # Show form
        $frmFormSync.ShowDialog()
    }
    End
    {
        Write-Verbose -Message 'End called Start-GBFormSync'
    }
}