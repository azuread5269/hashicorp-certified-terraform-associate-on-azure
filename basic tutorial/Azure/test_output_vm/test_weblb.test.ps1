Import-Module Pester 

Write-Verbose "Obtain LB name from 10.lb_public_ip.tf" -Verbose
$LBpubfqdn =  (((Get-Content C:\terraform\Jobs\twovms_split_tf\10.lb_public_ip.tf | Select-String 'domain_name_label').ToString().Trim().TrimEnd().Split('=')[1])).Replace('"','').Trim()

Write-Verbose "Obtain count from 5.public_ips.tf" -Verbose
$VMpubipcount  = ((Get-Content C:\terraform\Jobs\twovms_split_tf\5.public_ips.tf | Select-String 'count = ').ToString().Trim().TrimEnd().Split('=')[1]).Trim()

Write-Verbose "Obtain names from 5.public_ips.tf" -Verbose
$VMpubfqdn = (((Get-Content C:\terraform\Jobs\twovms_split_tf\5.public_ips.tf | Select-String 'domain_name_label').ToString().Trim().TrimEnd().Split('=')[1]).Trim().Split('$')[0]).Replace('"','')
$i = 0
$VMFQDNS = 
do {
    $VMpubfqdn+$i+".ukwest.cloudapp.azure.com"
    $i++
}until($i -eq $VMpubipcount)
$LBFQDN = $LBpubfqdn+".ukwest.cloudapp.azure.com"
$FqdnToTest = $VMFQDNS+=$LBFQDN


Describe "test Web-server on Azure" {

    foreach ($thing in $LBFQDN)
    {
        $SC = Invoke-WebRequest $thing
        it "the status code for $thing should be 200" {
        $SC.StatusCode | Should be '200'

        }

              
    }

}
