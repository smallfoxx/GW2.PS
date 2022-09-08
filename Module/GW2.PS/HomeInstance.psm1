Function Get-GW2HomeCat {
    <#
    .SYNOPSIS
    Get the account/home/cat from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/home/cat" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2HomeNode {
    <#
    .SYNOPSIS
    Get the account/home/node from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/home/node" -GW2Profile $GW2Profile 
    }
}
        
