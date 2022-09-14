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
    [cmdletbinding(DefaultParameterSetName="CurrentTransactions")]
    param(
        [parameter(ParameterSetName="CurrentTransactions")]
        [switch]$Current,
        [parameter(ParameterSetName="HistoryTransactions",Mandatory)]
        [switch]$History,
        [switch]$Buys,
        [switch]$Sells=(-not $Buys),
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        switch ($PSCmdlet.ParameterSetName) {
            "HistoryTransactions" { $Edition = "history" }
            default { $Edition = "current" }
        }
        If ($Buys -and $Sells) {
            $Result = @{
                "Buys" = Get-GW2APIValue -APIValue "commerce/transactions/$edition/buys" -GW2Profile $GW2Profile
                "Sells" = Get-GW2APIValue -APIValue "commerce/transactions/$edition/sells" -GW2Profile $GW2Profile
            }
            return $Result
        } elseif ($Buys) {
            Get-GW2APIValue -APIValue "commerce/transactions/$edition/sells" -GW2Profile $GW2Profile 
        } else {
            Get-GW2APIValue -APIValue "commerce/transactions/$edition/buys" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2CommerceExchange {
    <#
    .SYNOPSIS
    Get the commerce/exchange from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName="GemsForCoins")]
    param(
        [parameter(ParameterSetName="GoldForGems",ValueFromPipelineByPropertyName,Mandatory)]
        [double]$Gold,
        [parameter(ParameterSetName="GemsForCoins",ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [int]$Gems
    )
    DynamicParam {
        CommonGW2Parameters -IDType "Exchange"
    }
    Process {
        switch ($PSCmdlet.ParameterSetName) {
            "GoldForGems" {
                Get-GW2CommerceExchangeCoin -Gold $Gold
            }
            default {
                If ($Gems) {
                    Get-GW2CommerceExchangeGem -Gems $Gems
                } else {
                    @{
                        "BuyGems" = Get-GW2CommerceExchangeGem
                        "BuyCoins" = Get-GW2CommerceExchangeCoin
                    }
                }
            }
        }
    }
}

Function Get-GW2CommerceExchangeCoin {
    <#
    .SYNOPSIS
    Get the commerce/exchange/coins from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [double]$Gold=1
    )
    DynamicParam {
        CommonGW2Parameters
    }
    Process {
        $APIEndpoint = "commerce/exchange/coins"
        Get-GW2APIValue -APIValue $APIEndpoint -APIParams @{ 'quantity' = [math]::Floor($Gold * 10000) } @PSBoundParameters
    }
}

Function Get-GW2CommerceExchangeGem {
    <#
    .SYNOPSIS
    Get the commerce/exchange/gems from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [int]$Gems=100
    )
    DynamicParam {
        CommonGW2Parameters
    }
    Process {
        $APIEndpoint = "commerce/exchange/gems"
        Get-GW2APIValue -APIValue $APIEndpoint -APIParams @{ 'quantity' = $Gems } @PSBoundParameters
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
    