$SecureDomainPassword = ConvertTo-SecureString "vagrant!A" -AsPlainText -Force
$dns = "lab.myhome"

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

Install-ADDSForest `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "WinThreshold" `
    -DomainName "$dns" `
    -DomainNetbiosName "AD00" `
    -ForestMode "WinThreshold" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -SafeModeAdministratorPassword $SecureDomainPassword `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true
