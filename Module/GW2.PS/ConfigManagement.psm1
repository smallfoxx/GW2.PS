$MyPublisher = "SMFX"
$MyModuleName = "GW2.PS"

$ReservedSettings = @(
    #'DefaultProfile',
    'Module',
    'Publisher',
    'Profiles'
)

Function ConfigPath {
    <#
.SYNOPSIS
Return the path to the configuration file; might depend on platform.
#>
    "$env:AppData\$MyPublisher\$MyModuleName.xml"
}

Function BasicProfile {
    <#
.SYNOPSIS
Provide standard template structure for a profile
#>
    [CmdletBinding()]
    param([string]$Name)
    [ordered]@{
        "GW2Profile" = $Name
        "APIKey"     = $null
    }
}

Function LoadConfig {
    <#
.SYNOPSIS
Load details from configuration file
.DESCRIPTION
Import configuration details from file system and generate a default template if not available.
#>
    [CmdletBinding()]
    param([switch]$PassThru)
    Process {
        If (-not (Test-Path (ConfigPath))) {
            IF (-not (Test-Path (Split-Path (ConfigPath) -Parent))) {
                $Null = mkdir (Split-Path (ConfigPath) -Parent)
            }
            $BasicConfig = [ordered]@{
                'Module'         = $MyModuleName
                'Publisher'      = $MyPublisher
                'DefaultProfile' = "Default"
                'Profiles'       = @{
                    'Default' = BasicProfile -Name "Default"
                }
            }
            #$BasicConfig | ConvertTo-Json | Set-Content -Path (ConfigPath)
            $BasicConfig | Save-Config
        }
        #$ConfigValue = (Get-Content (ConfigPath) | ConvertFrom-Json )
        $ConfigValue = Import-Clixml (ConfigPath) 
        Set-Variable -Name 'ModConfig' -Scope Global -Value $ConfigValue -Option ReadOnly -Force
        If ($PassThru) { $ConfigValue }
    }
}

Function Get-GW2DefaultProfile {
    <#
.SYNOPSIS
Return the name of the current default
#>
    $ModConfig.DefaultProfile
}

Function Save-GW2Config {
    <#
.SYNOPSIS
Export settings to configuration file
#>
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipeline)]
        $InputObject
    )

    Process {
        #$InputObject | ConvertTo-Json | Set-Content (ConfigPath)
        $InputObject | Export-Clixml -Path (ConfigPath)
    }
}

Function Set-GW2ConfigValue {
    <#
.SYNOPSIS
Set a value for the configuration
.DESCRIPTION
Will store a value in a profile unless -SystemSetting is indicated. If no profile or system is specified, it store in the default profile.
#>
    [CmdletBinding(DefaultParameterSetName = "ProfileSetting")]
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [string]$Name,
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        $Value,
        [parameter(ValueFromPipelineByPropertyName, ParameterSetName = "ProfileSetting")]
        [string]$GW2Profile = (Get-GW2DefaultProfile),
        [parameter(ParameterSetName = "SystemSetting", Mandatory)]
        [switch]$SystemSetting
    )

    Begin {
        $TempConfig = LoadConfig -PassThru
    }

    Process {
        If ($SystemSetting) {
            If ($Name -notin $ReservedSettings) {
                $TempConfig.$Name = $Value
            }
        }
        else {
            If (-not ($TempConfig.Profiles.containsKey($GW2Profile))) {
                $TempConfig.Profiles.$GW2Profile = BasicProfile -Name $GW2Profile
            }
            $TempConfig.Profiles.$GW2Profile.$Name = $Value
        }
    }

    End {
        $TempConfig | Save-GW2Config
        LoadConfig
    }
}

Function Set-GW2DefaultProfile {
    <#
    .SYNOPSIS
    Set the default profile name
    #>
    [CmdletBinding()]
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
            If (-not [string]::IsNullOrEmpty((Get-Variable -Name $Comm))) {
                Set-Variable -Name $Comm -Value $CommParams.$Comm.Value
            }
        }
        If ($GW2Profile) {
            Write-Debug "Setting default profile to $GW2Profile"
            Set-GW2ConfigValue -SystemSetting -Name DefaultProfile -Value $GW2Profile
            #Get-Variable
        }
    }
}    

