$ipv4 = "192.168.1.69"
$ethernet = "Ethernet Instance 0 2"

Disable-NetAdapterBinding -Name "$ethernet" -ComponentID ms_tcpip6

New-NetIPAddress -InterfaceAlias "$ethernet" `
    -IPAddress "$ipv4" `
    -PrefixLength 24 `
    -DefaultGateway "192.168.1.1"

Set-DnsClientServerAddress -InterfaceAlias "$ethernet" `
    -ServerAddresses ("127.0.0.1","8.8.8.8")
