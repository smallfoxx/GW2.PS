Function Get-GW2Material {
    <#
    .SYNOPSIS
    Get the account/materials from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/materials" -GW2Profile $GW2Profile 
    }
}
    
Function Get-GW2Mini {
    <#
    .SYNOPSIS
    Get the account/minis from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/minis" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2MountSkin {
    <#
    .SYNOPSIS
    Get the account/mount/skins from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/mount/skins" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2MountType {
    <#
    .SYNOPSIS
    Get the account/mount/types from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/mount/types" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Novelty {
    <#
    .SYNOPSIS
    Get the account/novelties from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/novelties" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2AccountOutfit {
    <#
.SYNOPSIS
Get the account/outfits from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/outfits" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2AccountSkin {
    <#
.SYNOPSIS
Get the account/skins from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/skins" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Color {
    <#
    .SYNOPSIS
    Get the colors/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "colors" -GW2Profile $GW2Profile 
    }
}
    
Function Get-GW2Finisher {
    <#
    .SYNOPSIS
    Get the finishers from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Finisher"
    }
    Process {
        $APIEndpoint = "finishers"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Item {
    <#
    .SYNOPSIS
    Get the items from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Item"
    }
    Process {
        $APIEndpoint = "items"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
Function Get-GW2ItemStat {
    <#
    .SYNOPSIS
    Get the itemstats from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Stat"
    }
    Process {
        $APIEndpoint = "itemstats"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
Function Get-GW2Material {
    <#
    .SYNOPSIS
    Get the materials/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Material"
    }
    Process {
        $APIEndpoint = "materials"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Skin {
    <#
    .SYNOPSIS
    Get the skins/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Skin"
    }
    Process {
        $APIEndpoint = "skins"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2LegendaryArmory {
    <#
    .SYNOPSIS
    Get the legendaryarmory/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Armory"
    }
    Process {
        $APIEndpoint = "legendaryarmory"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2HomeCat {
    <#
    .SYNOPSIS
    Get the home/cats from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Cat"
    }
    Process {
        $APIEndpoint = "home/cats"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2HomeNode {
    <#
    .SYNOPSIS
    Get the home/nodes from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Node"
    }
    Process {
        $APIEndpoint = "home/nodes"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
