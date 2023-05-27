#!bin/bash

# update system

# Get the absolute path of the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Define the log file path relative to the script directory
LOG_FILE="$SCRIPT_DIR/../log/autoUpdate.log"

touch "$LOG_FILE"
apt-get  update && apt-get upgrade -y --show-progress>> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then 
   echo "system update complete."

else 
   echo "system update failed."
   echo "check $LOG_FILE to get the error info."
   tail -n 10 "$LOG_FILE"
fi
