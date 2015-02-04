#!/bin/bash
set -o history -o histexpand
LAST_COMMAND=$(fc -nl -1)
if [ $? = 0 ]
then
	LINE_ARRAY=($LAST_COMMAND)
	FIRST_WORD=${LINE_ARRAY[0]}
	REST_ARRAY=${LINE_ARRAY[@]:1}
        REST=${REST_ARRAY[*]}   
        if [ $FIRST_WORD == 'SHA' ]
        then
		echo "Checking Workflow Please Wait..."   
		echo $LAST_COMMAND >> /monitor/current 
		SHA_RESULT=$(sha1sum $REST)
		echo "Result in this container is $SHA_RESULT"
		while [ ! -f /monitor/sha1sum ]
		do
		  sleep 1 
		done
		SHA_RESULT_REPRODUCED=$(cat /monitor/sha1sum)
		rm /monitor/sha1sum
		echo "Result in reproduced container is $SHA_RESULT_REPRODUCED" 
        	if [ "$SHA_RESULT" == "$SHA_RESULT_REPRODUCED" ]
		then
			echo "Result Sucessfully Reproduced"
		else
			echo "Failed to Sucessfully Reproduce Result"
		fi
	else
		echo "RUN "$LAST_COMMAND >> /monitor/current 
	fi 
fi
CURRENT_DIR=$(pwd | sed 's/^ *//')
echo "WORKDIR "$CURRENT_DIR >> /monitor/current 
