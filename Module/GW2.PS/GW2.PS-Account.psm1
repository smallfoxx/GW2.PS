Function Get-GW2Account {
    <#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account" -GW2Profile $GW2Profile
    }
}

Function Get-GW2IGN {
    <#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )

    Process {
        (Get-GW2Account -GW2Profile $GW2Profile).name
    }
}

Function Copy-GW2IGNToClipboard {
    <#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )

    Process {
        Get-GW2IGN -GW2Profile $GW2Profile | Set-Clipboard
    }
}

Function Get-GW2Bank {
    <#
.SYNOPSIS
Get the account/bank from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/bank" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Luck {
    <#
    .SYNOPSIS
    Get the account/luck from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/luck" -GW2Profile $GW2Profile 
    }
}
  
Function Get-GW2AccountMailCarrier {
    <#
    .SYNOPSIS
    Get the account/mailcarriers from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/mailcarriers" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2AccountMastery {
    <#
    .SYNOPSIS
    Get the account/masteries from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/masteries" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2MasteryPoint {
    <#
    .SYNOPSIS
    Get the account/mastery/points from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/mastery/points" -GW2Profile $GW2Profile 
    }
}
        
Function Get-GW2Progression {
    <#
.SYNOPSIS
Get the account/progression from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/progression" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Raid {
    <#
.SYNOPSIS
Get the account/raids from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/raids" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Wallet {
    <#
    .SYNOPSIS
    Get the account/wallet from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/wallet" -GW2Profile $GW2Profile 
    }
}
    
Function New-GW2Subtoken {
    <#
        .SYNOPSIS
        Create a subtoken from Guild Wars 2 API to accesss some settings
        #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(Mandatory)]
        [int]$Duration,
        [string[]]$Permissions,
        [string[]]$URLs
    )
    Process {
        $APIParams = @{ 
            "expire" = Get-Date -Date (Get-Date).AddDays($Duration) -Format "o" -AsUTC
        }

        If (-not [string]::IsNullOrEmpty($Permissions)) { $APIParams.permissions = $Permissions -join ',' }
        If (-not [string]::IsNullOrEmpty($URLs)) { $APIParams.urls = $URLs -join ',' }

        Get-GW2APIValue -APIValue "createsubtoken" -GW2Profile $GW2Profile -APIParams $APIParams
    }
}
        
