class Omgeving
{
    [String]$naam
    static [int]$test=5

    Write ()
    {
        Write-Host $this.naam
    }
}