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
    [string]$WeaponType,
    [switch]$PassThru
)

Begin {
    $RequiredModules = @(
        @{ 
            "Name"="GW2.PS.LiteDB"
            "Version"=[version]"0.1.5"
        }
        @{ 
            "Name"="GW2.PS.Cache"
            "Version"=[version]"0.1.5"
        }
        @{ 
            "Name"="GW2.PS.API"
            "Version"=[version]"0.1.5"
        }
    )

    ForEach ($ReqMod in $RequiredModules) {
        If (@((Get-Module -Name $ReqMod.Name),(Get-Module -Name $ReqMod.Name -ListAvailable)) | Where-Object {$_.Version -ge $ReqMod.Version}) {
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

    $Connected = Connect-GW2LiteDB -PassThru

    If (Test-GW2DBMinimum -Prompt -PassThru) {

    } else {
        throw("Basic database content missing. Load data before proceeding.")
        break
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
    $unlockedSkins = Get-GW2AccountSkin -Online


    Write-Host ("{0:[HH:mm:ss]} Found $($unlockedSkins.count) unlocked. Geting locked skin IDs..." -f (Get-Date))
    $allSkinIDs = Get-GW2Skin
    $lockedSkinIDs = $allSkinIDs | Where-Object { $_ -notin $unlockedSkins }

    Write-Host ("{0:[HH:mm:ss]} Found $($lockedSkinIDs.count) locked. Building query..." -f (Get-Date))
    $generalFilters=@()

    If ($Rarity) {
        $generalFilters += "`$.rarity = '$Rarity'"
    }
    If ($ItemType) {
        $generalFilters += "`$.type = '$ItemType'"
    }
    If ($Weight) {
        $generalFilters += "`$.details.weight_class = '$Weight'"
    }
    If ($Slot) {
        $generalFilters += "`$.details.type = '$Slot'"
    }
    If ($WeaponType) {
        $generalFilters += "`$.details.type = '$WeaponType'"
    }

    Write-Host ("{0:[HH:mm:ss]} Querying for locked items..." -f (Get-Date))
    $lockedItems = ForEach ($lockedGroup in ($lockedSkinIDs | Group-GW2ObjectByCount)) {
        $lockedGroup = $lockedGroup -replace ",","','"
        $thisFilters = @("`$.default_skin IN ['{0}']" -f $lockedGroup) + $generalFilters
        $queryString = $thisFilters -join " AND "
        Write-Debug ("`t{0:[HH:mm:ss]} Query for this group: {1}" -f (Get-Date),$queryString)
        Get-GW2DBEntryByQuery -CollectionName 'items' -QueryString $queryString
    }
    write-host "Found $($lockedItems.count)"
    $lockedTradeable = $lockedItems | Where-Object { ($_.Flags -notcontains 'AccountBound') -and ($_.Flags -notcontains 'SoulbindOnAcquire') }
    write-Host "Of those, $($lockedTradeable.count) are tradeable"


    Write-Host ("{0:[HH:mm:ss]} Getting auction listings of locked items..." -f (Get-Date))
    $auctionListingsTable = @{}
    $lockedItemlistings = $lockedTradeable.id | Group-GW2ObjectByCount | Get-GW2CommerceListing -Online #-UseCache:$false -UseDB:$false
    ForEach ($listing in $lockedItemlistings) {
        $auctionListingsTable.($listing.id) = $listing
    }
    Write-Host "Found $($auctionListingsTable.count) listings"

    Write-Host ("{0:[HH:mm:ss]} Adding skins and listings to locked items..." -f (Get-Date))
    ForEach ($lockedItem in $lockedTradeable) {
        $skin = Get-GW2DBEntry -CollectionName 'skins' -id $($lockedItem.default_skin)
        $lockedItem | Add-Member NoteProperty Skin $Skin -Force
        $lockedItem | Add-Member NoteProperty Listings ($auctionListingsTable.($lockedItem.id)) -Force
    }

    Write-Host ("{0:[HH:mm:ss]} Associating details about items..." -f (Get-Date))
    $lockedTradeable | Add-Member ScriptProperty WikiURL { "https://wiki.guildwars2.com/wiki/?search={0}&ns0=1" -f ($this.chat_link) } -Force
    $lockedTradeable | Add-Member ScriptProperty Slot { $this.details.type } -Force
    $lockedTradeable | Add-Member ScriptProperty Weight_Class { $this.details.weight_class } -Force
    $lockedTradeable | Add-Member ScriptProperty Defense { $this.details.Defense } -Force
    $lockedTradeable | Add-Member ScriptProperty Power { $this.details.max_power } -Force
    $lockedTradeable | Add-Member ScriptProperty SkinId { $this.Skin.id } -Force
    $lockedTradeable | Add-Member ScriptProperty SkinName { $this.Skin.name } -Force
    $lockedTradeable | Add-Member ScriptProperty SkinType { $this.Skin.type } -Force
    $lockedTradeable | Add-Member ScriptProperty SkinIcon { $this.Skin.icon } -Force
    $lockedTradeable | Add-Member ScriptProperty Buys { if ($this.Listings) { $this.Listings.Buys } } -Force
    $lockedTradeable | Add-Member ScriptProperty Sells { if ($this.Listings) { $this.Listings.Sells } } -Force
    $lockedTradeable | Add-Member ScriptProperty MaxBuy { if ($this.Listings) { ($this.Buys | Sort-Object unit_price | Select-Object -last 1).unit_price/10000 } } -Force
    $lockedTradeable | Add-Member ScriptProperty MinSell { if ($this.Listings) { ($this.Sells | Sort-Object unit_price | Select-Object -first 1).unit_price/10000 } } -Force -PassThru:$PassThru

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
    $lockedTradeable | Where-Object { $_.Listings } | Select-Object -Property $OutputFields | Export-CSV -NoTypeInformation -Path $CSVFilePath -Append:$Append

    Write-Host ("{0:[HH:mm:ss]} Attempting to open CSV file with default app..." -f (Get-Date))
    Start-Process $CSVFilePath

    Write-Host ("{0:[HH:mm:ss]} CSV file should be found at {1}" -f (Get-Date),$CSVFilePath)

}

End {
    If ($Connected) {
        Disconnect-GW2LiteDB
    }
}