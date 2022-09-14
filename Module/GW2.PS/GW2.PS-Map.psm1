Function Get-GW2Dungeon {
    <#
    .SYNOPSIS
    Get the account/dungeons from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/dungeons" -GW2Profile $GW2Profile 
    }
}
    
Function Get-GW2AccountMapchest {
    <#
    .SYNOPSIS
    Get the account/mapchests from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/mapchests" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Adventure {
    <#
    .SYNOPSIS
    Get the adventures from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [int[]]$id
    )
    Process {
        If ($id) {
            Get-GW2APIValue -APIValue "adventures" -GW2Profile $GW2Profile -APIParams @{ "ids" = $id }
        }
        else {
            Get-GW2APIValue -APIValue "adventures" -GW2Profile $GW2Profile
        }
    }
}
    
Function Get-GW2AdventureLeaderboard {
    <#
    .SYNOPSIS
    Get the adventures/(id)/leaderboards from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [oarameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string[]]$id
    )
    Process {
        ForEach ($i in $id) {
            Get-GW2APIValue -APIValue "adventures/$i/leaderboards" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2Continent {
    <#
    .SYNOPSIS
    Get the continents/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "continents" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Map {
    <#
    .SYNOPSIS
    Get the maps from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$MapID
    )
    Begin {
        $Maps = @()
    }
    Process {
        If ($MapID) {
            $Maps += $MapID
        }
    }
    End {
        If ($Maps.Length -gt 0) {
            Get-GW2APIValue -APIValue "maps" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($Maps -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "maps" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2Mapchest {
    <#
    .SYNOPSIS
    Get the mapchests/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "mapchests"
    }
    Process {
        $APIEndpoint = "mapchests"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Worldboss {
    <#
    .SYNOPSIS
    Get the worldbosses/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Worldboss"
    }
    Process {
        $APIEndpoint = "worldbosses"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    