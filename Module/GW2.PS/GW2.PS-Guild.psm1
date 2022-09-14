Function Get-GW2Guild {
    <#
    .SYNOPSIS
    Get the guild from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Guild' -IDMandatory
    }
    Process {
        $APIEndpoint = "guild/:id"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2GuildLog {
    <#
        .SYNOPSIS
        Get the guild/:id/log from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline, Mandatory)]
        [Alias("GuildID")]
        [string]$ID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$ID/log" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2GuildMember {
    <#
            .SYNOPSIS
            Get the guild/:id/members from Guild Wars 2 API
            #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline, Mandatory)]
        [Alias("GuildID")]
        [string]$ID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$ID/members" -GW2Profile $GW2Profile 
    }
}
            
Function Get-GW2GuildRank {
    <#
                .SYNOPSIS
                Get the guild/:id/ranks from Guild Wars 2 API
                #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline, Mandatory)]
        [Alias("GuildID")]
        [string]$ID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$ID/ranks" -GW2Profile $GW2Profile 
    }
}
                
Function Get-GW2GuildStash {
    <#
                    .SYNOPSIS
                    Get the guild/:id/stash from Guild Wars 2 API
                    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline, Mandatory)]
        [Alias("GuildID")]
        [string]$ID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$ID/stash" -GW2Profile $GW2Profile 
    }
}
                    
Function Get-GW2GuildStorage {
    <#
    .SYNOPSIS
    Get the guild/:id/storage from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline, Mandatory)]
        [Alias("GuildID")]
        [string]$ID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$ID/storage" -GW2Profile $GW2Profile 
    }
}
    
Function Get-GW2GuildTeam {
    <#
        .SYNOPSIS
        Get the guild/:id/teams from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline, Mandatory)]
        [Alias("GuildID")]
        [string]$ID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$ID/teams" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2GuildTreasury {
    <#
            .SYNOPSIS
            Get the guild/:id/treasury from Guild Wars 2 API
            #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline, Mandatory)]
        [Alias("GuildID")]
        [string]$ID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$ID/treasury" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2GuildUpgrade {
    <#
    .SYNOPSIS
    Get the guild/:id/upgrades from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline, Mandatory)]
        [Alias("GuildID")]
        [string]$ID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$ID/upgrades" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2GuildPermission {
    <#
        .SYNOPSIS
        Get the guild/permissions from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "guild/permissions" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2GuildUpgrade {
    <#
    .SYNOPSIS
    Get the guild/upgrades from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "guild/upgrades" -GW2Profile $GW2Profile 
    }
}
    
Function Get-GW2GuildEmblem {
    <#
    .SYNOPSIS
    Get the emblem/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Emblem"
    }
    Process {
        $APIEndpoint = "emblem"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2GuildSearch {
    <#
    .SYNOPSIS
    Get the guild/search from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [string]$Name
    )
    DynamicParam {
        CommonGW2Parameters
    }
    Process {
        $APIEndpoint = "guild/search"
        Get-GW2APIValue -APIValue $APIEndpoint -APIParams @{ 'name' = $Name } @PSBoundParameters
    }
}
    
