Function Get-GW2Finisher {
    <#
    .SYNOPSIS
    Get the account/finisher from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/finisher" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2PvpHero {
    <#
.SYNOPSIS
Get the account/pvp/heroes from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/pvp/heroes" -GW2Profile $GW2Profile 
    }
}

