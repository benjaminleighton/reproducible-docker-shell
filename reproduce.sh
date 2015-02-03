#!/bin/bash
killtree() {
    local _pid=$1
    local _sig=9
    for _child in $(ps -o pid --no-headers --ppid ${_pid}); do
        killtree ${_child} ${_sig}
    done
    kill -${_sig} ${_pid} > /dev/null 2>&1
}
>| .bash_history
DATE_TIME=`date +"%d-%m-%y_%H-%M-%S"`
DOCKER_FILE="Dockerfile_$DATE_TIME"
touch $DOCKER_FILE 
echo "FROM ubuntu" >> $DOCKER_FILE 
./watcher.sh $DOCKER_FILE & 
./filewatcher.sh $DOCKER_FILE & 
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
docker run -it -e "HISTFILE=/host/.bash_history" -e "PROMPT_COMMAND=. /monitor/track.sh" -v $DIR/monitor:/monitor -v $DIR/shared:/shared ubuntu /bin/bash
rm -f current
rm -f current.temp
killtree $$
