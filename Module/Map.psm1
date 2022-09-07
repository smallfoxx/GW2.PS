Function Get-GW2Dungeon {
    <#
    .SYNOPSIS
    Get the account/dungeon from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName="SecureAPIKey")]
        param(
            [parameter(ParameterSetName="SecureAPIKey")]
            [SecureString]$SecureAPIKey=(Get-GW2APIKey),
            [parameter(ParameterSetName="ClearAPIKey",Mandatory)]
            [string]$APIKey
        )
        Process {
            If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
            Get-GW2APIValue -APIValue "account/dungeon" -SecureAPIKey $SecureAPIKey 
        }
    }
    
Function Get-GW2Mapchest {
    <#
    .SYNOPSIS
    Get the account/mapchest from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName="SecureAPIKey")]
        param(
            [parameter(ParameterSetName="SecureAPIKey")]
            [SecureString]$SecureAPIKey=(Get-GW2APIKey),
            [parameter(ParameterSetName="ClearAPIKey",Mandatory)]
            [string]$APIKey
        )
        Process {
            If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
            Get-GW2APIValue -APIValue "account/mapchest" -SecureAPIKey $SecureAPIKey 
        }
    }
        