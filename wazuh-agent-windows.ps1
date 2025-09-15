# This script downloads the Wazuh agent and installs it silently.
# It automatically uses the computer's hostname as the agent name and starts the service.

$WAZUH_MANAGER_IP = "<PUT MANAGER FQDN/IP HERE>"
$AGENT_URL = "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.5-1.msi"
$AGENT_FILENAME = "wazuh-agent.msi"
$AGENT_PATH = Join-Path $env:TEMP $AGENT_FILENAME

# --- Animated Intro ---
Write-Host -NoNewline "Getting hostname"
Start-Sleep -Seconds 1
Write-Host -NoNewline "."
Start-Sleep -Seconds 0.5
Write-Host -NoNewline "."
Start-Sleep -Seconds 0.5
Write-Host -NoNewline "."
Start-Sleep -Seconds 1
Write-Host "" # Newline
Write-Host ""
Start-Sleep -Seconds 0.2
Write-Host "Got it, hostname is $env:COMPUTERNAME"
Start-Sleep -Seconds 0.3
Write-Host "Target is $WAZUH_MANAGER_IP"
Start-Sleep -Seconds 1
Write-Host ""

Write-Host "Downloading and installing the Wazuh agent with hostname '$($env:COMPUTERNAME)'..."
Start-Sleep -Seconds 1
# --- End of Intro ---

# Download the Wazuh agent installer
try {
    Invoke-WebRequest -Uri $AGENT_URL -OutFile $AGENT_PATH -ErrorAction Stop
    Write-Host "Download complete."
} catch {
    Write-Host "Error: Failed to download the Wazuh agent. Please check the URL and your network connection."
    # Exit the script if download fails
    exit 1
}

# Define arguments for the installer.
# This makes the command easier to read and manage.
$msiexec_args = @(
    "/i",
    "`"$AGENT_PATH`"",
    "/q",
    "WAZUH_MANAGER='$WAZUH_MANAGER_IP'",
    "WAZUH_REGISTRATION_SERVER='$WAZUH_MANAGER_IP'",
    "WAZUH_AGENT_NAME='$env:COMPUTERNAME'"
)

# Run the installer silently
Start-Process msiexec.exe -ArgumentList $msiexec_args -Wait -NoNewWindow

# Check the exit code of the installer
if ($LASTEXITCODE -eq 0) {
    Write-Host "Installation successful. Starting the Wazuh agent service..."
    
    # Start the Wazuh agent service
    Start-Service -Name "WazuhSvc"
    
    Write-Host "Wazuh agent installation and startup complete."

    # Clean up the downloaded installer
    Remove-Item -Path $AGENT_PATH -Force
    Write-Host "Cleaned up installer file."
} else {
    Write-Host "Error: Wazuh agent installation failed with exit code $LASTEXITCODE. Please check the MSI log."
}

