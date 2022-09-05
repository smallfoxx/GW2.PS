$MyPublisher="SMFX"
$MyModuleName="PoShGW2"

$ReservedSettings = @(
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
        "Name"=$Name
        "APIKey"=$null
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
                'Module'=$MyModuleName
                'Publisher'=$MyPublisher
                'DefaultProfile'="Default"
                'Profiles' = @{
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
    [CmdletBinding(DefaultParameterSetName="ProfileSetting")]
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [string]$Name,
        [parameter(ValueFromPipeline,ValueFromPipelineByPropertyName)]
        $Value,
        [parameter(ValueFromPipelineByPropertyName,ParameterSetName="ProfileSetting")]
        [string]$GW2Profile=(Get-DefaultProfile),
        [parameter(ParameterSetName="SystemSetting",Mandatory)]
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
        } else {
            If (-not ($TempConfig.Profiles.containsKey($GW2Profile))) {
                $TempConfig.Profiles.$GW2Profile = BasicProfile -Name $GW2Profile
            }
            $TempConfig.Profiles.$GW2Profile.$Name = $Value
        }
    }

    End {
        $TempConfig | Save-Config
    }
}

LoadConfig
