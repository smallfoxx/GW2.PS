Function Get-GW2Mastery {
    <#
    .SYNOPSIS
    Get the masteries from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$MasteryID
    )
    Begin {
        $Masteries = @()
    }
    Process {
        If ($MasteryID) {
            $Masteries += $MasteryID
        }
    }
    End {
        If ($Masteries.Length -gt 0) {
            Write-Debug "Looking up masteries: $($Masteries -join ',')"
            Get-GW2APIValue -APIValue "masteries" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($Masteries -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "masteries" -GW2Profile $GW2Profile 
        }
    }
}
    
Function Get-GW2MountSkin {
    <#
    .SYNOPSIS
    Get the mounts/skins from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$SkinID
    )
    Process {
        If ($SkinID) {
            Get-GW2APIValue -APIValue "mounts/skins" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($SkinID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "mounts/skins" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2MountType {
    <#
    .SYNOPSIS
    Get the mounts/types from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$TypeID
    )
    Process {
        If ($TypeID) {
            Get-GW2APIValue -APIValue "mounts/types" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($TypeID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "mounts/types" -GW2Profile $GW2Profile 
        }
    }
}
    
    