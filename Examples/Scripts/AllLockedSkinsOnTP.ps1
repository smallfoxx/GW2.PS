[cmdletbinding(DefaultParameterSetName="Armor")]
param(
    [string]$CSVFilePath=((New-TemporaryFile).FullName),
    [switch]$Append,
    [ValidateSet('Basic','Fine','Masterwork','Rare','Exotic','Ascended','Legendary')]
    [string]$Rarity,
    [ValidateSet('Armor','Weapon','Back')]
    [string]$ItemType,
    [parameter(ParameterSetName="Armor")]
    [ValidateSet('Light','Medium','Heavy','Clothing')]
    [string]$Weight,
    [parameter(ParameterSetName="Armor")]
    [ValidateSet('Boots','Coat','Gloves','Helm','HelmAquatic','Leggings','Shoulders')]
    [string]$Slot,
    [parameter(ParameterSetName="Weapon")]
    [ValidateSet('Axe','Dagger','Focus','Greatsword','Hammer','Harpoon','LongBow','Mace',
        'Pistol','Rifle','Scepter','Shield','ShortBow','Speargun','Staff','Sword','Torch',
        'Trident','Warhorn')]
    [string]$WeaponType
)

Begin {
    $RequiredModules = @(
        @{ 
            "Name"="GW2.PS.Cache"
            "Version"=[version]"0.1.2.40"
        }
        @{ 
            "Name"="GW2.PS.API"
            "Version"=[version]"0.1.2.40"
        }
    )

    ForEach ($ReqMod in $RequiredModules) {
        If (Get-Module -Name $ReqMod.Name -ListAvailable | Where-Object {$_.Version -ge $ReqMod.Version}) {
            Write-Debug "Found module $($ReqMod.Name) [>=$($ReqMod.Version)]"
        } else {
            Write-Error "Required module $($ReqMod.Name) [$($ReqMod.Version)] NOT FOUND!"
            $PromptResponse = Read-Host -Prompt "This script requires the publically available module $($ReqMod.Name) [version $($ReqMod.Version) or higher].  Can we install this module now? (y/N)"
            If ($PromptResponse -match "^y") {
                Install-Module -Name $ReqMod.Name -MinimumVersion $ReqMod.Version -Force
                Import-Module -Name $ReqMod.Name
                If (-not (Get-GW2APIKey)) {
                    Write-Host ""
                    Write-Host "You will need an API Key from Arena Net to access your GW2 account." -ForegroundColor Cyan
                    Write-Host "You can get full details at https://bit.ly/gw2psinst or just go" -ForegroundColor Cyan
                    Write-Host "directly to https://account.arena.net/applications to get your API Key." -ForegroundColor Cyan
                    Write-Host
                    Set-GW2APIKey
                }
            }
        }
    }
}

