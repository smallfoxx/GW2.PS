<#
.SYNOPSIS
Get inventory of items utilizing GW2.PS Module
.DESCRIPTION
This script is intended to be used with the GW2.PS module found in PSGallery.  To use
the module, install and set it up as needed:
Install-Module GW2.PS
Import-Module GW2.PS

#Repeat the following lines for as many accounts and API keys you have.
Set-GW2APIKey -GW2Profile 'Account1' `
  -APIKey XXXXXXXX-1234-5678-90AB-YYYYYYYYYYYYYYYYYYYY-BA09-8765-4321-ZZZZZZZZZZZZ
.PARAMETER Profiles
The name of the profile(s) to look through and match the -GW2Profile used when setting up GW2.PS with the Set-GW2APIKey command

#>
param(
    [string[]]$Profiles = @('Account1', 'Account2')
)

## this stores the names for all the mats so we don't have to look them up every time the program runs
$mat_id = @{
    24354 = "T3 Fang"
    24355 = "T4 Sharp Fang"
    24356 = "T5 Large Fang"
    24357 = "T6 Vicious Fang"
    24286 = "T3 Scale"
    24287 = "T4 Smooth Scale"
    24288 = "T5 Large Scale"
    24289 = "T6 Armored Scale"
    24348 = "T3 Claw"
    24349 = "T4 Sharp Claw"
    24350 = "T5 Large Claw"
    24351 = "T6 Vicious Claw"
    24344 = "T3 Bone"
    24345 = "T4 Heavy Bone"
    24341 = "T5 Large Bone"
    24358 = "T6 Ancient Bone"
    24292 = "T3 Blood"
    24293 = "T4 Thick Blood"
    24294 = "T5 Potent Blood"
    24295 = "T6 Powerful Blood"
    24280 = "T3 Venom"
    24281 = "T4 Full Venom"
    24282 = "T5 Potent Venom"
    24283 = "T6 Powerful Venom"
    24298 = "T3 Totem"
    24363 = "T4 Engraved Totem"
    24299 = "T5 Intricate Totem"
    24300 = "T6 Elaborate Totem"
    24274 = "T3 Radient Dust"
    24275 = "T4 Luminous Dust"
    24276 = "T5 Dust"
    24277 = "T6 Dust"
}



foreach ($GWProf in $Profiles) {
    Write-Host "Getting account details for $GWProf..."
    $Account = Get-GW2Account -GW2Profile $GWProf


    Write-Host "Getting wallet contents..."
    $Wallet = Get-GW2Wallet -GW2Profile $GWProf
    $Wallet | Add-Member ScriptProperty Coins { 
        $coins = $this | Where-Object { $_.id -eq 1 }
        If ($coins.value -match "^(?<total>((?<gold>\d+)?(?<silver>\d{2}))?(?<copper>\d{2}))$") {
            [PSCustomObject][ordered]@{
                "Total"  = [int]($matches.total)
                "Gold"   = [int]($matches.gold)
                "Silver" = [int]($matches.silver)
                "Copper" = [int]($matches.copper)
            }
        }
    }
    $Wallet | Add-Member ScriptProperty Gems { $this | Where-Object { $_.id -eq 4 } | Select-Object -ExpandProperty 'Value' }

    ## create an empty array to store materials
    $mat_count = @{}


    Write-Host "Checking material storage..."
    $mats = Get-GW2AccountMaterial -GW2Profile $GWProf


    $TieredMats = $mats | Where-Object { $mat_id.ContainsKey([int]$_.id) }
    # ## go through each material and get a count of them
    foreach ($m in $TieredMats) {
        $mat_count.([int]$m.id) += [int]$m.count
    }

    ## count all the mystic coins
    $mcoin = $mats | Where-Object { $_.id -eq 19976 } | Select-Object -ExpandProperty Count

    ## count all the clovers
    $mclover = $mats | Where-Object { $_.id -eq 19675 } | Select-Object -ExpandProperty Count

    Write-Host "Going through bank items..."
    $BankContent = Get-GW2AccountBank -GW2Profile $GWProf
    foreach ($BankTiered in ($BankContent | Where-Object { $mat_id.ContainsKey([int]$_.id) })) {
        $mat_count.([int]$BankTiered.id) += [int]$BankTiered.count
    }
    $mcoin += $BankContent | Where-Object { $_.id -eq 19976 } | Select-Object -ExpandProperty Count
    $mclover += $BankContent | Where-Object { $_.id -eq 19675 } | Select-Object -ExpandProperty Count

    Write-Host "Looking through character bags..."
    $InventoryBags = Get-GW2Character -GW2Profile $GWProf | Get-GW2CharacterInventory -GW2Profile $GWProf

    ## get a list of all characters on the account
    $InventoryItemGroups = $InventoryBags.Bags.Inventory | Group-Object -Property id

    ForEach ($ItemGroup in ($InventoryItemGroups | Where-Object { $mat_id.ContainsKey([int]$_.Name) } )) {
        $mat_count.([int]$ItemGroup.Name) += ($ItemGroup.Group | Measure-Object -Property Count -Sum).Sum
    }

    Write-Host "Calculating results..."
    ## create a table for materials
    $table = @()
    $line1 = "" | Select-Object Name, T3, T4, T5, T6
    $line1.Name = 'Fang'
    $line1.T3 = $mat_count[24354]
    $line1.T4 = $mat_count[24355]
    $line1.T5 = $mat_count[24356]
    $line1.T6 = $mat_count[24357]
    $table += $line1

    $line2 = "" | Select-Object Name, T3, T4, T5, T6
    $line2.Name = 'Scale'
    $line2.T3 = $mat_count[24286]
    $line2.T4 = $mat_count[24287]
    $line2.T5 = $mat_count[24288]
    $line2.T6 = $mat_count[24289]
    $table += $line2

    $line3 = "" | Select-Object Name, T3, T4, T5, T6
    $line3.Name = 'Claw'
    $line3.T3 = $mat_count[24348]
    $line3.T4 = $mat_count[24349]
    $line3.T5 = $mat_count[24350]
    $line3.T6 = $mat_count[24351]
    $table += $line3

    $line4 = "" | Select-Object Name, T3, T4, T5, T6
    $line4.Name = 'Bone'
    $line4.T3 = $mat_count[24344]
    $line4.T4 = $mat_count[24345]
    $line4.T5 = $mat_count[24341]
    $line4.T6 = $mat_count[24358]
    $table += $line4

    $line5 = "" | Select-Object Name, T3, T4, T5, T6
    $line5.Name = 'Blood'
    $line5.T3 = $mat_count[24292]
    $line5.T4 = $mat_count[24293]
    $line5.T5 = $mat_count[24294]
    $line5.T6 = $mat_count[24295]
    $table += $line5

    $line6 = "" | Select-Object Name, T3, T4, T5, T6
    $line6.Name = 'Venom'
    $line6.T3 = $mat_count[24280]
    $line6.T4 = $mat_count[24281]
    $line6.T5 = $mat_count[24282]
    $line6.T6 = $mat_count[24283]
    $table += $line6

    $line7 = "" | Select-Object Name, T3, T4, T5, T6
    $line7.Name = 'Totem'
    $line7.T3 = $mat_count[24298]
    $line7.T4 = $mat_count[24363]
    $line7.T5 = $mat_count[24299]
    $line7.T6 = $mat_count[24300]
    $table += $line7

    $line8 = "" | Select-Object Name, T3, T4, T5, T6
    $line8.Name = 'Dust'
    $line8.T3 = $mat_count[24274]
    $line8.T4 = $mat_count[24275]
    $line8.T5 = $mat_count[24276]
    $line8.T6 = $mat_count[24277]
    $table += $line8

    [PSCustomObject]@{
        pstypename       = 'Guildwars.Account.Data'
        Account          = $Account.name
        Gold             = $Wallet.Coins.Gold
        Silver           = $Wallet.Coins.Silver
        Copper           = $Wallet.Coins.Copper
        Gems             = $Wallet.Gems
        'Mystic Coins'   = $mcoin
        'Mystic Clovers' = $mclover
        Materials        = $table
    }


}