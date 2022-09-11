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

Function Get-GW2Storie {
    <#
    .SYNOPSIS
    Get the stories/ from Guild Wars 2 API
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
            Get-GW2APIValue -APIValue "stories" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($ID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "stories" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2StorieSeason {
    <#
        .SYNOPSIS
        Get the stories/seasons from Guild Wars 2 API
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
            Get-GW2APIValue -APIValue "stories/seasons" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($ID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "stories/seasons" -GW2Profile $GW2Profile 
        }
    }
}
        