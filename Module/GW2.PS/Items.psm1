Function Get-GW2Material {
    <#
    .SYNOPSIS
    Get the account/materials from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/materials" -GW2Profile $GW2Profile 
    }
}
    
Function Get-GW2Mini {
    <#
    .SYNOPSIS
    Get the account/minis from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/minis" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2MountSkin {
    <#
    .SYNOPSIS
    Get the account/mount/skins from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/mount/skins" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2MountType {
    <#
    .SYNOPSIS
    Get the account/mount/types from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/mount/types" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Novelty {
    <#
    .SYNOPSIS
    Get the account/novelties from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/novelties" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Outfit {
    <#
.SYNOPSIS
Get the account/outfits from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/outfits" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Skin {
    <#
.SYNOPSIS
Get the account/skins from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/skins" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Color {
    <#
    .SYNOPSIS
    Get the colors/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "colors" -GW2Profile $GW2Profile 
    }
}
    
    
        
        
        