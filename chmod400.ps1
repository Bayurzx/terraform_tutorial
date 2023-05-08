#Parameters for Running the script

# To add args after the script     
# Param(
#     [string] $arg1,
#     [string] $arg2,
#     [string] $arg3
# )


[string] $keyFile = Read-Host "Enter full path of file"
Write-Host "Your key_pair at '$keyFile' will be processed" 
# [string] $publicip = "ec2-user@XX.xXX.xXX.xxX" #update the public ip address here

#view the security key file permissions
Write-Host "Current ACL permissions to the security file:"
Get-Acl $keyFile | fl

#add a current user with read control to the security file
$acl = Get-Acl $keyFile
$uName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($uName,"Read","Allow")
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $keyFile

#Delete inherited permissions
$acl.SetAccessRuleProtection($true,$false)
$acl | Set-Acl $keyFile

Write-Host "ACL Permissions after disabling inheritance and adding only read access to current user:"
Get-Acl $keyFile | fl

Write-Host "Kindly note that you may required special access in privileged directory"
# ssh to the ec2-instance
# ssh -i $keyFile $publicip
