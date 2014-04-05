#!/bin/bash
instance='ubuntu'
while :
do
  shortinstance=${instance:0:10}
  MY_PROMPT="Docker@$shortinstance$ "
  echo -n "$MY_PROMPT"
  read line
  #echo sudo docker run $instance $line
  instance=$(sudo docker run -d $instance $line) 
  sudo docker wait $instance > /dev/null
  sudo docker logs $instance 
  instance=$(sudo docker commit $instance)
done

exit 0
