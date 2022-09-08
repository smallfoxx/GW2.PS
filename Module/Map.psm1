Function Get-GW2Dungeon {
    <#
    .SYNOPSIS
    Get the account/dungeons from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/dungeons" -SecureAPIKey $SecureAPIKey 
    }
}
    
Function Get-GW2Mapchest {
    <#
    .SYNOPSIS
    Get the account/mapchests from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/mapchests" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Adventure {
    <#
    .SYNOPSIS
    Get the adventures from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [int[]]$id
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        If ($id) {
            Get-GW2APIValue -APIValue "adventures" -SecureAPIKey $SecureAPIKey -APIParams @{ "ids" = $id }
        }
        else {
            Get-GW2APIValue -APIValue "adventures" -SecureAPIKey $SecureAPIKey
        }
    }
}
    
Function Get-GW2AdventureLeaderboard {
    <#
    .SYNOPSIS
    Get the adventures/(id)/leaderboards from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [oarameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string[]]$id
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $id) {
            Get-GW2APIValue -APIValue "adventures/$i/leaderboards" -SecureAPIKey $SecureAPIKey 
        }
    }
}

Function Get-GW2Continent {
    <#
    .SYNOPSIS
    Get the continents/ from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "continents" -SecureAPIKey $SecureAPIKey 
    }
}

    