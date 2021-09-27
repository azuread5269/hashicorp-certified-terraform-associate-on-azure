    
param (
    [string]$Password 
)
write-verbose "importing AZ Powershell Module into current session" -verbose
Import-Module az
$Mod = Get-Module az
IF (($Mod))
{
    Write-Verbose "Create credentials for Azure portal" -Verbose
    $User = "azauto@pwazure5269.co.uk"
    # $Pass = "Camberwe!!Carr0t!" | ConvertTo-SecureString -AsPlainText -Force
    $Pass = $Password | ConvertTo-SecureString -AsPlainText -Force
    $Creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User,$Pass
    Write-Verbose "Obtain VMs with prefix matching AZ-VM" -Verbose
    $VMName = Get-AzVM | ? {$VM.Name -match 'AZ-VM'}
    
    Write-Verbose "Obtain NIC NEtwork Profile" -Verbose
    $Nics =  $VMName.NetworkProfile
    $allNICs = 
    foreach ($NIC  in $Nics)
    {
        Write-Verbose "Obtaining $($NIC.NetworkInterfaces.id)" -Verbose
        [string]$String = $NIC.NetworkInterfaces.id
        $NicSplit = $String.Split('/')[-1]
        Get-AzNetworkInterface -Name $NicSplit
    }
    $i = 0 
    for ($s -eq 0;$i -lt $allNICs.Count;$i++) 
    {
        Write-Verbose "Disabling $($allNICs[$i].Name)" -Verbose
        $allNICs[$i].IpConfigurations.PublicIpAddress.id = $null
    }

}
else
{
    exit 1
}