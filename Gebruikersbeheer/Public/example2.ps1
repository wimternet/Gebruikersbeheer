<#
.Synopsis
    Formulier van de licenties starten
.EXAMPLE
    New-GBFormLicenses
#>
function New-GBFormLicenses
{
    # Formulier mogelijk maken
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()
    
    # Form
    $frmLicenses                     = New-Object system.Windows.Forms.Form
    $frmLicenses.ClientSize          = '400,400'

    # Label
    $lblUser                         = New-Object system.Windows.Forms.Label
    ....

    $lblTitle                        = New-Object system.Windows.Forms.Label
    ....

    # Listbox
    $script:lstLicenses                     = New-Object system.Windows.Forms.ListBox
    $lstLicenses.text                = "Licenses"
    $lstLicenses.width               = 150
    $lstLicenses.height              = 252
    $lstLicenses.location            = New-Object System.Drawing.Point(31,71)
    $lstLicenses.SelectionMode       = 'MultiExtended'

    # Button
    $btnSave                         = New-Object system.Windows.Forms.Button
    ....

    $btnCancel                       = New-Object system.Windows.Forms.Button
    ....

    # Add controls to form
    $frmLicenses.controls.AddRange(@($lstLicenses,$lblUser,$lblTitle,$btnSave,$btnCancel))

    # Events
    $frmLicenses.Add_Activated({ Get-GBLicenses })

    # Assign the Accept and Cancel options in the form to the corresponding buttons
    $frmLicenses.AcceptButton = $btnSave
    $frmLicenses.CancelButton = $btnCancel

    # Show form
    $frmLicenses.ShowDialog()
}


<#
.Synopsis
    Licenties opvragen
.EXAMPLE
    Get-GBLicenses
#>
function Get-GBLicenses
{
    $licenties = Get-MsolAccountSku
    foreach($licentie in $licenties)
    {
        $lstLicenses.Items.Add($licentie)
    }
}