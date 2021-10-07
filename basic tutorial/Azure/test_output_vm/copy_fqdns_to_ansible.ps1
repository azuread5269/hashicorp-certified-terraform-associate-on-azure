param (
    [string]$ansiblePassword  
)
Write-Verbose "Copying fqdns.txt to ansible:/etc/ansible/projects/AnsibleProjects/staging/" -Verbose
echo y | pscp.exe -P 22 -l pwaller -pw $ansiblePassword C:\terraform\Jobs\test_output\fqdns.txt pwaller@ansible:/etc/ansible/projects/AnsibleProjects/staging/


