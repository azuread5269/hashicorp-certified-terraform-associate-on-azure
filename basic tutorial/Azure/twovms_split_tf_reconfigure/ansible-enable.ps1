
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

    Write-Verbose "Log into Azure Portal" -Verbose
    Connect-AzAccount -Credential $Creds -Subscription b312c3d5-5b7c-4ab6-ae52-2b3a94b9c232  -Tenant d4cfe037-3ef4-42d7-a3f8-74f292af0782

    Write-Verbose "Obtain VMs in portal" -Verbose
    $VMName = Get-AzVM | ? {$_.Name -match 'AZ-VM'}

    Write-Verbose "Obtain Resource Groups in portal" -Verbose
    $RGname = Get-AzResourceGroup | ? {$_.ResourceGroupName -match 'pw52'}

    Write-Verbose "Obtain locations in portal" -Verbose
    $Location = "ukwest"

    Write-Verbose "Obtain binary blob contaning ansible script in portal" -Verbose
    $ScriptblobAccount = "pw5269scriptstore"
    $Scriptbloburl =  "https://pw5269scriptstore.blob.core.windows.net/pw5269containerscriptstore/"
    $Scriptblobkey = "6Pt+M1SgiU7c4UHnbEZ24Spm44XozLSCrS+u2Lc6gd3nOpvG+9mOOyClqz40BpL/DsmegLWY55HMcs3mkP8AgA=="

    Write-Verbose "Obtain custom script specifications in portal" -Verbose
    $Scriptname = "ansiblewinrm.ps1"
    $Extensionname = "AutoScript"
    $Extensiontype = "CustomScriptExtension"
    $publisher = "Microsoft.Compute"
    $Version = "1.8"
    $timestamp = (Get-Date).Ticks

    Write-Verbose "concatenate script and URL" -Verbose
    $Scriptlocation = $Scriptbloburl + $Scriptname
    $Scriptexe = ".\$Scriptname"

    Write-Verbose "concatenate URLs and storage accont " -Verbose
    $PrivateConfiguration = @{"storageAccountName" = "$ScriptBlobAccount";"storageAccountKey" = "$ScriptBlobKey"} 
    $PublicConfiguration = @{"fileUris" = [Object[]]"$ScriptLocation";"timestamp" = "$timestamp";"commandToExecute" = "powershell.exe -ExecutionPolicy Unrestricted -Command $ScriptExe"}

    foreach ($VM in $VMName)
    {
        Write-Verbose "set Extension on VM via Tools for vm $($VM.Name)" -Verbose
        Set-AzVMExtension -ResourceGroupName $RGName.ResourceGroupName -VMName $VM.Name -Location $Location `
        -Name $ExtensionName -Publisher $Publisher -ExtensionType $ExtensionType -TypeHandlerVersion $Version `
        -Settings $PublicConfiguration -ProtectedSettings $PrivateConfiguration 
    }

     Write-Verbose "Obtain Extension status" -Verbose
     foreach ($VM in $VMName)
     {
        ((Get-AzVM -Name $VM.Name -ResourceGroupName $RGName.ResourceGroupName -Status).Extensions | Where-Object {$_.Name -eq $ExtensionName}).Substatuses
     }

    foreach ($VM in $VMName)
    {
        Write-Verbose "Remove extension for VM $($VM.Name)" -Verbose
        Remove-AzVMExtension -ResourceGroupName $RGName.ResourceGroupName -VMName $VM.Name -Name $Extensionname -Force
    }
}
else
{
    exit 1
}