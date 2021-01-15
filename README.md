# PsWebexTeams

PsWebexTeams is a PowerShell module for interacting with Webex Teams

## Installation

Use Install-Module to install from [PowerShell Gallery](https://www.powershellgallery.com/packages/PsWebexTeams/0.1)

```Powershell
Install-Module PsWebexTeams
```

## Usage

```Powershell
#Setting your API Key
Set-WebexTeamsCredential -token  <API Token>
#Lookup User
Get-WebexTeamsUser -email <email>
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## License
[MIT](https://choosealicense.com/licenses/mit/)