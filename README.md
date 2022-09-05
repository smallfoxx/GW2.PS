# Welcome to the PowerShell Module for Guild Wars 2 API: PoShGW2

Recently ArenaNET celebrated the 10th Anniversary of Guild Wars 2 (2012-2022).  For years, Guild Wars 2 has had an [API](https://wiki.guildwars2.com/wiki/API:Main)
for accessing your in game details as well as allowing third party applications to share in this information.  However, absent from the list of
[wrappers](https://wiki.guildwars2.com/wiki/API:List_of_wrappers) and [applications](https://wiki.guildwars2.com/wiki/API:List_of_applications) is a PowerShell based
module.

Enter **PoShGW2** (queue dramatic them music with sweeping visualization [pending budgettary needs])

## Installation

The intention is to install the module from the PowerShell Gallery with the following command:

    Install-Module -Name PoShGW2

However, this is still in pre-production, so if you want to use this early, you can download the contents of the [Module](/smallfoxx/PoShGW2/tree/main/Module) folder to your local system and run:

    Import-Module <pathToDownloadFolder>\PoShGW2.psd1

## Setup

Once installed, you will need to setup an API Key for the module to authenticate to Guild Wars 2.  You can obtain a key from the [Applications](https://account.arena.net/applications)
page of your ArenaNet Account:

1. Go to [Applications](https://account.arena.net/applications) (https://account.arena.net/applications) and login with your Guild Wars 2 ArenaNet account
1. Click **New Key**
1. Under the name of the application use "PoShGW2" (or something memorable to you)
1. Check all the boxes under the name (or only those you want to make available to the module)
1. Click **Create API Key** button
1. In the API key list, find the one with the name you used in step 3 (ie: PoShGW2)
1. Click the Copy icon next to the name
1. Open up the PowerShell window where you have **PoShGW2** installed
1. Run the following command, pasting in the API Key when prompted and hit enter

    Set-GW2APIKey

> Note: You can optionally include the `-GW2Profile <ProfileName>` property if you would like to maintain more than one account.

## Example(s)

Once the module is installed and setup, you can then run common commands to retrieve data about your account.  For example, if you would like to retrieve your
daily achievements, you can run the following command:

    Get-GW2Achievement -Daily
    
## Documentation

For additional details and instructions, please see the repositories [Wiki](https://github.com/smallfoxx/PoShGW2/wiki) at:

https://github.com/smallfoxx/PoShGW2/wiki

## License

This project is published under the MIT License.  Full details available in the [LICENSE](/smallfoxx/PoShGW2/blob/main/LICENSE) file of the repository.

Copyright (c) 2022 SmallFoxx