Process {
    
    If (Test-Path $CSVFilePath -ErrorAction SilentlyContinue) {
        $CSVFile = Get-Item $CSVFilePath
        If ($CSVFile.Extension -ne ".csv") {
            $newFilePath = $CSVFile.FullName -replace "$([RegEx]::Escape($CSVFile.Extension))$",".csv"
            Rename-item $CSVFile.FullName $newFilePath
            $CSVFilePath = $newFilePath
        }
    }
    Write-Host ("{0:[HH:mm:ss]} Will export data to {1}" -f (Get-Date),$CSVFilePath)

    Write-Host ("{0:[HH:mm:ss]} Getting unlocked skin IDs..." -f (Get-Date))
    $unlockedSkins = Get-GW2AccountSkin


    Write-Host ("{0:[HH:mm:ss]} Geting locked skin IDs..." -f (Get-Date))
    $allSkins = Get-GW2Skin
    $lockedSkins = $allSkins | Where-Object { $_ -notin $unlockedSkins }

    Write-Host ("{0:[HH:mm:ss]} Getting all items' details..." -f (Get-Date))
    $allItems = Get-GW2Item 
    $allItemDetails = $allItems | Group-GW2ObjectByCount | Get-GW2Item | Where-Object { ($_.Flags -notcontains 'AccountBound') -and ($_.Flags -notcontains 'SoulbindOnAcquire') }

    If ($Rarity) {
        $allItemDetails = $allItemDetails | Where-Object { $_.rarity -eq $Rarity }
    }
    If ($ItemType) {
        $allItemDetails = $allItemDetails | Where-Object { $_.type -eq $ItemType }
    }
    If ($Weight) {
        $allItemDetails = $allItemDetails | Where-Object { $_.details.weight_class -eq $Weight }
    }
    If ($Slot) {
        $allItemDetails = $allItemDetails | Where-Object { $_.details.type -eq $Slot }
    }
    If ($WeaponType) {
        $allItemDetails = $allItemDetails | Where-Object { $_.details.type -eq $WeaponType }
    }


    Write-Host ("{0:[HH:mm:ss]} Getting items ($($allItemDetails.count)) with locked skins ($($lockedSkins.count))..." -f (Get-Date))
    $itemsWithLockedSkins = $allItemDetails | Where-Object { $_.default_skin -in $lockedSkins }
    $lockedSkinIds = $itemsWithLockedSkins.default_skin | Select-Object -Unique

    Write-Host ("{0:[HH:mm:ss]} Getting details of locked skins ($($lockedSkinIds.count))..." -f (Get-Date))
    $lockedSkinDetailsTable = @{}
    $lockedSkinIds | Group-GW2ObjectByCount | Get-GW2Skin | ForEach-Object { $id=$_.id; $lockedSkinDetailsTable.$id = $_ }
    $itemsWithLockedSkins | Add-Member ScriptProperty Skin { $lockedSkinDetailsTable.($this.default_skin) } -Force

    Write-Host ("{0:[HH:mm:ss]} Getting auctions of locked items..." -f (Get-Date))
    $auctionListingsTable = @{}
    ($itemsWithLockedSkins | Where-Object { $_.default_skin -in $lockedSkinIds } ).id | 
        Group-GW2ObjectByCount | Get-GW2CommerceListing -UseCache:$false | ForEach-Object { $id=$_.id; $auctionListingsTable.$id = $_ }

    Write-Host ("{0:[HH:mm:ss]} Associating details about items..." -f (Get-Date))
    $itemsWithLockedSkins | Add-Member ScriptProperty WikiURL { "https://wiki.guildwars2.com/wiki/?search={0}&ns0=1" -f ($this.chat_link) } -Force
    $itemsWithLockedSkins | Add-Member ScriptProperty Slot { $this.details.type } -Force
    $itemsWithLockedSkins | Add-Member ScriptProperty Weight_Class { $this.details.weight_class } -Force
    $itemsWithLockedSkins | Add-Member ScriptProperty Defense { $this.details.Defense } -Force
    $itemsWithLockedSkins | Add-Member ScriptProperty Power { $this.details.max_power } -Force
    $itemsWithLockedSkins | Add-Member ScriptProperty SkinId { $this.Skin.id } -Force
    $itemsWithLockedSkins | Add-Member ScriptProperty SkinName { $this.Skin.name } -Force
    $itemsWithLockedSkins | Add-Member ScriptProperty SkinType { $this.Skin.type } -Force
    $itemsWithLockedSkins | Add-Member ScriptProperty SkinIcon { $this.Skin.icon } -Force
    $itemsWithLockedSkins | Add-Member ScriptProperty Listings { if ($this.flags -notcontains "AccountBound") { $auctionListingsTable.($this.id) } }
    $itemsWithLockedSkins | Add-Member ScriptProperty Buys { if ($this.Listings) { $this.Listings.Buys } } -Force
    $itemsWithLockedSkins | Add-Member ScriptProperty Sells { if ($this.Listings) { $this.Listings.Sells } } -Force
    $itemsWithLockedSkins | Add-Member ScriptProperty MaxBuy { if ($this.Listings) { ($this.Buys | Sort-Object unit_price | Select-Object -last 1).unit_price/10000 } } -Force
    $itemsWithLockedSkins | Add-Member ScriptProperty MinSell { if ($this.Listings) { ($this.Sells | Sort-Object unit_price | Select-Object -first 1).unit_price/10000 } } -Force

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

    Write-Host ("{0:[HH:mm:ss]} Saving to CSV file..." -f (Get-Date))
    $itemsWithLockedSkins | Where-Object { $_.Listings } | Select-Object -Property $OutputFields | Export-CSV -NoTypeInformation -Path $CSVFilePath -Append:$Append

    Write-Host ("{0:[HH:mm:ss]} Attempting to open CSV file with default app..." -f (Get-Date))
    Start-Process $CSVFilePath

    Write-Host ("{0:[HH:mm:ss]} CSV file should be found at {1}" -f (Get-Date),$CSVFilePath)
}