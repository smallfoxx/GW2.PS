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

Function Get-GW2AccountPvpHero {
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

Function Get-GW2PvpAmulet {
    <#
    .SYNOPSIS
    Get the pvp/amulets from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$AmuletID
    )
    Process {
        If ($AmuletID) {
            Get-GW2APIValue -APIValue "pvp/amulets" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($AmuletID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "pvp/amulets" -GW2Profile $GW2Profile 
        }
    }
}
    
Function Get-GW2PvpGame {
    <#
    .SYNOPSIS
    Get the pvp/games from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$GameID
    )
    Process {
        If ($GameID) {
            Get-GW2APIValue -APIValue "pvp/games" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($GameID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "pvp/games" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2PvpHero {
    <#
        .SYNOPSIS
        Get the pvp/heroes from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$HeroID
    )
    Process {
        If ($HeroID) {
            Get-GW2APIValue -APIValue "pvp/heroes" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($HeroID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "pvp/heroes" -GW2Profile $GW2Profile
        }
    }
}

Function Get-GW2PvpRank {
    <#
    .SYNOPSIS
    Get the pvp/ranks from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$RankID
    )
    Process {
        If ($RankID) {
            Get-GW2APIValue -APIValue "pvp/ranks" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($RankID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "pvp/ranks" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2PvpSeason {
    <#
    .SYNOPSIS
    Get the pvp/seasons from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$SeasonID
    )
    Process {
        If ($SeasonID) {
            Get-GW2APIValue -APIValue "pvp/seasons" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($SeasonID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "pvp/seasons" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2PvpStanding {
    <#
    .SYNOPSIS
    Get the pvp/standings from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$StandingID
    )
    Process {
        If ($StandingID) {
            Get-GW2APIValue -APIValue "pvp/standings" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($StandingID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "pvp/standings" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2PvpStat {
    <#
    .SYNOPSIS
    Get the pvp/stats from Guild Wars 2 API
    #>
        [cmdletbinding()]
        param(
            [string]$GW2Profile = (Get-GW2DefaultProfile),
            [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
            [Alias("id", "ids")]
            [string[]]$StatID
        )
        Process {
            If ($StatID) {
                Get-GW2APIValue -APIValue "pvp/stats" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($StatID -join ',') }
            }
            else {
                Get-GW2APIValue -APIValue "pvp/stats" -GW2Profile $GW2Profile 
            }
        }
    }
    
