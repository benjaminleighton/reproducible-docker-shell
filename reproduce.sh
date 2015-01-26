#!/bin/bash
>| .bash_history
DATE_TIME=`date +"%d-%m-%y_%H-%M-%S"`
DOCKER_FILE="Dockerfile_$DATE_TIME"
touch $DOCKER_FILE 
echo "FROM ubuntu" >> $DOCKER_FILE 
./watcher.sh $DOCKER_FILE & 
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
docker run -it -p 443:8888 -e "HISTFILE=/host/.bash_history" -e "PROMPT_COMMAND=. /host/track.sh" -v $DIR:/host ubuntu /bin/bash
pkill -P $$
rm -f current
rm -f current.temp
#"PROMPT_COMMAND=history -a && pwd >> /host/pwd.current"
