Function Split-GW2OversizedParam {
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

Function Get-GW2APIValue {
<#
.SYNOPSIS
Get a value from the Guild Wars 2 APIv2
#>
    [CmdletBinding(DefaultParameterSetName="SecureAPIKey")]
    param(
        [parameter(ParameterSetName="SecureAPIKey",Position=0)]
        [System.Security.SecureString]$SecureAPIKey=(Get-GW2APIKey),
        [parameter(ParameterSetName="ClearAPIKey",Position=0,Mandatory)]
        [string]$APIKey,
        $APIValue='',
        $APIParams=@{},
        $APIBase='https://api.guildwars2.com/v2'
    )

    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { write-host 'yy';$SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }

        $URI = "$APIBase/$APIValue"

        $IsOversized = $false
        ForEach ($ParamName in ($APIParams.Keys)) {
            $SplitParams=Split-GW2OversizedParam -ParamName $ParamName -APIParams $APIParams
            If ($SplitParams.back) {
                $IsOversized = $true
                Get-GW2APIValue -APIBase $APIBase -SecureAPIKey $SecureAPIKey -APIValue $APIValue -APIParams $SplitParams.front
                Get-GW2APIValue -APIBase $APIBase -SecureAPIKey $SecureAPIKey -APIValue $APIValue -APIParams $SplitParams.back
            }
        }
        If (-not $IsOversized) {
            Write-Debug "calling REST GET: $URI ($(($APIParams.Values | ForEach-Object { $_ }) -join ';')) - ($($PSCmdlet.ParameterSetName)) [$(Get-GW2APIKey)]"
            If ($APIParams.count -gt 0) {
                Invoke-RestMethod -Method Get -Uri $URI -Authentication Bearer -Token $SecureAPIKey -Body $APIParams
            } else {
                Invoke-RestMethod -Method Get -Uri $URI -Authentication Bearer -Token $SecureAPIKey
            }
        }#>
    }
}

Function Get-GW2Base {
<#
.SYNOPSIS
Obtain the In Game Name (IGN) for the account
#>
[cmdletbinding(DefaultParameterSetName="SecureAPIKey")]
    param(
        [parameter(ParameterSetName="SecureAPIKey")]
        [SecureString]$SecureAPIKey=(Get-GW2APIKey),
        [parameter(ParameterSetName="ClearAPIKey",Mandatory)]
        [string]$APIKey
    )
    Process {
        If (-not ([string]::IsNullOrEmpty($APIKey))) { write-host 'yy';$SecureAPIKey = ConvertTo-SecureString -String $APIKey -AsPlainText -Force }

        ((Get-GW2APIValue -SecureAPIKey $SecureAPIKey) -split "`n") | ForEach-Object {
            If ($_ -match "(?<base>/v2/\S+) \[[^\[\]]\]") { $matches.base.tostring() }
        }
    }
}

