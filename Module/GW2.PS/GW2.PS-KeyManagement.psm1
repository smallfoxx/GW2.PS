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

Function Set-GW2APIKey {
    [CmdletBinding(DefaultParameterSetName="Secure")]
    Param(
        [parameter(ParameterSetName="ClearText",Mandatory)]
        [string]$APIKey,
        [parameter(ParameterSetName="Secure")]
        [SecureString]$SecureAPIKey,
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
            "ClearText" { write-debug 'Clear text key'; Set-GW2APIKey -GW2Profile $GW2Profile -SecureAPIKey (ConvertTo-SecureString -String $APIKey -AsPlainText -Force) -Force:$Force }
            Default { write-debug 'Set secure key'; 
            If (-not $SecureAPIKey) {
                $SecureAPIKey=(Read-Host -Prompt "Please paste API Key" -AsSecureString)
            }
            Set-GW2ConfigValue -Name APIKey -GW2Profile $GW2Profile -Value $SecureAPIKey }
        }
    } 
}

Function Get-GW2APIKey {
    param([string]$GW2Profile=$ModConfig.DefaultProfile)

    $ModConfig.Profiles.$GW2Profile.APIKey

}

Function LoadKeyConfig {
    Set-Variable -Name 'ModConfig' -Scope script -Option AllScope -Value (LoadConfig -PassThru)
}