Function Get-GW2Glider {
    <#
    .SYNOPSIS
    Get the gliders from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "gliders" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2MailCarrier {
    <#
        .SYNOPSIS
        Get the mailcarriers from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [Alias("ids")]
        [string[]]$ID
    )
    Process {
        If ($ID) {
            Get-GW2APIValue -APIValue "mailcarriers" -GW2Profile $GW2Profile -APIParams @{ 'ids' = ($ID -join ',') }
        }
        else {
            Get-GW2APIValue -APIValue "mailcarriers" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2AccountAchievement {
    <#
    .SYNOPSIS
    Get the account/achievements from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Achievement"
    }
    Process {
        $APIEndpoint = "account/achievements"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
Function Get-GW2AccountBank {
    <#
        .SYNOPSIS
        Get the account/bank from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Bank"
    }
    Process {
        $APIEndpoint = "account/bank"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountBuildstorage {
    <#
    .SYNOPSIS
    Get the account/buildstorage from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Buildstorage"
    }
    Process {
        $APIEndpoint = "account/buildstorage"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountDailycrafting {
    <#
        .SYNOPSIS
        Get the account/dailycrafting from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Dailycrafting"
    }
    Process {
        $APIEndpoint = "account/dailycrafting"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
        
Function Get-GW2AccountDungeon {
    <#
    .SYNOPSIS
    Get the account/dungeons from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Dungeon"
    }
    Process {
        $APIEndpoint = "account/dungeons"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountDye {
    <#
        .SYNOPSIS
        Get the account/dyes from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Dye"
    }
    Process {
        $APIEndpoint = "account/dyes"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountEmote {
    <#
    .SYNOPSIS
    Get the account/emotes from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Emote"
    }
    Process {
        $APIEndpoint = "account/emotes"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountFinisher {
    <#
        .SYNOPSIS
        Get the account/finishers from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Finisher"
    }
    Process {
        $APIEndpoint = "account/finishers"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountGlider {
    <#
    .SYNOPSIS
    Get the account/gliders from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Glider"
    }
    Process {
        $APIEndpoint = "account/gliders"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountHomeCat {
    <#
        .SYNOPSIS
        Get the account/home/cats from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Cat"
    }
    Process {
        $APIEndpoint = "account/home/cats"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountHomeNode {
    <#
    .SYNOPSIS
    Get the account/home/nodes from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Node"
    }
    Process {
        $APIEndpoint = "account/home/nodes"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
    
Function Get-GW2AccountInventory {
    <#
    .SYNOPSIS
    Get the account/inventory from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Inventory"
    }
    Process {
        $APIEndpoint = "account/inventory"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountLegendaryarmory {
    <#
    .SYNOPSIS
    Get the account/legendaryarmory from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Legendaryarmory"
    }
    Process {
        $APIEndpoint = "account/legendaryarmory"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountLuck {
    <#
    .SYNOPSIS
    Get the account/luck from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Luck"
    }
    Process {
        $APIEndpoint = "account/luck"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountMailcarrier {
    <#
    .SYNOPSIS
    Get the account/mailcarriers from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Mailcarrier"
    }
    Process {
        $APIEndpoint = "account/mailcarriers"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountMapchest {
    <#
    .SYNOPSIS
    Get the account/mapchests from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Mapchest"
    }
    Process {
        $APIEndpoint = "account/mapchests"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountMastery {
    <#
    .SYNOPSIS
    Get the account/masteries from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Masterie"
    }
    Process {
        $APIEndpoint = "account/masteries"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountMasteryPoint {
    <#
    .SYNOPSIS
    Get the account/mastery/points from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Point"
    }
    Process {
        $APIEndpoint = "account/mastery/points"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountMaterial {
    <#
    .SYNOPSIS
    Get the account/materials from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Material"
    }
    Process {
        $APIEndpoint = "account/materials"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountMini {
    <#
    .SYNOPSIS
    Get the account/minis from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Mini"
    }
    Process {
        $APIEndpoint = "account/minis"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountMountSkin {
    <#
    .SYNOPSIS
    Get the account/mounts/skins from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Skin"
    }
    Process {
        $APIEndpoint = "account/mounts/skins"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountMountType {
    <#
    .SYNOPSIS
    Get the account/mounts/types from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Type"
    }
    Process {
        $APIEndpoint = "account/mounts/types"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountNovelty {
    <#
    .SYNOPSIS
    Get the account/novelties from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Noveltie"
    }
    Process {
        $APIEndpoint = "account/novelties"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountOutfit {
    <#
    .SYNOPSIS
    Get the account/outfits from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Outfit"
    }
    Process {
        $APIEndpoint = "account/outfits"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountProgression {
    <#
    .SYNOPSIS
    Get the account/progression from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Progression"
    }
    Process {
        $APIEndpoint = "account/progression"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountPvpHero {
    <#
    .SYNOPSIS
    Get the account/pvp/heroes from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Heroe"
    }
    Process {
        $APIEndpoint = "account/pvp/heroes"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountRaid {
    <#
    .SYNOPSIS
    Get the account/raids from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Raid"
    }
    Process {
        $APIEndpoint = "account/raids"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountRecipe {
    <#
    .SYNOPSIS
    Get the account/recipes from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Recipe"
    }
    Process {
        $APIEndpoint = "account/recipes"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountSkin {
    <#
    .SYNOPSIS
    Get the account/skins from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Skin"
    }
    Process {
        $APIEndpoint = "account/skins"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountTitle {
    <#
    .SYNOPSIS
    Get the account/titles from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Title"
    }
    Process {
        $APIEndpoint = "account/titles"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountWallet {
    <#
    .SYNOPSIS
    Get the account/wallet from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Wallet"
    }
    Process {
        $APIEndpoint = "account/wallet"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}

Function Get-GW2AccountWorldboss {
    <#
    .SYNOPSIS
    Get the account/worldbosses from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters -IDType "Worldbosse"
    }
    Process {
        $APIEndpoint = "account/worldbosses"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}
Function Get-GW2Tokeninfo {
    <#
    .SYNOPSIS
    Get the tokeninfo/ from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters
    }
    Process {
        $APIEndpoint = "tokeninfo"
        Get-GW2APIValue -APIValue $APIEndpoint @PSBoundParameters
    }
}



Set-Alias -Name ign -Value Get-GW2IGN
Set-Alias -Name gw2ign -Value Get-GW2IGN
Set-Alias -Name gw2ign2cb -Value Copy-GW2IGNToClipboard
Set-Alias -Name cign -Value Copy-GW2IGNToClipboard
