Import-Module Pester 

$getjson = Get-Content C:\terraform\Jobs\twovms_split_tf\terraform.tfstate.backup
$Fqdn = $getjson | Select-String '"fqdn":'
$FqdnToTest = 
$Fqdn.ForEach({
[string]$String = $_ 
($String.split(':')[1]).Replace('"','').Replace(',','').Trim().TrimEnd().TrimStart()

})
$Lbtotest = $FqdnToTest | ? {$_ -match 'lb'}


Describe "test Web-server on Azure" {

    foreach ($thing in $Lbtotest)
    {
        $SC = Invoke-WebRequest $thing
        it "the status code for $thing should be 200" {
        $SC.StatusCode | Should be '200'

        }

              
    }

}
