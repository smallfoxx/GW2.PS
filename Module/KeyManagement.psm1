Function TestSecretVault {

    $Vaults=Get-SecretVault
    If ($Vaults) {
        $DefaultVault = $Vaults | Where-Object { $_.IsDefaultVault }
        If ($DefaultVault) {
            $true
        } else {
            $false
        }
    } else {
        $false
    }

}

Function Set-APIKey {
    [CmdletBinding(DefaultParameterSetName="Secure")]
    Param(
        [parameter(ParameterSetName="ClearText",Mandatory)]
        [string]$APIKey,
        [parameter(ParameterSetName="Secure")]
        [SecureString]$SecureAPIKey=(Read-Host -Prompt "Please paste API Key" -AsSecureString),
        [string]$GW2Profile="Default",
        [switch]$Force)
    
<#
    If (-not (TestSecretVault)) {
        If ($Force) {
        }
    }
#>

    Process {
        switch ($PSCmdlet.ParameterSetName) {
            "ClearText" { Set-APIKey -GW2Profile $GW2Profile -SecureAPIKey (ConvertTo-SecureString -String $APIKey -AsPlainText -Force) -Force:$Force }
            Default { Set-GW2ConfigValue -Name APIKey -GW2Profile $GW2Profile -Value $SecureAPIKey }
        }
    } 
}

Function Get-APIKey {
    param([string]$Profile=$ModConfig.DefaultProfile)

    $ModConfig.$Profile.APIKey

}

Function Split-OversizedParam {
<#
.SYNOPSIS
Split up parameter sets when a very long parameter is provided
#>
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipeline)]
        [string]$ParamName,
        $APIParams=@{},
        [int]$MaxCount=100,
        [int]$MaxLength=10000
    )

    Process {
        $returnParam = @{
            'front'=@{}
            'back'=@{}
        }
        ForEach ($key in ($APIParams.keys | ?{ $_ -ne $ParamName})) {
            $returnParam.front.$key = $APIParams.$key
            $returnParam.back.$key = $APIParams.$key
        }
        
        $FocusParam = $APIParams.$ParamName
        $SplitParam = $FocusParam -split ","
        If ($SplitParam.Count -gt $MaxCount) {
            Write-Debug "Spliting count: $($SplitParam.Count)"
            $returnParam.front.$ParamName = (0..($MaxCount-1) | %{ $SplitParam[$_] }) -join "," 
            $returnParam.back.$ParamName = ($MaxCount..($SplitParam.Count-1) | %{ $SplitParam[$_]}) -join "," 
        } elseif ($SplitParam[0].Length -gt $MaxLength) {
            Write-Debug "Spliting length: $($SplitParam[0].Length)"
            $returnParam.front.$ParamName = $SplitParam[0].Substring(0,$MaxLength)
            $returnParam.back.$ParamName = $SplitParam[0].Substring($MaxLength,($SplitParam[0].Length-$MaxLength))
        } else {
            $returnParam.front.$ParamName = $FocusParam
            $returnParam.Remove('back')
        }
        return $returnParam
    }
}

Function Get-APIValue {
    param(
        $APIBase='https://api.guildwars2.com/v2',
        $APIKey = (Get-APIKey),
        $APIValue='',
        $APIParams=@{}
    )

    Process {
        $URI = "$APIBase/$APIValue"
    <# If ($URI -match "\?") {
            $URI += "&"
        } else {
            $URI += "?"
        }
        $URI += "access_token=$APIKey" #>

        $IsOversized = $false
        ForEach ($ParamName in ($APIParams.Keys)) {
            $SplitParams=Split-OversizedParam -ParamName $ParamName -APIParams $APIParams
            If ($SplitParams.back) {
                $IsOversized = $true
                Get-APIValue -APIBase $APIBase -APIKey $APIKey -APIValue $APIValue -APIParams $SplitParams.front
                Get-APIValue -APIBase $APIBase -APIKey $APIKey -APIValue $APIValue -APIParams $SplitParams.back
            }
        }
        If (-not $IsOversized) {
            Write-Debug "calling REST GET: $URI ($(($APIParams.Values | %{ $_ }) -join ';'))"
            If ($APIParams.count -gt 0) {
                Invoke-RestMethod -Method Get -Uri $URI -Authentication Bearer -Token $APIKey -Body $APIParams
            } else {
                Invoke-RestMethod -Method Get -Uri $URI -Authentication Bearer -Token $APIKey
            }
        }
    }
}

Function Get-Achievement {
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipeline)]
        [int[]]$AchivementID,
        [switch]$Daily,
        [switch]$Tomorrow,
        [switch]$Groups,
        [switch]$Categories
    )

    Begin {
        $IDs=@()
        $Base = "achievements"
        If ($Daily -or $Tomorrow) {
            $Base += "/daily"
            If ($Tomorrow) { $Base += "/tomorrow" }
        } elseif ($Groups) {
            $Base += "/groups"
        } elseif ($Categories) {
            $Base += "/categories"
        }
    }

    Process {
        $IDs+=$AchivementID | %{ $_ }
    }

    End {
        If ($IDs) {
            $APIValue = "$Base"
            #$APIValue += '?id='
            #$APIValue += ($IDs -join ",")
            Get-APIValue -APIValue $APIValue -APIParams @{ "ids" = ($IDs -join ",") }
        } else {
            (Get-APIValue -APIValue "$Base") -split "`n" | %{ [int]$_ } | Get-Achievement #-AchivementID ([int]($_)) }
        }
    }
}

Function Get-Base {
    Get-APIValue 
}

Function Get-KeyVars {
    Get-Variable
}

Function LoadKeyConfig {
    Set-Variable -Name 'ModConfig' -Scope script -Option AllScope -Value (LoadConfig -PassThru)
}
