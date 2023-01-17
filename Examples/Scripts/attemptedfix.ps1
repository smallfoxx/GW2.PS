#$ErrorActionPreference = 'SilentlyContinue'
$Profiles = @('Account1','Account2')

foreach ($account in $Profiles) {
    ## create an empty array to store data in
$item_database = @()
## create a variable to store the total gold
$total_gold = 0
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


## this is the actual wallet API request, stored in a variable called $coin. changing the Uri line will give you different information. you can look up endpoints at https://wiki.guildwars2.com/wiki/API:Main
$params_coin = @{
    "Uri"     = "https://api.guildwars2.com/v2/account/wallet"
    "Method"  = 'GET'
    "Headers" = @{
    "Content-Type"  = 'application/json'
    "Authorization" = "Bearer $($account.Token)"
    }
   }

$Wallet = Get-GW2Wallet -GW2Profile $Sccount
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
$Coins = $Wallet
#$coin = Invoke-RestMethod @params_coin

## gets the gold from the wallet request above and does some maths to split it into gold/silver/copper
$cash = $coin | Where-Object {$_.id -eq 1}
$gold = [int][math]::floor($cash.value / 10000)
$silver = $cash.value % 10000
$copper = $silver % 100
$silver = [int][math]::floor($silver / 100)
$total_gold = $cash.value

## getting the gem count
$gems = $coin | Where-Object {$_.id -eq 4} | Select-Object value

## create an empty array to store materials
$mat_count = @{}

## API request for material storage
$params_mats = @{
    "Uri"     = "https://api.guildwars2.com/v2/account/materials"
    "Method"  = 'GET'
    "Headers" = @{
    "Content-Type"  = 'application/json'
    "Authorization" = "Bearer $($account.Token)"
    }
   }
$mats = Invoke-RestMethod @params_mats

# ## go through each material and get a count of them
 foreach ($m in $mats) {
    $count = $m | Select-Object count
    if ($mat_id.ContainsKey($m.id)) {
        $mat_count.Add($m.id,$count.count)
    }
 }

## count all the mystic coins
$mcoin = $mats | Where-Object {$_.id -eq 19976}
$mcoin = $mcoin | Select-Object count

## count all the clovers
$mclover = $mats | Where-Object {$_.id -eq 19675}
$mclover = $mclover | Select-Object count

$params_char = @{
    "Uri"     = "https://api.guildwars2.com/v2/characters"
    "Method"  = 'GET'
    "Headers" = @{
    "Content-Type"  = 'application/json'
    "Authorization" = "Bearer $($account.Token)"
    }
   }
$characters = Invoke-RestMethod @params_char

## get a list of all characters on the account
foreach ($c in $characters) {

   $params_char_inv = @{
        "Uri"     = "https://api.guildwars2.com/v2/characters/$($c)/inventory"
        "Method"  = 'GET'
        "Headers" = @{
        "Content-Type"  = 'application/json'
        "Authorization" = "Bearer $($account.Token)"
        }
       }
   $character_inv = Invoke-RestMethod @params_char_inv

    ## get all the bags of each character and count any materials in the bags
    foreach ($inventoryItem in $character_inv.bags.inventory) {
        $count = $inventoryItem | Select-Object count
        if ($mat_id.ContainsKey($inventoryItem.id) ) {
            $mat_count[$inventoryItem.id] = $mat_count[$inventoryItem.id] + $count.count
       }
    }
}

## create a list of materials and counts
$mat_count.GetEnumerator() | ForEach-Object {
   $list = "" | Select-Object Name,Amount
   $list.name = $mat_id[$_.name]
   $list.amount = $_.value
   $item_database += $list

   }

## create a table for materials
$table = @()
$line1 = "" | Select-Object Name,T3,T4,T5,T6
$line1.Name = 'Fang'
$line1.T3 = $mat_count[24354]
$line1.T4 = $mat_count[24355]
$line1.T5 = $mat_count[24356]
$line1.T6 = $mat_count[24357]
$table += $line1

$line2 = "" | Select-Object Name,T3,T4,T5,T6
$line2.Name = 'Scale'
$line2.T3 = $mat_count[24286]
$line2.T4 = $mat_count[24287]
$line2.T5 = $mat_count[24288]
$line2.T6 = $mat_count[24289]
$table += $line2

$line3 = "" | Select-Object Name,T3,T4,T5,T6
$line3.Name = 'Claw'
$line3.T3 = $mat_count[24348]
$line3.T4 = $mat_count[24349]
$line3.T5 = $mat_count[24350]
$line3.T6 = $mat_count[24351]
$table += $line3

$line4 = "" | Select-Object Name,T3,T4,T5,T6
$line4.Name = 'Bone'
$line4.T3 = $mat_count[24344]
$line4.T4 = $mat_count[24345]
$line4.T5 = $mat_count[24341]
$line4.T6 = $mat_count[24358]
$table += $line4

$line5 = "" | Select-Object Name,T3,T4,T5,T6
$line5.Name = 'Blood'
$line5.T3 = $mat_count[24292]
$line5.T4 = $mat_count[24293]
$line5.T5 = $mat_count[24294]
$line5.T6 = $mat_count[24295]
$table += $line5

$line6 = "" | Select-Object Name,T3,T4,T5,T6
$line6.Name = 'Venom'
$line6.T3 = $mat_count[24280]
$line6.T4 = $mat_count[24281]
$line6.T5 = $mat_count[24282]
$line6.T6 = $mat_count[24283]
$table += $line6

$line7 = "" | Select-Object Name,T3,T4,T5,T6
$line7.Name = 'Totem'
$line7.T3 = $mat_count[24298]
$line7.T4 = $mat_count[24363]
$line7.T5 = $mat_count[24299]
$line7.T6 = $mat_count[24300]
$table += $line7

$line8 = "" | Select-Object Name,T3,T4,T5,T6
$line8.Name = 'Dust'
$line8.T3 = $mat_count[24274]
$line8.T4 = $mat_count[24275]
$line8.T5 = $mat_count[24276]
$line8.T6 = $mat_count[24277]
$table += $line8

$gold = [int][math]::floor($total_gold / 10000)
$silver = $total_gold % 10000
$copper = $silver % 100
$silver = [int][math]::floor($silver / 100)

[PSCustomObject]@{
    pstypename = 'Guildwars.Account.Data'
    Account = $account.AccountName
    Gold = $gold
    Silver = $silver
    Copper = $copper
    Gems = $($gems.value)
    'Mystic Coins' = $($mcoin.count)
    'Mystic Clovers' = $($mclover.count)
    Materials = $table
}


}