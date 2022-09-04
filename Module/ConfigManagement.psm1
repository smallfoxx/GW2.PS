$MyPublisher="SMFX"
$MyModuleName="PoShGW2"

Function Get-Vars {
[CmdletBinding()]
param()
    Process {
        Get-Variable
    }
}

Function ConfigPath {
    "$env:AppData\$MyPublisher\$MyModuleName.xml"
}

Function BasicProfile {

    param([string]$Name)
    [ordered]@{
        "Name"=$Name
        "APIKey"=$null
    }
}

Function LoadConfig {
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
                'Default' = BasicProfile -Name "Default"
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

Function Get-DefaultProfile {

    $ModConfig.DefaultProfile
}

Function Save-Config {
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

Function Set-ConfigValue {
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [string]$Name,
        [parameter(ValueFromPipeline,ValueFromPipelineByPropertyName)]
        $Value,
        [parameter(ValueFromPipelineByPropertyName)]
        [string]$GW2Profile=(Get-DefaultProfile)
    )

    Begin {
        $TempConfig = LoadConfig -PassThru
    }

    Process {
        $TempConfig.$GW2Profile.$Name = $Value
    }

    End {
        $TempConfig | Save-Config
    }
}

LoadConfig
