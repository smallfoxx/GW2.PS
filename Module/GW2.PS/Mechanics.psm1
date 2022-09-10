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
    
Function Get-GW2Outfit {
    <#
    .SYNOPSIS
    Get the outfits/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$OutfitID
    )
    Process {
        If ($OutfitID) {
            Get-GW2APIValue -APIValue "outfits" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($OutfitID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "outfits" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2Pet {
    <#
        .SYNOPSIS
        Get the novelties from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$PetID
    )
    Process {
        If ($PetID) {
            Get-GW2APIValue -APIValue "pets" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($PetID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "pets" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2Profession {
    <#
    .SYNOPSIS
    Get the professions from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("id", "ids")]
        [string[]]$ProfessionID
    )
    Process {
        If ($ProfessionID) {
            Get-GW2APIValue -APIValue "professions" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($ProfessionID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "professions" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2Race {
    <#
    .SYNOPSIS
    Get the races/ from Guild Wars 2 API
    #>
        [cmdletbinding()]
        param(
            [string]$GW2Profile = (Get-GW2DefaultProfile),
            [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
            [Alias("id", "ids", "race")]
            [string[]]$RaceID
        )
        Process {
            If ($RaceID) {
                Get-GW2APIValue -APIValue "professions" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($RaceID -join ',') }
            }
            else {
                Get-GW2APIValue -APIValue "races" -GW2Profile $GW2Profile 
            }
        }
    }
    