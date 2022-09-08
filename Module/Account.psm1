Function Get-GW2Account {
    <#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
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
        Get-GW2APIValue -APIValue "account" -SecureAPIKey $SecureAPIKey
    }
}

Function Get-GW2IGN {
    <#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
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
        (Get-GW2Account -SecureAPIKey $SecureAPIKey).name
    }
}

Function Copy-GW2IGNToClipboard {
    <#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
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
        Get-GW2IGN -SecureAPIKey $SecureAPIKey | Set-Clipboard
    }
}

Function Get-GW2Bank {
    <#
.SYNOPSIS
Get the account/bank from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/bank" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Luck {
    <#
    .SYNOPSIS
    Get the account/luck from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/luck" -SecureAPIKey $SecureAPIKey 
    }
}
  
Function Get-GW2MailCarrier {
    <#
    .SYNOPSIS
    Get the account/mailcarriers from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/mailcarriers" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Mastery {
    <#
    .SYNOPSIS
    Get the account/masteries from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/masteries" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2MasteryPoint {
    <#
    .SYNOPSIS
    Get the account/mastery/points from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/mastery/points" -SecureAPIKey $SecureAPIKey 
    }
}
        
Function Get-GW2Progression {
    <#
.SYNOPSIS
Get the account/progression from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/progression" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Raid {
    <#
.SYNOPSIS
Get the account/raids from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/raids" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Wallet {
    <#
    .SYNOPSIS
    Get the account/wallet from Guild Wars 2 API
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
        Get-GW2APIValue -APIValue "account/wallet" -SecureAPIKey $SecureAPIKey 
    }
}
    
Function New-GW2Subtoken {
    <#
        .SYNOPSIS
        Create a subtoken from Guild Wars 2 API to accesss some settings
        #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(Mandatory)]
        [int]$Duration,
        [string[]]$Permissions,
        [string[]]$URLs
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        $APIParams = @{ 
            "expire" = Get-Date -Date (Get-Date).AddDays($Duration) -Format "o" -AsUTC
        }

        If (-not [string]::IsNullOrEmpty($Permissions)) { $APIParams.permissions = $Permissions -join ',' }
        If (-not [string]::IsNullOrEmpty($URLs)) { $APIParams.urls = $URLs -join ',' }

        Get-GW2APIValue -APIValue "createsubtoken" -SecureAPIKey $SecureAPIKey -APIParams $APIParams
    }
}
        

Set-Alias -Name ign -Value Get-GW2IGN
Set-Alias -Name gw2ign -Value Get-GW2IGN
Set-Alias -Name gw2ign2cb -Value Copy-GW2IGNToClipboard
Set-Alias -Name cign -Value Copy-GW2IGNToClipboard
