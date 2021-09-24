$GI = Get-Item WSMan:\localhost\Service\AllowUnencrypted
IF (!($GI.Value -match 'true'))
{
    Write-Warning "AllowUnencrypted not already configured, so configuring" -Verbose
    Set-Item WSMan:\localhost\Service\AllowUnencrypted -value true
    Set-Item WSMan:\localhost\Service\Auth\Basic -Value true 
}
ELSE
{
    Write-Verbose "AllowUnencrypted already configured" -Verbose
}
Write-Verbose "Disable all firewall rules" -Verbose
Get-NetFirewallProfile | % {Set-NetFirewallProfile -Name $_.name -Enabled False}