#!/bin/bash
set -o history -o histexpand
LAST_COMMAND=$(fc -nl -1)
echo "CMD "$LAST_COMMAND >> /current 
CURRENT_DIR=$(pwd | sed 's/^ *//')
echo "WORKDIR "$CURRENT_DIR >> /current 
