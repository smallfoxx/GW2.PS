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
    Begin {
        $CommParams = CommonGW2Parameters
        Write-host "Right now its $GW2Profile"
    }
    Process {
        ForEach ($Comm in ($CommParams.Keys)) {
            Set-Variable -Name $Comm -Value $PSBoundParameters.$Comm
            If (-not [string]::IsNullOrEmpty((Get-Variable -Name $Comm))) {
                Set-Variable -Name $Comm -Value $CommParams.$Comm.Value
            }
        }

        If ($Id) {
            Get-GW2CharacterCore -GW2Profile $GW2Profile -CharacterId $Id
        }
        else {
            write-host "Get characters with $GW2Profile"
            $PSBoundParameters | % { write-host "boundParam: $($_.key)" }
            Get-GW2APIValue -APIValue "characters" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2CharacterBackstory {
    <#
            .SYNOPSIS
            Get the characters/(id)/backstory from Guild Wars 2 API
            #>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/backstory" -GW2Profile $GW2Profile 
        }
    }
}
            
Function Get-GW2CharacterBuildtab {
    <#
    .SYNOPSIS
    Get the characters/(id)/buildtabs from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [parameter(ValueFromPipelineByPropertyName)]
        [string[]]$TabId,
        [switch]$All,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            If ($All) {
                Get-GW2APIValue -APIValue "characters/$i/buildtabs" -GW2Profile $GW2Profile -APIParams @{ "tabs" = "all" }
            }
            elseif ($TabId) {
                ForEach ($tab in $TabId) {
                    Get-GW2APIValue -APIValue "characters/$i/buildtabs" -GW2Profile $GW2Profile -APIParams @{ "tab" = "$tab" }
                }
            }
            else {
                Get-GW2APIValue -APIValue "characters/$i/buildtabs" -GW2Profile $GW2Profile
            }
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
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/buildtabs/active" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2CharacterCore {
    <#
        .SYNOPSIS
        Get the characters/(id)/core from Guild Wars 2 API
        #>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/core" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2CharacterCrafting {
    <#
    .SYNOPSIS
    Get the characters/(id)/crafting from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/crafting" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2CharacterEquipment {
    <#
    .SYNOPSIS
    Get the characters/(id)/equipment from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/equipment" -GW2Profile $GW2Profile 
        }
    }
}
    
Function Get-GW2CharacterEquipmenttab {
    <#
    .SYNOPSIS
    Get the characters/(id)/equipmenttabs from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/equipmenttabs" -GW2Profile $GW2Profile 
        }
    }
}
        
Function Get-GW2CharacterEquipmenttabActive {
    <#
    .SYNOPSIS
    Get the characters/(id)/equipmenttabs/active from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/equipmenttabs/active" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2CharacterHeropoint {
    <#
    .SYNOPSIS
    Get the characters/(id)/heropoints from Guild Wars 2 API
    #>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/heropoints" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2CharacterInventory {
    <#
    .SYNOPSIS
    Get the characters/(id)/inventory from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/inventory" -GW2Profile $GW2Profile 
        }
    }
}
        
Function Get-GW2CharacterQuest {
    <#
    .SYNOPSIS
    Get the characters/(id)/quests from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/quests" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2CharacterRecipe {
    <#
    .SYNOPSIS
    Get the characters/(id)/recipes from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/recipes" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2CharacterSab {
    <#
    .SYNOPSIS
    Get the characters/(id)/sab from Guild Wars 2 API
#>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/sab" -GW2Profile $GW2Profile 
        }
    }
}
                    
Function Get-GW2CharacterSkill {
    <#
                        .SYNOPSIS
                        Get the characters/(id)/skills from Guild Wars 2 API
                        #>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/skills" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2CharacterSpecialization {
    <#
                            .SYNOPSIS
                            Get the characters/(id)/specializations from Guild Wars 2 API
                            #>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/specializations" -GW2Profile $GW2Profile 
        }
    }
}

Function Get-GW2CharacterTraining {
    <#
                                .SYNOPSIS
                                Get the characters/(id)/training from Guild Wars 2 API
                                #>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [string]$GW2Profile = (Get-GW2DefaultProfile)
    )
    Process {
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/training" -GW2Profile $GW2Profile 
        }
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
    Begin {
        $CommParams = CommonGW2Parameters
    }
    Process {
        ForEach ($Comm in ($CommParams.Keys)) {
            Set-Variable -Name $Comm -Value $PSBoundParameters.$Comm
            If (-not ((Get-Variable -Name $Comm).Value)) {
                Set-Variable -Name $Comm -Value $CommParams.$Comm.Value
            }
        }
        Get-GW2APIValue -APIValue "tokeninfo" -GW2Profile $GW2Profile 
    }
}
    
            