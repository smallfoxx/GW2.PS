Function Get-GW2Account {
    <#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account" -GW2Profile $GW2Profile
    }
}

Function Get-GW2IGN {
    <#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )

    Process {
        (Get-GW2Account -GW2Profile $GW2Profile).name
    }
}

Function Copy-GW2IGNToClipboard {
    <#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )

    Process {
        Get-GW2IGN -GW2Profile $GW2Profile | Set-Clipboard
    }
}

Function Get-GW2Bank {
    <#
.SYNOPSIS
Get the account/bank from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/bank" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Luck {
    <#
    .SYNOPSIS
    Get the account/luck from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/luck" -GW2Profile $GW2Profile 
    }
}
  
Function Get-GW2AccountMailCarrier {
    <#
    .SYNOPSIS
    Get the account/mailcarriers from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/mailcarriers" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2AccountMastery {
    <#
    .SYNOPSIS
    Get the account/masteries from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/masteries" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2MasteryPoint {
    <#
    .SYNOPSIS
    Get the account/mastery/points from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/mastery/points" -GW2Profile $GW2Profile 
    }
}
        
Function Get-GW2Progression {
    <#
.SYNOPSIS
Get the account/progression from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/progression" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Raid {
    <#
.SYNOPSIS
Get the account/raids from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/raids" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Wallet {
    <#
    .SYNOPSIS
    Get the account/wallet from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/wallet" -GW2Profile $GW2Profile 
    }
}
    
Function New-GW2Subtoken {
    <#
        .SYNOPSIS
        Create a subtoken from Guild Wars 2 API to accesss some settings
        #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(Mandatory)]
        [int]$Duration,
        [string[]]$Permissions,
        [string[]]$URLs
    )
    Process {
        $APIParams = @{ 
            "expire" = Get-Date -Date (Get-Date).AddDays($Duration) -Format "o" -AsUTC
        }

        If (-not [string]::IsNullOrEmpty($Permissions)) { $APIParams.permissions = $Permissions -join ',' }
        If (-not [string]::IsNullOrEmpty($URLs)) { $APIParams.urls = $URLs -join ',' }

        Get-GW2APIValue -APIValue "createsubtoken" -GW2Profile $GW2Profile -APIParams $APIParams
    }
}
        
Function Get-GW2Glider {
    <#
    .SYNOPSIS
    Get the gliders from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "gliders" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2MailCarrier {
    <#
        .SYNOPSIS
        Get the mailcarriers from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("ids")]
        [string[]]$ID
    )
    Process {
        If ($ID) {
            Get-GW2APIValue -APIValue "mailcarriers" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($ID -join ',') }
        } else {
            Get-GW2APIValue -APIValue "mailcarriers" -GW2Profile $GW2Profile 
        }
    }
}
        

Set-Alias -Name ign -Value Get-GW2IGN
Set-Alias -Name gw2ign -Value Get-GW2IGN
Set-Alias -Name gw2ign2cb -Value Copy-GW2IGNToClipboard
Set-Alias -Name cign -Value Copy-GW2IGNToClipboard
