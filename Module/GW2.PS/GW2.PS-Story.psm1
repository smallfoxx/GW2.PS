Function Get-GW2Quest {
    <#
    .SYNOPSIS
    Get the quests/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$QuestID
    )
    Process {
        If ($QuestID) {
            Get-GW2APIValue -APIValue "quests" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($QuestID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "quests" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2Story {
    <#
    .SYNOPSIS
    Get the stories/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType 'Story'
    }
    Process {
        Get-GW2APIValue -APIValue "stories" @PSBoundParameters
    }
}

Function Get-GW2StorySeason {
    <#
        .SYNOPSIS
        Get the stories/seasons from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType 'Season'
    }
    Process {
        Get-GW2APIValue -APIValue "stories/seasons" @PSBoundParameters
    }
}
        