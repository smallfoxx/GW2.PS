Function Get-GW2WvwAbility {
    <#
    .SYNOPSIS
    Get the wvw/abilities from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Ability"
    }
    Process {
        $APIEndpoint = "wvw/abilities"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2WvwObjective {
    <#
    .SYNOPSIS
    Get the wvw/objectives from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Objective"
    }
    Process {
        $APIEndpoint = "wvw/objectives"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2WvwRank {
    <#
    .SYNOPSIS
    Get the wvw/ranks from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Rank"
    }
    Process {
        $APIEndpoint = "wvw/ranks"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
Function Get-GW2WvwUpgrade {
    <#
    .SYNOPSIS
    Get the wvw/upgrades from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Upgrade"
    }
    Process {
        $APIEndpoint = "wvw/upgrades"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
Function Get-GW2WvwMatch {
    <#
    .SYNOPSIS
    Get the wvw/matches from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Match"
    }
    Process {
        $APIEndpoint = "wvw/matches"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
        