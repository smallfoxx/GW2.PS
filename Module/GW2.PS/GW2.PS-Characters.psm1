Function Get-GW2BuildStorage {
    <#
    .SYNOPSIS
    Get the account/buildstorage from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/buildstorage" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Dye {
    <#
    .SYNOPSIS
    Get the account/dyes from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/dyes" -GW2Profile $GW2Profile 
    }
}
        
Function Get-GW2Emote {
    <#
    .SYNOPSIS
    Get the account/emotes from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/emotes" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Glider {
    <#
    .SYNOPSIS
    Get the account/glider from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/gliders" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Inventory {
    <#
    .SYNOPSIS
    Get the account/inventory from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/inventory" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Title {
    <#
.SYNOPSIS
Get the account/titles from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/titles" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Worldboss {
    <#
    .SYNOPSIS
    Get the account/worldbosses from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "account/worldbosses" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2BackstoryAnswer {
    <#
        .SYNOPSIS
        Get the backstory/answers from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "backstory/answers" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2BackstoryQuestion {
    <#
    .SYNOPSIS
    Get the backstory/questions from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        Get-GW2APIValue -APIValue "backstory/questions" -GW2Profile $GW2Profile 
    }
}

Function Get-GW2Character {
    <#
        .SYNOPSIS
        Get the characters from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param(
        <#[parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)#>
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character'     
    }
    Process {
        Get-GW2APIValue -APIValue "characters" @PSBoundParameters 
    }
}

Function Get-GW2CharacterBackstory {
    <#
            .SYNOPSIS
            Get the characters/(id)/backstory from Guild Wars 2 API
            #>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character'     
    }
    Process {
        #ForEach ($i in $CharacterId) {
        Get-GW2APIValue -APIValue "characters/:id/backstory" @PSBoundParameters 
        #}
    }
}
            
Function Get-GW2CharacterBuildtab {
    <#
    .SYNOPSIS
    Get the characters/(id)/buildtabs from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [string[]]$TabId,
        [switch]$All
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        If ($All) {
            Get-GW2APIValue -APIValue "characters/:id/buildtabs" -APIParams @{ "tabs" = "all" } @PSBoundParameters | Add-Member NoteProperty CharacterID ($PSBoundParameters.ID)  -PassThru
        }
        elseif ($TabId) {
            ForEach ($tab in $TabId) {
                Get-GW2APIValue -APIValue "characters/:id/buildtabs" -APIParams @{ "tabs" = "$tab" } @PSBoundParameters  | Add-Member NoteProperty CharacterID ($PSBoundParameters.ID)  -PassThru
            }
        }
        else {
            Get-GW2APIValue -APIValue "characters/:id/buildtabs" @PSBoundParameters  | ForEach-Object { [PSCustomObject]@{ "Name" = $PSBoundParameters.ID; "TabID" = $_ } }#-APIParams @{ "tabs" = "all" }
        }
    }
}

Function Get-GW2CharacterBuildtabActive {
    <#
    .SYNOPSIS
    Get the characters/(id)/buildtabs/active from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/buildtabs/active" @PSBoundParameters 
    }
}

Function Get-GW2CharacterCore {
    <#
        .SYNOPSIS
        Get the characters/(id)/core from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/core" @PSBoundParameters
    }
}

Function Get-GW2CharacterCrafting {
    <#
    .SYNOPSIS
    Get the characters/(id)/crafting from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/crafting" @PSBoundParameters 
    }
    
}

Function Get-GW2CharacterEquipment {
    <#
    .SYNOPSIS
    Get the characters/(id)/equipment from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/equipment" @PSBoundParameters
    }
}
    
Function Get-GW2CharacterEquipmenttab {
    <#
    .SYNOPSIS
    Get the characters/(id)/equipmenttabs from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/equipmenttabs" @PSBoundParameters
    }
}
        
Function Get-GW2CharacterEquipmenttabActive {
    <#
    .SYNOPSIS
    Get the characters/(id)/equipmenttabs/active from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/equipmenttabs/active" @PSBoundParameters
    }
}

Function Get-GW2CharacterHeropoint {
    <#
    .SYNOPSIS
    Get the characters/(id)/heropoints from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/heropoints" @PSBoundParameters
    }
}

Function Get-GW2CharacterInventory {
    <#
    .SYNOPSIS
    Get the characters/(id)/inventory from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/inventory" @PSBoundParameters 
    }
}
        
Function Get-GW2CharacterQuest {
    <#
    .SYNOPSIS
    Get the characters/(id)/quests from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/quests" @PSBoundParameters
    }
}

Function Get-GW2CharacterRecipe {
    <#
    .SYNOPSIS
    Get the characters/(id)/recipes from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/recipes" @PSBoundParameters
        
    }
}

Function Get-GW2CharacterSab {
    <#
    .SYNOPSIS
    Get the characters/(id)/sab from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/sab" @PSBoundParameters
    }
}
                    
Function Get-GW2CharacterSkill {
    <#
                        .SYNOPSIS
                        Get the characters/(id)/skills from Guild Wars 2 API
                        #>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/skills" @PSBoundParameters
    }
}

Function Get-GW2CharacterSpecialization {
    <#
                            .SYNOPSIS
                            Get the characters/(id)/specializations from Guild Wars 2 API
                            #>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/specializations" @PSBoundParameters 
    }
}

Function Get-GW2CharacterTraining {
    <#
                                .SYNOPSIS
                                Get the characters/(id)/training from Guild Wars 2 API
                                #>
    [cmdletbinding()]
    param(
    )
    DynamicParam {
        CommonGW2Parameters -IDType 'Character' -IDMandatory 
    }
    Process {
        Get-GW2APIValue -APIValue "characters/:id/training" @PSBoundParameters 
    }
}
                                
         