#!/bin/bash

# Extract the entire text from the Vault entry
EXTRACTED=$(./vaultx.sh --cli --vault default --action get --entry router)

# Add an empty line before the Master Password input prompt
echo ""

# Extract the username (assuming it appears in the line 'Username: <value>')
USERNAME=$(echo "$EXTRACTED" | grep -oP '(?<=Username: ).*')

# Extract the password (assuming it appears in the line 'Password: <value>')
PASSWORD=$(echo "$EXTRACTED" | grep -oP '(?<=Password: ).*')

# Check if the username and password were successfully extracted
if [ -z "$USERNAME" ]; then
  echo "Username could not be extracted."
  exit 1
else
  echo "Username: $USERNAME"
fi

if [ -z "$PASSWORD" ]; then
  echo "Password could not be extracted."
  exit 1
else
  echo "Password: $PASSWORD"
fi

# Use sshpass with the extracted username and password for SSH
# Example: Connecting to a remote server (adjust IP address and port as needed)
sshpass -p "$PASSWORD" ssh "$USERNAME@<remote_host>" -p <port>
