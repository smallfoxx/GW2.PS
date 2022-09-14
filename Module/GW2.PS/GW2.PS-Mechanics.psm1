Function Get-GW2Mastery {
    <#
    .SYNOPSIS
    Get the masteries from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Mastery"
    }
    Process {
        $APIEndpoint = "masteries"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
Function Get-GW2MountSkin {
    <#
    .SYNOPSIS
    Get the mounts/skins from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Skin"
    }
    Process {
        $APIEndpoint = "mounts/skins"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2MountType {
    <#
    .SYNOPSIS
    Get the mounts/types from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Type"
    }
    Process {
        $APIEndpoint = "mounts/types"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
Function Get-GW2Outfit {
    <#
    .SYNOPSIS
    Get the outfits/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Outfit"
    }
    Process {
        $APIEndpoint = "outfits"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Pet {
    <#
        .SYNOPSIS
        Get the novelties from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Pet"
    }
    Process {
        $APIEndpoint = "pets"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Profession {
    <#
    .SYNOPSIS
    Get the professions from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Profession"
    }
    Process {
        $APIEndpoint = "professions"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Race {
    <#
    .SYNOPSIS
    Get the races/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Race"
    }
    Process {
        $APIEndpoint = "races"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Skill {
    <#
        .SYNOPSIS
        Get the skills/ from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType 'Skill'
    }
    Process {
        $APIEndpoint = "skills"
        write-debug "Calling $APIEndpint with ID $($id -join ',')..."
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Specialization {
    <#
    .SYNOPSIS
    Get the specializations/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType 'Specialization'
    }
    Process {
        $APIEndpoint = "specializations"
        write-debug "Calling $APIEndpint with ID $($id -join ',')..."
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2Trait {
    <#
    .SYNOPSIS
    Get the traits/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType 'Trait'
    }
    Begin {
        $CommParams = CommonGW2Parameters -IDType 'Trait'
    }
    Process {
        ForEach ($Comm in ($CommParams.Keys)) {
            Set-Variable -Name $Comm -Value $PSBoundParameters.$Comm
            If (-not ((Get-Variable -Name $Comm).Value)) {
                Set-Variable -Name $Comm -Value $CommParams.$Comm.Value
            }
        }
        If ($ID) {
            Get-GW2APIValue -APIValue "traits" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($ID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "traits" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2Legend {
    <#
    .SYNOPSIS
    Get the legends/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Legend"
    }
    Process {
        $APIEndpoint = "legends"
        write-debug "Calling $APIEndpint with ID $($id -join ',')..."
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}


<#
Function Get-GW2Mount {
    <#
    .SYNOPSIS
    Get the mounts/ from Guild Wars 2 API
    >
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Mount"
    }
    Process {
        $APIEndpoint = "mounts"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
#>
    