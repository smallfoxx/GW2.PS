Function Get-GW2Currency {
    <#
    .SYNOPSIS
    Get the currencies from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Currency"
    }
    Process {
        $APIEndpoint = "currencies"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Dungeon {
    <#
    .SYNOPSIS
    Get the dungeons/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Dungeon"
    }
    Process {
        $APIEndpoint = "dungeons"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
Function Get-GW2EventState {
    <#
    .SYNOPSIS
    Get the events-state from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "events-state" -GW2Profile $GW2Profile 
    }
}
    
Function Get-GW2Mini {
    <#
        .SYNOPSIS
        Get the minis/ from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Mini"
    }
    Process {
        $APIEndpoint = "minis"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Novelty {
    <#
    .SYNOPSIS
    Get the novelties from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Novelty"
    }
    Process {
        $APIEndpoint = "novelties"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
Function Get-GW2Raid {
    <#
    .SYNOPSIS
    Get the raids/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Raid"
    }
    Process {
        $APIEndpoint = "raids"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
Function Get-GW2Title {
    <#
    .SYNOPSIS
    Get the titles/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Title"
    }
    Process {
        $APIEndpoint = "titles"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2World {
    <#
    .SYNOPSIS
    Get the worlds/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "World"
    }
    Process {
        $APIEndpoint = "worlds"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Build {
    <#
    .SYNOPSIS
    Get the build/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Build"
    }
    Process {
        $APIEndpoint = "build"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2File {
    <#
    .SYNOPSIS
    Get the files/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "File"
    }
    Process {
        $APIEndpoint = "files"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Quaggan {
    <#
    .SYNOPSIS
    Get the quaggans/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Quaggan"
    }
    Process {
        $APIEndpoint = "quaggans"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
