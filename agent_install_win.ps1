[CmdletBinding()]
	Param (    
		[string] $aws_access_key,
		[string] $aws_secret_key
	)

# Foreach-Object -Parallel requires PowerShell 7.0 or later.
# Remove the parameter -Parallel and the requires statement
# if you are using an older version of PowerShell.
# Requires -version 7.0

$computers = Get-Content -Path "C:\Users\Public\computers.txt“
$computers | Foreach-Object -ThrottleLimit 5 -Parallel {   
	Invoke-Command -ComputerName $_ -ScriptBlock {
		$discovery_agent_url = "https://s3-us-west-2.amazonaws.com/aws-discovery-agent.us-west-2/windows/latest/AWSDiscoveryAgentInstaller.exe"      
		Invoke-WebRequest -Uri $discovery_agent_url -OutFile "C:\Windows\Temp\AWSDiscoveryAgentInstaller.exe"       
		C:\Windows\Temp\AWSDiscoveryAgentInstaller.exe REGION="us-east-1" KEY_ID="$aws_access_key" KEY_SECRET="$aws_secret_key" /q    
	}
}
