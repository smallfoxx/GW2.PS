Function Get-GW2CommerceDelivery {
    <#
    .SYNOPSIS
    Get the commerce/delivery from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "commerce/delivery" -GW2Profile $GW2Profile 
    }
}
    
Function Get-GW2CommerceTransaction {
    <#
    .SYNOPSIS
    Get the commerce/transactions from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "commerce/transactions" -GW2Profile $GW2Profile 
    }
}

    