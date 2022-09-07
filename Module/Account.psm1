Function Get-GW2Account {
<#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
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
        Get-GW2APIValue -APIValue "account" -SecureAPIKey $SecureAPIKey
    }
}

Function Get-GW2IGN {
<#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
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
        (Get-GW2Account -SecureAPIKey $SecureAPIKey).name
    }
}

Function Copy-GW2IGNToClipboard {
<#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
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
        Get-GW2IGN -SecureAPIKey $SecureAPIKey | Set-Clipboard
    }
}

Function Get-GW2Bank {
<#
.SYNOPSIS
Get the account/bank from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/bank" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Luck {
    <#
    .SYNOPSIS
    Get the account/luck from Guild Wars 2 API
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
            Get-GW2APIValue -APIValue "account/luck" -SecureAPIKey $SecureAPIKey 
        }
    }
  
Function Get-GW2MailCarrier {
    <#
    .SYNOPSIS
    Get the account/mailcarrier from Guild Wars 2 API
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
            Get-GW2APIValue -APIValue "account/mailcarrier" -SecureAPIKey $SecureAPIKey 
        }
    }

Function Get-GW2Mastery {
    <#
    .SYNOPSIS
    Get the account/masteries from Guild Wars 2 API
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
            Get-GW2APIValue -APIValue "account/masteries" -SecureAPIKey $SecureAPIKey 
        }
    }

Function Get-GW2MasteryPoint {
    <#
    .SYNOPSIS
    Get the account/mastery/point from Guild Wars 2 API
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
            Get-GW2APIValue -APIValue "account/mastery/point" -SecureAPIKey $SecureAPIKey 
        }
    }
        


Set-Alias -Name ign -Value Get-GW2IGN
Set-Alias -Name gw2ign -Value Get-GW2IGN
Set-Alias -Name gw2ign2cb -Value Copy-GW2IGNToClipboard
Set-Alias -Name cign -Value Copy-GW2IGNToClipboard
