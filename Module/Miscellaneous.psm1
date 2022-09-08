Function Get-GW2Currency {
    <#
    .SYNOPSIS
    Get the currencies from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias("Id")]
        [string[]]$CurrencyId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        If ($CurrencyId) {
            Get-GW2APIValue -APIValue "currencies" -SecureAPIKey $SecureAPIKey -APIParams @{ 'ids' = $CurrencyId -join ',' }
        }
        else {
            Get-GW2APIValue -APIValue "currencies" -SecureAPIKey $SecureAPIKey 
        }

    }
}

Function Get-GW2Dungeon {
    <#
    .SYNOPSIS
    Get the dungeons/ from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias("Name","Id")]
        [string[]]$DungeonId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        If ($DungeonId) {
            Get-GW2APIValue -APIValue "dungeons" -SecureAPIKey $SecureAPIKey -APIParams @{ 'ids' = $DungeonId -join ',' }
        }
        else {
            Get-GW2APIValue -APIValue "dungeons" -SecureAPIKey $SecureAPIKey 
        }
    }
}
    

