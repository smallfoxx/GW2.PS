# First, we get all the skins unlocked on your account
param(
    [string]$CSVFilePath=((New-TemporaryFile).FullName),
    [switch]$Append
)

If (Test-Path $CSVFilePath -ErrorAction SilentlyContinue) {
    $CSVFile = Get-Item $CSVFilePath
    If ($CSVFile.Extension -ne ".csv") {
        $newFilePath = $CSVFile.FullName -replace "$([RegEx]::Escape($CSVFile.Extension))$",".csv"
        Rename-item $CSVFile.FullName $newFilePath
        $CSVFilePath = $newFilePath
    }
}

Write-Host "Getting unlocked skin IDs..."
$unlockedSkins = Get-GW2AccountSkin


Write-Host "Geting locked skin IDs..."
$allSkins = Get-GW2Skin
$lockedSkins = $allSkns | Where-Object { $_ -notin $unlockedSkins }

Write-Host "Getting items with locked skins..."
$allItems = Get-GW2Item
$itemsWithLockedSkins = $allItems | Get-GW2Item | Where-Object { $_.default_skin -in $lockedSkins }

Write-Host "Getting details about items..."
ForEach ($item in $itemsWithLockedSkins) {
    $item | Add-Member NoteProperty Skin (Get-GW2Skin -id $item.default_skin)
    $item | Add-Member ScriptProperty WikiURL { "https://wiki.guildwars2.com/wiki/?search={0}&ns0=1" -f ($this.chat_link) }
    $item | Add-Member ScriptProperty Slot { $this.details.type }
    $item | Add-Member ScriptProperty Weight_Class { $this.details.weight_class }
    $item | Add-Member ScriptProperty Defense { $this.details.Defense }
    $item | Add-Member ScriptProperty Power { $this.details.max_power }
    $item | Add-Member ScriptProperty SkinName { $this.Skin.name }
    $item | Add-Member ScriptProperty SkinType { $this.Skin.type }
    $item | Add-Member ScriptProperty SkinIcon { $this.Skin.icon }
    If ($item.flags -notcontains "AccountBound") {
        $item | Add-Member NoteProperty Listings (Get-GW2CommerceListing -id $item.id)
        $item | Add-Member ScriptProperty Buys { $this.Listings.Buys }
        $item | Add-Member ScriptProperty Sells { $this.Listings.Sells }
        $item | Add-Member ScriptProperty MaxBuy { ($this.Buys | Sort-Object unit_price | Select-Object -last 1).unit_price/1000 }
        $item | Add-Member ScriptProperty MinSell { ($this.Sells | Sort-Object unit_price | Select-Object -first 1).unit_price/1000 }
    }
}

$OutputFields = @(
	"id",
	"name",
	"type",
	"Slot",
	"MaxBuy",
	"MinSell",
	"Weight_Class",
	"Defense",
	"Power",
	"level",
	"rarity",
	"description",
	"chat_link",
	"WikiURL",
	"icon",
	"SkinIcon",
	"SkinName",
	"SkinType"
)

Write-Host "Saving to CSV file..."
$itemsWithLockedSkins | Select-Object -Property @OutputFields | Export-CSV -NoTypeInformation -Path $CSVFilePath -Append:$Append

Write-Host "Attempting to open CSV file with default app..."
Start $CSVFilePath