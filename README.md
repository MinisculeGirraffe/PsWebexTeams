# PsWebexTeams

PsWebexTeams is a PowerShell module for interacting with Webex Teams

## Installation

Use Install-Module to install from [PowerShell Gallery](https://www.powershellgallery.com/packages/PsWebexTeams/0.1)

```Powershell
Install-Module PsWebexTeams
```

## Getting an API Token
Currently, the recomended method is to [generate a bot account](https://developer.webex.com/docs/bots) as it uses a static token. 

If you need to act on behalf your own account temporarily using your [personal access token](https://developer.webex.com/docs/api/getting-started) is the simplest method.

Generating an oauth token from an [integration](https://developer.webex.com/docs/integrations) for long term use is the reccomended way to interact with ther API on behalf of a user.  This is not yet supported in the module. 

## Usage

```Powershell
#Setting your API Key
Set-WebexTeamsCredential -token  <API Token>
#Lookup User
Get-WebexTeamsUser -email <Email>
#Lookup messages from user
Get-WebexTeamsUser -email <Email> | Get-WebexTeamsDirectMessage
Get-WebexTeamsDirectMessage -email <User>

#Lookup messages from a room by name
Get-WebexTeamsRoom | ? { $_.title -eq "Name" }| Get-WebexTeamsMessage

#Send message to room
Get-WebexTeamsRoom | ? { $_.title -eq "Name" } | Send-WebexTeamsMessage -text <Text>

#Send message to a user
Send-WebexTeamsMessgae -email <Email> -text <Text>

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## License
[MIT](https://choosealicense.com/licenses/mit/)