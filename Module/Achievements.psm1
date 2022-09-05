Function Get-GW2Achievement {
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipeline)]
        [int[]]$AchivementID,
        [switch]$Daily,
        [switch]$Tomorrow,
        [switch]$Groups,
        [switch]$Categories
    )

    Begin {
        $IDs=@()
        $Base = "achievements"
        If ($Daily -or $Tomorrow) {
            $Base += "/daily"
            If ($Tomorrow) { $Base += "/tomorrow" }
        } elseif ($Groups) {
            $Base += "/groups"
        } elseif ($Categories) {
            $Base += "/categories"
        }
    }

    Process {
        $IDs+=$AchivementID | %{ $_ }
    }

    End {
        If ($IDs) {
            $APIValue = "$Base"
            #$APIValue += '?id='
            #$APIValue += ($IDs -join ",")
            Get-GW2APIValue -APIValue $APIValue -APIParams @{ "ids" = ($IDs -join ",") }
        } else {
            (Get-GW2APIValue -APIValue "$Base") -split "`n" | %{ [int]$_ } | Get-Achievement #-AchivementID ([int]($_)) }
        }
    }
}

