# PsWebexTeams

PsWebexTeams is a PowerShell module for interacting with Webex Teams

## Installation

Use Install-Module to install from [PowerShell Gallery](https://www.powershellgallery.com/packages/PsWebexTeams/0.1)

```Powershell
Install-Module PsWebexTeams
```




### Authentication
The primary goal of this module is interacting with Webex teams without state. This is not for building a chatbot.  If that’s what you’re looking to do, please use the[ nodeJS bot framework](https://developer.webex.com/blog/introducing-the-webex-teams-bot-framework-for-node-js) to support web hooks.

API tokens will be saved in the following directories.
- Windows:
`"$env:LOCALAPPDATA\PSWebexTeams\PSWebexTeamsConfig.xml"`
- MacOS / Linux
`"$env:HOME/.config/powershell/PSWebexTeamsConfig.xml"`

When running any commands, they will check this file for the auth token to prevent authentication params having to be passed to each function.

#### Bot Auth
The easiest way to get started with this module is to use a bot. The authentication tokens are static, and won’t have to be refreshed. See  Webex documentation for more info in [creating bots](https://developer.webex.com/docs/bots).

Once we’ve created out bot API keys we need to save them to our PC.

```powershell
Set-WebexTeamsCredential -token  <API Token>
```

#### OAuth (User Authentication)
To act on behalf of a user account, you first need to setup [an integration](https://developer.webex.com/docs/integrations)

The OAuth flow can be completed without running a web server. Set the redirectUri to be a non-existent domain/one that you own.

You will be given two pieces of information, A client ID and Secret. Save both off to the side for now.

You will need to authorize the integration to act on behalf of your account, there will be a pre-generated link on the integration. Paste the link into your browser to grant an authentication code. You can exchange your authentication code into a refresh token by running the following.
```powershell
$splat = @{
    clientID     = 'Replace Me'
    clientSecret = 'Replace Me'
    redirectURI  = "Replace Me"
    accessCode   = "Replace Me"
}

$refreshInfo = New-WebexTeamsRefreshToken @splat
Set-WebexTeamsCredential -token $refreshInfo.access_token -refreshinfo $refreshInfo
```

A hook is built into each command to re-issue a refresh/access token when necessary. If no commands are ran within 90 days, the authentication code process will have to be repeated to issue a new refresh token. 

To manually issue a new access token, and reset the refresh token’s 90-day timer run the following

```powershell
$configpath = Resolve-WebexTeamsConfigPath
$config = Import-Clixml $configpath
$token = New-WebexTeamsAccessToken -clientID $config.refreshinfo.client_id `
	-clientSecret $config.refreshinfo.client_secret `
	-refreshToken $config.refreshinfo.refresh_token
}
```

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