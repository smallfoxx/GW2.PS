Function Get-GW2Achievement {
    <#
.SYNOPSIS
Get achievement or list of achievements from GW2 API
.PARAMETER Daily
List achievements in the Daily category for today
.PARAMETER Tomorrow
List achievements in the Daily category for tomorrow
.PARAMETER Groups
List achievement groups
.PARAMETER Categories
List achiveemtnt categories
#>
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [alias("id")]
        [int[]]$AchivementID,
        [switch]$Daily,
        [switch]$Tomorrow,
        [switch]$Groups,
        [switch]$Categories,
        [switch]$Completed,
        [switch]$Lookup,
        [switch]$All
    )

    Begin {
        $IDs = @()
        <#If ($All) {
            $Base = "achievements"
        } else {
            $Base = "account/achievements"
        }#>
    }

    Process {
        If ($Daily -or $Tomorrow) {
            return (Get-GW2AchievementDaily -Tomorrow:$Tomorrow )

        }
        elseif ($Groups) {
            return (Get-GW2AchievementGroup )

        }
        elseif ($Categories) {
            return (Get-GW2AchievementCategory -ID $AchivementID )

        }
        else {
            $IDs += $AchivementID | ForEach-Object { $_ }
        }
    }

    End {
        If ($IDs) {
            Write-Debug "Getting achivements for ids $(($IDs -join ","))"
            $APIValue = "achievements"
            Get-GW2APIValue -APIValue $APIValue -APIParams @{ "ids" = ($IDs -join ",") }
        }
        elseif (-not ($Daily -or $Tomorrow) -and -not ($Categories)) {
            If ($All) {
                (Get-GW2APIValue -APIValue "achievements") -split "`n" | ForEach-Object { [int]$_ } | Get-GW2Achievement
            }
            else {
                If ($Lookup) {
                    $achievements = Get-GW2APIValue -APIValue "account/achievements" -APIParams @{ "done" = [bool]$Completed } # | Where-Object { $_.done -eq $Completed}
                    $allDetails = $achievements | Get-GW2Achievement
                    ForEach ($achievement in $achievements) {
                        $details = $allDetails | Where-Object { $_.id -eq $achievement.id } 
                        If ($details) {
                            ForEach ($prop in ($details | Get-Member -MemberType NoteProperty | Where-Object { $_.Name -ne 'id' } ) ) {
                                $achievement | Add-Member NoteProperty $prop.Name $details.($prop.Name) -ErrorAction SilentlyContinue
                            }
                        }
                        $achievement
                    }  
                }
                else {
                    ForEach ($achievement in (Get-GW2APIValue -APIValue "account/achievements" -APIParams @{ "done" = [bool]$Completed } )) {
                        $details = Get-GW2Achievement -AchivementID $achievement.id 
                        If ($details) {
                            ForEach ($prop in ($details | Get-Member -MemberType NoteProperty | Where-Object { $_.Name -ne 'id' } ) ) {
                                $achievement | Add-Member NoteProperty $prop.Name $details.($prop.Name) -ErrorAction SilentlyContinue
                            }
                        }
                        $achievement
                    }  
                }
            }
        }
    }
}

Function Get-GW2AchievementDaily {
    <#
.SYNOPSIS
Get daily achievements
#>
    [cmdletbinding()]
    param(
        [ValidateSet("pvp", "pve", "wvw", "fractals", "special", "All")]
        [string]$Section = "All",
        [switch]$Tomorrow,
        [switch]$IDOnly
    )

    Process {
        If ($Tomorrow) {
            $Dailies = Get-GW2APIValue -APIValue "achievements/daily/tomorrow"
        }
        else {
            $Dailies = Get-GW2APIValue -APIValue "achievements/daily"
        }
        switch ($Section) {
            "All" {
                If ($IDOnly) {
                    return $Dailies
                }
                else {
                    Write-Debug "Getting details for ALL daily achivements"
                    $Results = @{}
                    ForEach ($Sec in ($Dailies | Get-Member -MemberType NoteProperty).Name) {
                        If ($Dailies.$Sec) {
                            write-Debug "`tSection: $Sec"
                            $Results.$Sec = $Dailies.$Sec | Get-GW2Achievement
                        }
                    }
                    return $Results
                }
            }
            Default { 
                If ($IDOnly) {
                    $Dailies.$Section
                }
                else {
                    $Dailies.$Section | Get-GW2Achievement
                }
            }
        }
    }
}

Function Get-GW2AchievementCategory {
    <#
.SYNOPSIS
Get categories of achievements
#>
    [cmdletbinding(DefaultParameterSetName = "IDList")]
    param(
        [ValidateSet("pvp", "pve", "wvw", "fractals", "special", "All")]
        [string]$Section = "All",
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline, ParameterSetName = "IDList")]
        [int[]]$ID,
        [parameter(ParameterSetName = "ReturnIDs")]
        [switch]$IDOnly
    )

    Begin {
        switch ($PSCmdlet.ParameterSetName) {
            "IDList" { $IDList = [System.Collections.ArrayList]@() }
        }
    }
    Process {
        If ($ID.Length -gt 0) {
            $null = $IDList.Add(($ID -join ","))
        }
    }

    End {
        If ($IDList.Count -gt 0) {
            $Categories = Get-GW2APIValue -APIValue "achievements/categories" -APIParams @{ "ids" = ($IDList -join ",") } 
            return $Categories
        }
        else {
            $Categories = Get-GW2APIValue -APIValue "achievements/categories" 

            If ($IDOnly) {
                return $Categories
            }
            else {
                $Categories | Get-GW2AchievementCategory
            }
        }
    }
}

Function Get-GW2AchievementGroup {
    <#
.SYNOPSIS
Get categories of achievements
#>
    [cmdletbinding(DefaultParameterSetName = "IDList")]
    param(
        [ValidateSet("pvp", "pve", "wvw", "fractals", "special", "All")]
        [string]$Section = "All",
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline, ParameterSetName = "IDList")]
        [string[]]$ID,
        [parameter(ParameterSetName = "ReturnIDs")]
        [switch]$IDOnly
    )

    Begin {
        switch ($PSCmdlet.ParameterSetName) {
            "IDList" { $IDList = [System.Collections.ArrayList]@() }
        }
    }
    Process {
        If ($ID.Length -gt 0) {
            $null = $IDList.Add(($ID -join ","))
        }
    }

    End {
        If ($IDList.Count -gt 0) {
            $Groups = Get-GW2APIValue -APIValue "achievements/groups" -APIParams @{ "ids" = ($IDList -join ",") } 
            return $Groups
        }
        else {
            $Groups = Get-GW2APIValue -APIValue "achievements/groups" 

            If ($IDOnly) {
                return $Groups
            }
            else {
                $Groups | Get-GW2AchievementGroup
            }
        }
    }
}

    