# Wazuh Dynamic Agent Deployment Scripts
A collection of simple yet effective scripts to automate the deployment of the Wazuh agent on multiple operating systems
These scripts automatically detect the machine's hostname and use it as the `WAZUH_AGENT_NAME` during installation, making them ideal for bulk deployments

# Features
Dynamic Hostname: Automatically registers the agent with the computer's hostname
Cross-Platform: Provides scripts for Windows (PowerShell), Debian-based Linux (e.g., Ubuntu, Debian), RPM-based Linux (e.g., CentOS, RHEL, Fedora)
Unattended Installation: Runs silently without requiring user input
Automated Service Start: Enables and starts the Wazuh agent service right after installation
User-Friendly: Includes a simple "loading" animation for better feedback during execution

# Configuration
Before running any scripts, you must edit the file for your target OS to set two important variables.

### 1. Set Your Wazuh Manager IP/FQDN
Open the script and find the `WAZUH_MANAGER_IP` variable,
Replace the placeholder value with the actual IP address or Fully Qualified Domain Name (FQDN) of your Wazuh manager.

#### PowerShell (.ps1):
`$WAZUH_MANAGER_IP = "<PUT MANAGER FQDN/IP HERE>"`

#### Bash (.sh):
`WAZUH_MANAGER_IP="<PUT MANAGER FQDN/IP HERE>"`

### 2. Verify the Wazuh Agent VersionThese scripts are configured to download Wazuh Agent v4.7.5 
*** for different version, you must update the agent URL/filename variables in the script

You can find the latest package URLs in the official Wazuh Packages List
``https://documentation.wazuh.com/current/installation-guide/packages-list.html``

#### PowerShell (.ps1):
`$AGENT_URL = "[https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.5-1.msi](https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.5-1.msi)"`

#### Debian-based (.sh):
`AGENT_PKG="wazuh-agent_4.7.5-1_amd64.deb"
AGENT_URL="[https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/$](https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/$){AGENT_PKG}"`

#### RPM-based (.sh):
`AGENT_PKG="wazuh-agent-4.7.5-1.x86_64.rpm"
AGENT_URL="[https://packages.wazuh.com/4.x/yum/$](https://packages.wazuh.com/4.x/yum/$){AGENT_PKG}"`

# Usage
## Ensure you have administrative/root privileges before running the scripts 
### Windows: 
### *Open PowerShell as an Administrator

### Navigate to the directory containing the script, You may need to adjust the execution policy to run the script
`Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process`
#### Run the script:
`.\install-wazuh-agent.ps1`

### Debian-based Linux (Ubuntu, Debian)
#### Open a terminal, Make the script executable
`chmod +x install-wazuh-agent-deb.sh`
#### Run the script with sudo (if u're not in root)
`sudo ./install-wazuh-agent-deb.sh`

### RPM-based Linux (CentOS, RHEL, Fedora)
#### Open a terminal, Make the script executable
`chmod +x install-wazuh-agent-rpm.sh`
#### Run the script with sudo (unless u're root)
`sudo ./install-wazuh-agent-rpm.sh`

## Contributing
Feel free to open an issue or submit a pull request if you have suggestions for improvements!

- This caption was made by Gemini AI and modified by myself. 
