<#
	Written by wimternet (https://github.com/wimternet)
    .Synopsis
		Licenties opvragen
	.EXAMPLE
		Get-GBLicenses [-fileTeachers PATH] [-fileStudents PATH]
#>
function Get-GBLicenses
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # fileTeachers: File with licenses for the teachers
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [string]
        $fileTeachers = $null,

        # fileStudents: File with licenses for the students
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [string]
        $fileStudents = $null
    )
    
    Begin
    {
        Write-Verbose -Message 'Begin called Get-GBLicenses'

        # Controle
        Write-Verbose -Message "De bestanden"
        Write-Verbose -Message $fileTeachers
        Write-Verbose -Message $fileStudents

        # Licenties ophalen
        If(($fileTeachers -ne $null) -and ($fileStudents -ne $null))
        {
            $LicTeachers = Get-Content -Path $fileTeachers
            $LicStudents = Get-Content -Path $fileStudents
        }ElseIf (($fileTeachers -ne $null) -and ($fileStudents -eq $null)){
            $LicTeachers = Get-Content -Path $fileTeachers
        }ElseIf (($fileTeachers -eq $null) -and ($fileStudents -ne $null)){
            $LicStudents = Get-Content -Path $fileStudents
        }

        # Controle
        Write-Verbose -Message "De licenties"
        Write-Verbose -Message "Teacher"
        Write-Verbose -Message "$LicTeachers"
        Write-Verbose -Message "Students"
        Write-Verbose -Message "$LicStudents"
    }
    Process
    {
        Write-Verbose -Message 'Process called Get-GBLicenses'
        
        # Licenties opvragen
        Write-Verbose -Message 'Licenties opvragen'
        $licenties = Get-MsolAccountSku

        # Indien het venster is gemaakt, vul de listbox
        If(Get-Variable -Name lstLicensesLKR -ErrorAction SilentlyContinue)
        {
            # Listboxen vullen
            Write-Verbose -Message 'Formulier is gemaakt en dus worden de listboxen gevuld'
            foreach($licentie in $licenties)
            {
                $lstLicensesLLN.Items.Add($licentie.AccountSkuId)
                $lstLicensesLKR.Items.Add($licentie.AccountSkuId)
            }

            # Voorgaande licenties bijwerken als die al bestaan
            Write-Verbose -Message 'Vorige selectie opnieuw selecteren'
            If($LicTeachers -ne $null)
            {
                Write-Verbose -Message 'If $licTeachers -ne $null'
                foreach ($lic in $LicTeachers)
                {
                    Write-Verbose -Message 'Foreach($lic in $LicTeachers)'
                    $tmpIndex = $lstLicensesLKR.Items.IndexOf($lic)
                    $lstLicensesLKR.SetSelected($tmpIndex,$true)
                }
            }
            If($LicStudents -ne $null)
            {
                foreach ($lic in $LicStudents)
                {
                    Write-Verbose -Message 'Foreach($lic in $LicStudents)'
                    $tmpIndex = $lstLicensesLLN.Items.IndexOf($lic)
                    $lstLicensesLLN.SetSelected($tmpIndex,$true)
                }
            }
        }
    }
    End
    {
        Write-Verbose -Message 'End called Get-GBLicenses'

        # Licenties terugsturen
        Write-Verbose -Message 'Online licenties terugsturen naar de console'
        Return $licenties
    }
}