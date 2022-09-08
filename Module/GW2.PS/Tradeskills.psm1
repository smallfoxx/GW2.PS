Function Get-GW2Dailycrafting {
    <#
    .SYNOPSIS
    Get the account/dailycrafting from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/dailycrafting" -GW2Profile $GW2Profile 
    }
}
    
Function Get-GW2Recipe {
    <#
.SYNOPSIS
Get the account/recipes from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/recipes" -GW2Profile $GW2Profile 
    }
}
