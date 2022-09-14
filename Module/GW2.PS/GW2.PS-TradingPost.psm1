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

Function Get-GW2CommerceExchange {
    <#
    .SYNOPSIS
    Get the commerce/exchange from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Exchange"
    }
    Process {
        $APIEndpoint = "commerce/exchange"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2CommerceExchangeCoin {
    <#
    .SYNOPSIS
    Get the commerce/exchange/coins from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Coin"
    }
    Process {
        $APIEndpoint = "commerce/exchange/coins"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2CommerceExchangeGem {
    <#
    .SYNOPSIS
    Get the commerce/exchange/gems from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Gem"
    }
    Process {
        $APIEndpoint = "commerce/exchange/gems"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2CommerceListing {
    <#
    .SYNOPSIS
    Get the commerce/listings from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Listing"
    }
    Process {
        $APIEndpoint = "commerce/listings"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2CommercePrice {
    <#
    .SYNOPSIS
    Get the commerce/prices from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Price"
    }
    Process {
        $APIEndpoint = "commerce/prices"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    