Function NewGW2Function {
    param(
        [string]$Base,
        [string[]]$Subsection
    )

    $FunctionSections = ForEach ($Section in (@($Base) + $Subsection)) {
        If (-not [string]::IsNullOrEmpty($Section)) {
            ($Section.Substring(0, 1).ToUpper() + $Section.Substring(1).ToLower()) -replace "s$", ""
        }
    }

    $FunctionString = "Get-GW2$($FunctionSections -join '')"
    $URIStub = ((@($Base) + $Subsection) -join "/").ToLower()

    @"
Function $FunctionString {
<#
.SYNOPSIS
Get the $URIStub from Guild Wars 2 API
#>
    [cmdletbinding()]
    param()
    DynamicParam {
        CommonGW2Parameters
    }
    Begin {
        `$CommParams = CommonGW2Parameters
    }
    Process {
        ForEach (`$Comm in (`$CommParams.Keys)) {
            Set-Variable -Name `$Comm -Value `$PSBoundParameters.`$Comm
            If (-not ((Get-Variable -Name `$Comm).Value)) {
                Set-Variable -Name `$Comm -Value `$CommParams.`$Comm.Value
            }
        }
        Get-GW2APIValue -APIValue "$URIStub" -GW2Profile `$GW2Profile 
    }
}

"@ 

}

Function BuildGW2Functions {
    param($Bases = ((Get-GW2Base) -replace "^/v2/", "" ))

    ForEach ($Base in $Bases) {
        $Sections = $Base -split '/'
        $Root = $Sections[0]
        If ($Sections.Length -gt 1) {
            $Subs = $Sections[1..($Sections.Length - 1)]
        }
        else {
            $Subs = $null
        }
        NewGW2Function -Base $Root -Subsection $Subs | Set-Clipboard
        Write-Host "Function for $base on clipboard"
        Pause
    }
}

Function CommonGW2Parameters {
    <#
.SYNOPSIS
Create standard, dynamic parameters for GW2 functions.
.DESCRIPTION
This will create standard parameters for GW2 functions to provide values such as GW2Profile, ID, and other attributes
.PARAMETER IDType
Specifies that function calling this uses ID parameters
#>
    param([string]$IDType, [switch]$IDMandatory)
    $RuntimeParamDic = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
    $StandardProps = @('Mandatory', 'ValueFromPipelineByPropertyName', 'ValueFromPipeline', 'ParameterSetName', 'Position')
    $Attrib = [ordered]@{
        'GW2Profile' = @{
            'AttribType'                      = [string]
            'Mandatory'                       = $false
            'ValueFromPipelineByPropertyName' = $true
            'Position'                        = 0
            'ValidSet'                        = ([string[]]($ModConfig.Profiles.Keys))
            'DefaultValue'                    = (Get-GW2DefaultProfile)
        }
    }
    If ($IDType -or $IDMandatory) {
        $Attrib.ID = @{
            'AttribType'                      = [string[]]
            'Mandatory'                       = $IDMandatory
            'ValueFromPipelineByPropertyName' = $true
            'ValueFromPipeline'               = $true
            'Position'                        = 1
            'Alias'                           = @('ids')
        }
        If ($IDType -ne 'id') {
            $Attrib.ID.'Alias' += "$($IDType)ID" 
        }
    }
    
    ForEach ($AttribName in $Attrib.Keys) {
        #[string]$AttribName = $Key.ToString()
        $ThisAttrib = New-Object System.Management.Automation.ParameterAttribute
        ForEach ($Prop in $StandardProps) {
            If ($null -ne $Attrib.$AttribName.$Prop) {
                $ThisAttrib.$Prop = $Attrib.$AttribName.$Prop
            }
        }
        $ThisCollection = New-Object  System.Collections.ObjectModel.Collection[System.Attribute]
        $ThisCollection.Add($ThisAttrib)

        If ($Attrib.$AttribName.ValidSet) {
            $ThisValidation = New-Object  System.Management.Automation.ValidateSetAttribute($Attrib.$AttribName.ValidSet)
            $ThisCollection.Add($ThisValidation)
        }

        if ($Attrib.$AttribName.Alias) {
            $ThisAlias = New-Object -Type `
                System.Management.Automation.AliasAttribute -ArgumentList @($Attrib.$AttribName.Alias)
            $ThisCollection.Add($ThisAlias)
        }
    
        $ThisRuntimeParam = New-Object System.Management.Automation.RuntimeDefinedParameter($AttribName, $Attrib.$AttribName.AttribType, $ThisCollection)
        If ($Attrib.$AttribName.DefaultValue) {
            $ThisRuntimeParam.Value = $Attrib.$AttribName.DefaultValue
        }
        $RuntimeParamDic.Add($AttribName, $ThisRuntimeParam)
    }

    return  $RuntimeParamDic

}

Function CommParams {
    @(
        [parameter(ValueFromPipelineByPropertyName)]
        [string]$GW2Profile=(Get-GW2DefaultProfile)
    )
}

LoadConfig
