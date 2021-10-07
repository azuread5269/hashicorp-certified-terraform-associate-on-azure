
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


    Write-Verbose "Obtain Resource Groups in portal" -Verbose
    $RGname = Get-AzResourceGroup | ? {$_.ResourceGroupName -match 'pw52'}

    Write-Verbose "Obtain locations in portal" -Verbose
    $Location = "ukwest"

    Write-Verbose "Obtain Storage Access keys for pw5269scriptstore" -Verbose
    $StorageAccessKeys = Get-AzStorageAccountKey -ResourceGroupName    $RGname.ResourceGroupName -Name pw5269scriptstore 

    Write-Verbose "Obtain Storage Account" -Verbose
    $SA = Get-AzStorageAccount | ? {$_.StorageAccountName -match 'pw5269storage'} 
    Write-Verbose "Obtain Storage Account container" -Verbose
    $container = Get-AzStorageContainer -Context $SA.Context | ? {$_.Name -match 'pw'}
    Write-Verbose "Obtain Storage blob" -Verbose
    $Blobs = Get-AzStorageBlob -Container $container.Name -Context $SA.Context 
    Write-Verbose "Obtain Storage blob content and download to c:\terraform" -Verbose
    $Blobcontent = Get-AzStorageBlobContent -Container $container.Name -Context $SA.Context -Blob "terraform.state" -Destination /tmp -Force
    Write-Verbose "Convert from JSON" -Verbose
    $content = Get-Content C:\terraform\terraform.state | ConvertFrom-Json
    Write-Verbose "Obtain FQDNS" -Verbose
    $FQDNS = $content.outputs.public_fqdn.value
      
}
else
{
    exit 1
}