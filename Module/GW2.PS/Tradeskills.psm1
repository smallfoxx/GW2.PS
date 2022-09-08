Function Get-GW2Dailycrafting {
    <#
    .SYNOPSIS
    Get the account/dailycrafting from Guild Wars 2 API
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
            Get-GW2APIValue -APIValue "account/dailycrafting" -SecureAPIKey $SecureAPIKey 
        }
    }
    
Function Get-GW2Recipe {
<#
.SYNOPSIS
Get the account/recipes from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/recipes" -SecureAPIKey $SecureAPIKey 
    }
}
