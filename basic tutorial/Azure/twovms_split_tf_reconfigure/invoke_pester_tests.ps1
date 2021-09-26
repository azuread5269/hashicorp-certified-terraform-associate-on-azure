    Invoke-Pester C:\terraform\Jobs\twovms_split_tf\testweb.test.ps1 -OutputFormat NUnitXml -OutputFile  C:\terraform\Jobs\customscriptaction\testweb.test.xml -PassThru
    [xml]$GetXML = Get-Content C:\terraform\Jobs\twovms_split_tf\testweb.test.xml
    $Results = $GetXML.'test-results'.'test-suite'.result

    IF ($Results -match 'Failure')
    {
        exit 1
    }