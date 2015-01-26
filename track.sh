#!/bin/bash
set -o history -o histexpand
LAST_COMMAND=$(fc -nl -1)
if [ $? = 0 ]
then
	echo "RUN "$LAST_COMMAND >> /host/current 
fi
CURRENT_DIR=$(pwd | sed 's/^ *//')
echo "WORKDIR "$CURRENT_DIR >> /host/current 
