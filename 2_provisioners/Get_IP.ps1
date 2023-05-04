$ip = curl -s ifconfig.me
Write-Output "{ ""location"" : ""$ip""}"
