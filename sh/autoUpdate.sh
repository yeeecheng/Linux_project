#!bin/bash

# update system

# define log path
LOG_FILE = "../log/atuoUpdate.log"

apt update && upgrade -y >> "$LOG_FILE" 2>&1

if [$? -eq 0]; then 
   echo "system update complete."

else 
   echo "system update failed."
   echo "check $LOG_FILE to get the error info."
   tail -n 10 "$LOG_FILE"
fi
