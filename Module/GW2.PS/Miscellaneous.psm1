Function Get-GW2Currency {
    <#
    .SYNOPSIS
    Get the currencies from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias("Id")]
        [string[]]$CurrencyId
    )
    Process {
        If ($CurrencyId) {
            Get-GW2APIValue -APIValue "currencies" -GW2Profile $GW2Profile -APIParams @{ 'ids' = $CurrencyId -join ',' }
        }
        else {
            Get-GW2APIValue -APIValue "currencies" -GW2Profile $GW2Profile 
        }

    }
}

Function Get-GW2Dungeon {
    <#
    .SYNOPSIS
    Get the dungeons/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias("Name", "Id")]
        [string[]]$DungeonId
    )
    Process {
        If ($DungeonId) {
            Get-GW2APIValue -APIValue "dungeons" -GW2Profile $GW2Profile -APIParams @{ 'ids' = $DungeonId -join ',' }
        }
        else {
            Get-GW2APIValue -APIValue "dungeons" -GW2Profile $GW2Profile 
        }
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
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$MiniID
    )
    Process {
        If ($MiniID) {
            Get-GW2APIValue -APIValue "minis" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($MiniID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "minis" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2Novelty {
    <#
    .SYNOPSIS
    Get the novelties from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$NoveltyID
    )
    Process {
        If ($NoveltyID) {
            Get-GW2APIValue -APIValue "novelties" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($NoveltyID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "novelties" -GW2Profile $GW2Profile 
        }
    }
}
    
Function Get-GW2Raid {
    <#
    .SYNOPSIS
    Get the raids/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$RaidID
    )
    Process {
        If ($RaidID) {
            Get-GW2APIValue -APIValue "raids" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($RaidID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "raids" -GW2Profile $GW2Profile 
        }
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
        CommonGW2Parameters
    }
    Begin {
        $CommParams = CommonGW2Parameters
    }
    Process {
        ForEach ($Comm in ($CommParams.Keys)) {
            Set-Variable -Name $Comm -Value $PSBoundParameters.$Comm
            If (-not ((Get-Variable -Name $Comm).Value)) {
                Set-Variable -Name $Comm -Value $CommParams.$Comm.Value
            }
        }
        If ($ID) {
            Get-GW2APIValue -APIValue "titles" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($ID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "titles" -GW2Profile $GW2Profile 
        }
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
            CommonGW2Parameters -IDType 'World'
        }
        Begin {
            $CommParams = CommonGW2Parameters -IDType 'World'
        }
        Process {
            ForEach ($Comm in ($CommParams.Keys)) {
                Set-Variable -Name $Comm -Value $PSBoundParameters.$Comm
                If (-not ((Get-Variable -Name $Comm).Value)) {
                    Set-Variable -Name $Comm -Value $CommParams.$Comm.Value
                }
            }
            If ($ID) {
                Get-GW2APIValue -APIValue "worlds" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($ID -join ',') }
            }
            else {
                Get-GW2APIValue -APIValue "worlds" -GW2Profile $GW2Profile 
            }
        }
    }
    