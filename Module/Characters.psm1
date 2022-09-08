Function Get-GW2BuildStorage {
    <#
    .SYNOPSIS
    Get the account/buildstorage from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/buildstorage" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Dye {
    <#
    .SYNOPSIS
    Get the account/dyes from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/dyes" -SecureAPIKey $SecureAPIKey 
    }
}
        
Function Get-GW2Emote {
    <#
    .SYNOPSIS
    Get the account/emotes from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/emotes" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Glider {
    <#
    .SYNOPSIS
    Get the account/glider from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/gliders" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Inventory {
    <#
    .SYNOPSIS
    Get the account/inventory from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/inventory" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Title {
    <#
.SYNOPSIS
Get the account/titles from Guild Wars 2 API
#>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/titles" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Worldboss {
    <#
    .SYNOPSIS
    Get the account/worldbosses from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "account/worldbosses" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2BackstoryAnswer {
    <#
        .SYNOPSIS
        Get the backstory/answers from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "backstory/answers" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2BackstoryQuestion {
    <#
    .SYNOPSIS
    Get the backstory/questions from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        Get-GW2APIValue -APIValue "backstory/questions" -SecureAPIKey $SecureAPIKey 
    }
}

Function Get-GW2Character {
    <#
        .SYNOPSIS
        Get the characters from Guild Wars 2 API
        #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        If ($CharacterId) {
            Get-GW2CharacterCore -SecureAPIKey $SecureAPIKey -CharacterId $CharacterId
        }
        else {
            Get-GW2APIValue -APIValue "characters" -SecureAPIKey $SecureAPIKey 
        }
    }
}

Function Get-GW2CharacterBackstory {
    <#
            .SYNOPSIS
            Get the characters/(id)/backstory from Guild Wars 2 API
            #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/backstory" -SecureAPIKey $SecureAPIKey 
        }
    }
}
            
Function Get-GW2CharacterBuildtab {
    <#
    .SYNOPSIS
    Get the characters/(id)/buildtabs from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId,
        [parameter(ValueFromPipelineByPropertyName)]
        [string[]]$TabId,
        [switch]$All
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            If ($All) {
                Get-GW2APIValue -APIValue "characters/$i/buildtabs" -SecureAPIKey $SecureAPIKey -APIParams @{ "tabs" = "all" }
            }
            elseif ($TabId) {
                ForEach ($tab in $TabId) {
                    Get-GW2APIValue -APIValue "characters/$i/buildtabs" -SecureAPIKey $SecureAPIKey -APIParams @{ "tab" = "$tab" }
                }
            }
            else {
                Get-GW2APIValue -APIValue "characters/$i/buildtabs" -SecureAPIKey $SecureAPIKey
            }
        }
    }
}

Function Get-GW2CharacterBuildtabActive {
    <#
    .SYNOPSIS
    Get the characters/(id)/buildtabs/active from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/buildtabs/active" -SecureAPIKey $SecureAPIKey 
        }
    }
}

Function Get-GW2CharacterCore {
    <#
        .SYNOPSIS
        Get the characters/(id)/core from Guild Wars 2 API
        #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/core" -SecureAPIKey $SecureAPIKey 
        }
    }
}

Function Get-GW2CharacterCrafting {
    <#
    .SYNOPSIS
    Get the characters/(id)/crafting from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/crafting" -SecureAPIKey $SecureAPIKey 
        }
    }
}

Function Get-GW2CharacterEquipment {
    <#
    .SYNOPSIS
    Get the characters/(id)/equipment from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/equipment" -SecureAPIKey $SecureAPIKey 
        }
    }
}
    
Function Get-GW2CharacterEquipmenttab {
    <#
    .SYNOPSIS
    Get the characters/(id)/equipmenttabs from Guild Wars 2 API
#>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/equipmenttabs" -SecureAPIKey $SecureAPIKey 
        }
    }
}
        
Function Get-GW2CharacterEquipmenttabActive {
    <#
    .SYNOPSIS
    Get the characters/(id)/equipmenttabs/active from Guild Wars 2 API
#>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/equipmenttabs/active" -SecureAPIKey $SecureAPIKey 
        }
    }
}

Function Get-GW2CharacterHeropoint {
    <#
    .SYNOPSIS
    Get the characters/(id)/heropoints from Guild Wars 2 API
    #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/heropoints" -SecureAPIKey $SecureAPIKey 
        }
    }
}

Function Get-GW2CharacterInventory {
    <#
    .SYNOPSIS
    Get the characters/(id)/inventory from Guild Wars 2 API
#>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/inventory" -SecureAPIKey $SecureAPIKey 
        }
    }
}
        
Function Get-GW2CharacterQuest {
    <#
    .SYNOPSIS
    Get the characters/(id)/quests from Guild Wars 2 API
#>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/quests" -SecureAPIKey $SecureAPIKey 
        }
    }
}

Function Get-GW2CharacterRecipe {
    <#
    .SYNOPSIS
    Get the characters/(id)/recipes from Guild Wars 2 API
#>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/recipes" -SecureAPIKey $SecureAPIKey 
        }
    }
}

Function Get-GW2CharacterSab {
    <#
    .SYNOPSIS
    Get the characters/(id)/sab from Guild Wars 2 API
#>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/sab" -SecureAPIKey $SecureAPIKey 
        }
    }
}
                    
Function Get-GW2CharacterSkill {
    <#
                        .SYNOPSIS
                        Get the characters/(id)/skills from Guild Wars 2 API
                        #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/skills" -SecureAPIKey $SecureAPIKey 
        }
    }
}

Function Get-GW2CharacterSpecialization {
    <#
                            .SYNOPSIS
                            Get the characters/(id)/specializations from Guild Wars 2 API
                            #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/specializations" -SecureAPIKey $SecureAPIKey 
        }
    }
}

Function Get-GW2CharacterTraining {
    <#
                                .SYNOPSIS
                                Get the characters/(id)/training from Guild Wars 2 API
                                #>
    [cmdletbinding(DefaultParameterSetName = "SecureAPIKey")]
    param(
        [parameter(ParameterSetName = "SecureAPIKey")]
        [SecureString]$SecureAPIKey = (Get-GW2APIKey),
        [parameter(ParameterSetName = "ClearAPIKey", Mandatory)]
        [string]$APIKey,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [Alias("Name", "CharacterName")]
        [string[]]$CharacterId
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { $SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }
        ForEach ($i in $CharacterId) {
            Get-GW2APIValue -APIValue "characters/$i/training" -SecureAPIKey $SecureAPIKey 
        }
    }
}
                                

            