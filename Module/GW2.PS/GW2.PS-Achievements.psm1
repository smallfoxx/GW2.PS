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
    <#
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
        [switch]$All,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )

    Begin {
        $IDs = @()
        <#If ($All) {
            $Base = "achievements"
        } else {
            $Base = "account/achievements"
        }
    }

    Process {
        If ($Daily -or $Tomorrow) {
            return (Get-GW2AchievementDaily -Tomorrow:$Tomorrow -GW2Profile $GW2Profile )

        }
        elseif ($Groups) {
            return (Get-GW2AchievementGroup -GW2Profile $GW2Profile )

        }
        elseif ($Categories) {
            return (Get-GW2AchievementCategory -ID $AchivementID -GW2Profile $GW2Profile )

        }
        else {
            $IDs += $AchivementID | ForEach-Object { $_ }
        }
    }

    End {
        If ($IDs) {
            Write-Debug "Getting achivements for ids $(($IDs -join ","))"
            $APIValue = "achievements"
            Get-GW2APIValue -APIValue $APIValue -APIParams @{ "ids" = ($IDs -join ",") } -GW2Profile $GW2Profile
        }
        elseif (-not ($Daily -or $Tomorrow) -and -not ($Categories)) {
            If ($All) {
                (Get-GW2APIValue -APIValue "achievements") -split "`n" | ForEach-Object { [int]$_ } | Get-GW2Achievement -GW2Profile $GW2Profile
            }
            else {
                If ($Lookup) {
                    $achievements = Get-GW2APIValue -APIValue "account/achievements" -APIParams @{ "done" = [bool]$Completed } -GW2Profile $GW2Profile # | Where-Object { $_.done -eq $Completed}
                    $allDetails = $achievements | Get-GW2Achievement -GW2Profile $GW2Profile
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
                    ForEach ($achievement in (Get-GW2APIValue -APIValue "account/achievements" -APIParams @{ "done" = [bool]$Completed } -GW2Profile $GW2Profile )) {
                        $details = Get-GW2Achievement -AchivementID $achievement.id  -GW2Profile $GW2Profile
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
    #>
    [cmdletbinding()]
    param(
        [switch]$Daily,
        [switch]$Tomorrow,
        [switch]$Groups,
        [switch]$Categories,
        [switch]$Completed,
        [switch]$Lookup,
        [switch]$All
    )
    DynamicParam {
        CommonGW2Parameters -IDType "Achievement"
    }
    Process {
        $APIEndpoint = "achievements"
        If ($Daily -or $Tomorrow) {
            return (Get-GW2AchievementDaily @PSBoundParameters )

        }
        elseif ($Groups) {
            return (Get-GW2AchievementGroup @PSBoundParameters )

        }
        elseif ($Categories) {
            return (Get-GW2AchievementCategory @PSBoundParameters )

        }
        else {
            Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
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
        [parameter(ValueFromRemainingArguments)]
        $ExtraArgs
    )
    DynamicParam {
        CommonGW2Parameters -IDType "Achievement"
    }

    Process {
        If ($Tomorrow) {
            $Dailies = Get-GW2APIValue -APIValue "achievements/daily/tomorrow" @PSBoundParameters
        }
        else {
            $Dailies = Get-GW2APIValue -APIValue "achievements/daily" @PSBoundParameters
        }
        switch ($Section) {
            "All" {
                return $Dailies
            }
            Default { 
                $Dailies.$Section
            }
        }
    }
}

Function Get-GW2AchievementCategory {
    <#
.SYNOPSIS
Get categories of achievements
#>
    [cmdletbinding()]
    param(
        [parameter(ValueFromRemainingArguments)]
        $ExtraArgs
    )
    DynamicParam {
        CommonGW2Parameters -IDType "Category"
    }
    Process {
        $APIEndpoint = "achievements/categories"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AchievementGroup {
    <#
.SYNOPSIS
Get groups of achievements
#>
    [cmdletbinding()]
    param(
        [parameter(ValueFromRemainingArguments)]
        $ExtraArgs
    )
    DynamicParam {
        CommonGW2Parameters -IDType "Category"
    }
    Process {
        $APIEndpoint = "achievements/groups"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

    