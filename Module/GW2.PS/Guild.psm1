Function Get-GW2Guild {
    <#
    .SYNOPSIS
    Get the guild from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline, Mandatory)]
        [Alias("id")]
        [string]$GuildID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$GuildID" -GW2Profile $GW2Profile 
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
        [Alias("id")]
        [string]$GuildID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$GuildID/log" -GW2Profile $GW2Profile 
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
        [Alias("id")]
        [string]$GuildID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$GuildID/members" -GW2Profile $GW2Profile 
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
        [Alias("id")]
        [string]$GuildID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$GuildID/ranks" -GW2Profile $GW2Profile 
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
        [Alias("id")]
        [string]$GuildID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$GuildID/stash" -GW2Profile $GW2Profile 
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
        [Alias("id")]
        [string]$GuildID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$GuildID/storage" -GW2Profile $GW2Profile 
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
        [Alias("id")]
        [string]$GuildID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$GuildID/teams" -GW2Profile $GW2Profile 
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
        [Alias("id")]
        [string]$GuildID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$GuildID/treasury" -GW2Profile $GW2Profile 
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
        [Alias("id")]
        [string]$GuildID
    )
    Process {
        Get-GW2APIValue -APIValue "guild/$GuildID/upgrades" -GW2Profile $GW2Profile 
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
    
