# OpenVPN Simple Runner Script

A minimal Bash script to manage an OpenVPN connection in the background using a `.ovpn` config file.

## Features

- Start OpenVPN in the background (`--daemon`)
- Track process via PID file
- Prevent duplicate launches
- Simple CLI: `start`, `stop`, `restart`, `status`

## Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/yourusername/openvpn-simple-runner.git
   cd openvpn-simple-runner
   ```
2. Make script executable:
   ```bash
   chmod +x vpn.sh
   ```
3. Open the script and set your config file name:
   ```bash
   CONFIG_NAME="your_config_name_without_extension"
   ```
