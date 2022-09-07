Function Get-GW2AccountFinisher {
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
    
