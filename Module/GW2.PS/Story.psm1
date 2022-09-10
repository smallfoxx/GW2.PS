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
    