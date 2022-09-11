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
    