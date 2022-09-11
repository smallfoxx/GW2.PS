Function Get-GW2WvwAbility {
    <#
    .SYNOPSIS
    Get the wvw/abilities from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -idtype 'WvWAbility'
    }
    Begin {
        $CommParams = CommonGW2Parameters -idtype 'WvWAbility'
    }
    Process {
        ForEach ($Comm in ($CommParams.Keys)) {
            Set-Variable -Name $Comm -Value $PSBoundParameters.$Comm
            If (-not ((Get-Variable -Name $Comm).Value)) {
                Set-Variable -Name $Comm -Value $CommParams.$Comm.Value
            }
        }
        If ($ID) {
            Get-GW2APIValue -APIValue "wvw/abilities" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($ID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "wvw/abilities" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2WvwObjective {
    <#
    .SYNOPSIS
    Get the wvw/objectives from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Objective"
    }
    Begin {
        $CommParams = CommonGW2Parameters -IDType "Objective"
    }
    Process {
        ForEach ($Comm in ($CommParams.Keys)) {
            Set-Variable -Name $Comm -Value $PSBoundParameters.$Comm
            If (-not ((Get-Variable -Name $Comm).Value)) {
                Set-Variable -Name $Comm -Value $CommParams.$Comm.Value
            }
        }
        $APIEndpoint = "wvw/objectives"
        If ($ID) {
            Get-GW2APIValue -APIValue $APIEndpoint -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($ID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue $APIEndpoint -GW2Profile $GW2Profile
        }
    }
}

Function Get-GW2WvwRank {
    <#
    .SYNOPSIS
    Get the wvw/ranks from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Rank"
    }
    Begin {
        $CommParams = CommonGW2Parameters -IDType "Rank"
    }
    Process {
        ForEach ($Comm in ($CommParams.Keys)) {
            Set-Variable -Name $Comm -Value $PSBoundParameters.$Comm
            If (-not ((Get-Variable -Name $Comm).Value)) {
                Set-Variable -Name $Comm -Value $CommParams.$Comm.Value
            }
        }
        $APIEndpoint = "wvw/ranks"
        If ($ID) {
            Get-GW2APIValue -APIValue $APIEndpoint -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($ID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue $APIEndpoint -GW2Profile $GW2Profile
        }
    }
}
    
Function Get-GW2WvwUpgrade {
    <#
    .SYNOPSIS
    Get the wvw/upgrades from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Upgrade"
    }
    Begin {
        $CommParams = CommonGW2Parameters -IDType "Upgrade"
    }
    Process {
        ForEach ($Comm in ($CommParams.Keys)) {
            Set-Variable -Name $Comm -Value $PSBoundParameters.$Comm
            If (-not ((Get-Variable -Name $Comm).Value)) {
                Set-Variable -Name $Comm -Value $CommParams.$Comm.Value
            }
        }
        $APIEndpoint = "wvw/upgrades"
        If ($ID) {
            Get-GW2APIValue -APIValue $APIEndpoint -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($ID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue $APIEndpoint -GW2Profile $GW2Profile
        }
    }
}
    