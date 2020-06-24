# Gebruikersbeheer
Gebruikers beheren binnen Microsoft 365, Gsuite en Smartschool vertrekkend vanaf Active Directory

# Te installeren voor deze module:
- Microsoft Azure Active Directory Module for Windows PowerShell
-- via PowerShellGet --> Install-Module -Name MSOnline
- Azure AD PowerShell for Graph (https://www.powershellgallery.com/packages/AzureAD/2.0.2.76)
-- via PowerShellGet --> Install-Module -Name AzureAD
- Restricted Endpoint op de gewenste server (zie ConstrainedEndpoint.ps1)

# Klaar
- Sync voor Microsoft 365 en Gsuite vanuit lokale server
- Microsoft 365

# Geplande werken
- Gsuite
- Smartschool
- Grafische omgeving
- Nieuwe gebruikers aanmaken (= lokaal + sync forceren)
- Uitbreiding van constrained endpoints voor de veiligheid
- Gebruik maken van "-AsJob" of varianten
