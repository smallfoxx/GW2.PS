Function Get-GW2Finisher {
    <#
    .SYNOPSIS
    Get the account/finisher from Guild Wars 2 API
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
            Get-GW2APIValue -APIValue "account/finisher" -SecureAPIKey $SecureAPIKey 
        }
    }

Function Get-GW2PvpHero {
<#
.SYNOPSIS
Get the account/pvp/heroes from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/pvp/heroes" -SecureAPIKey $SecureAPIKey 
    }
}

