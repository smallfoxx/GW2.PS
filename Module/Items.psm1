Function Get-GW2Material {
    <#
    .SYNOPSIS
    Get the account/materials from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/materials" -SecureAPIKey $SecureAPIKey 
    }
}
    
Function Get-GW2Mini {
    <#
    .SYNOPSIS
    Get the account/minis from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/minis" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2MountSkin {
    <#
    .SYNOPSIS
    Get the account/mount/skins from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/mount/skins" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2MountType {
    <#
    .SYNOPSIS
    Get the account/mount/types from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/mount/types" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Novelty {
    <#
    .SYNOPSIS
    Get the account/novelties from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/novelties" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Outfit {
    <#
.SYNOPSIS
Get the account/outfits from Guild Wars 2 API
#>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/outfits" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Skin {
    <#
.SYNOPSIS
Get the account/skins from Guild Wars 2 API
#>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/skins" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Color {
    <#
    .SYNOPSIS
    Get the colors/ from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "colors" -SecureAPIKey $SecureAPIKey 
    }
}
    
    
        
        
        