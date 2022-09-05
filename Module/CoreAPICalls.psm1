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
    param(
        $APIBase='https://api.guildwars2.com/v2',
        $APIKey = (Get-GW2APIKey),
        $APIValue='',
        $APIParams=@{}
    )

    Process {
        $URI = "$APIBase/$APIValue"

        $IsOversized = $false
        ForEach ($ParamName in ($APIParams.Keys)) {
            $SplitParams=Split-GW2OversizedParam -ParamName $ParamName -APIParams $APIParams
            If ($SplitParams.back) {
                $IsOversized = $true
                Get-APIValue -APIBase $APIBase -APIKey $APIKey -APIValue $APIValue -APIParams $SplitParams.front
                Get-APIValue -APIBase $APIBase -APIKey $APIKey -APIValue $APIValue -APIParams $SplitParams.back
            }
        }
        If (-not $IsOversized) {
            Write-Debug "calling REST GET: $URI ($(($APIParams.Values | ForEach-Object { $_ }) -join ';'))"
            If ($APIParams.count -gt 0) {
                Invoke-RestMethod -Method Get -Uri $URI -Authentication Bearer -Token $APIKey -Body $APIParams
            } else {
                Invoke-RestMethod -Method Get -Uri $URI -Authentication Bearer -Token $APIKey
            }
        }
    }
}

Function Get-GW2Base {
    Get-APIValue 
}

