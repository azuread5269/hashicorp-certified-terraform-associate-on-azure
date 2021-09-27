    Invoke-Pester C:\terraform\Jobs\twovms_split_tf\test_weblb.test.ps1 -OutputFormat NUnitXml -OutputFile  C:\terraform\Jobs\twovms_split_tf\testweblb.test.xml -PassThru
    [xml]$GetXML = Get-Content C:\terraform\Jobs\twovms_split_tf\testweblb.test.xml
    $Results = $GetXML.'test-results'.'test-suite'.result

    IF ($Results -match 'Failure')
    {
        exit 1
    }