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
        [Alias("Name","Id")]
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
    

