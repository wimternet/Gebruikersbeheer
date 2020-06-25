<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
	   Start de synchronisatie met de cloud
	.DESCRIPTION
	   Synchroniseer de lokale AD met AzureAD en met Gsuite
	.EXAMPLE
	   Start-GBSync -Server SERVER -Config CONFIG -Cloud Alle/Azure/Gsuite -TypeSync Delta/Initial/Unspecified
#>
function Start-GBSync
{
    [CmdletBinding()]
    Param
    (
        # Server: Server met de nodige sync-tools op
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Server,

        # Config: De juiste PSSession Configuration Name
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Config,

        # Cloud: Kiezen welke cloud moet syncen (Alle, Azure, Gsuite)
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=2)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("Alle", "Azure", "Gsuite")]
        $Cloud,

        # TypeSync: Delta, Initial of Unspecified
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=3)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("Delta", "Initial", "Unspecified")]
        $TypeSync
    )

    Begin
    {
        Write-Verbose -Message 'Begin called Start-GBSync'

        # Nodige modules laden
        If (($Cloud -eq 'Azure') -or ($Cloud -eq 'Alle'))
        {
            Write-Verbose -Message 'Het gaat over Azure of Alle'
            
            # Verbinding maken met externe pc
            Write-Verbose -Message 'Sessie maken op de externe pc'
            #$s = New-PSSession -ComputerName $Server -Credential $env:USERNAME -ConfigurationName $Config
            $sAzure = New-PSSession -ComputerName $Server -ConfigurationName $Config
            
            # Modules laden
            Write-Verbose -Message 'Module inladen'
            Invoke-Command -Session $sAzure -ScriptBlock {Import-Module -Name ADSync}
        }
    }
    Process
    {
        Write-Verbose -Message 'Process called Start-GBSync'

        If (($Cloud -eq 'Azure') -or ($Cloud -eq 'Alle'))
        {
            Write-Verbose -Message 'Het gaat over Azure of Alle'

            # Sync AzureAD
            Invoke-Command -Session $sAzure -ScriptBlock {Start-ADSyncSyncCycle -PolicyType $TypeSync} -AsJob | Out-Null
            Write-Verbose -Message 'AzureAD sync is gestart'
        }

        If (($Cloud -eq 'Gsuite') -or ($Cloud -eq 'Alle'))
        {
            Write-Verbose -Message 'Het gaat over Gsuite of Alle'

            # Verbinding maken met externe pc
            Write-Verbose -Message 'Sessie maken op de externe pc'
            $sGsuite = New-PSSession -ComputerName $Server -ConfigurationName $Config

            # Sync Gsuite
            Invoke-Command -Session $sGsuite -ScriptBlock {Set-Location -Path "C:\Program Files\Google Cloud Directory Sync\"}
            Write-Verbose -Message 'Locatie aangepast'
            Invoke-Command -Session $sGsuite -ScriptBlock {.\sync-cmd.exe -a -c C:\Scripts\sync2.xml} -AsJob | Out-Null
            Write-Verbose -Message 'Gsuite sync is gestart'
        }
    }
    End
    {
        Write-Verbose -Message 'End called Start-GBSync'

        # Wachten tot de taken zijn volbracht
        Get-Job | Wait-Job | Out-Null
        Get-Job -State Completed | Remove-Job
        Get-Job -State Failed | Remove-Job
        Write-Verbose -Message 'Achtergrondtaken zijn volbracht en opgekuisd'

        # Sessie verwijderen
        If (($Cloud -eq 'Azure') -or ($Cloud -eq 'Alle'))
        {
            Write-Verbose -Message 'Het gaat over Azure of Alle'

            # Verbinding verbreken met externe pc
            Remove-PSSession -Session $sAzure
            Write-Verbose -Message 'Externe sessie afgesloten'
        }
        If (($Cloud -eq 'Gsuite') -or ($Cloud -eq 'Alle'))
        {
            Write-Verbose -Message 'Het gaat over Gsuite of Alle'

            # Verbinding verbreken met externe pc
            Remove-PSSession -Session $sGsuite
            Write-Verbose -Message 'Externe sessie afgesloten'
        }
    }
}