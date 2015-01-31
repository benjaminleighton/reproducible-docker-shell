#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
rm -f current
touch current
#the first line we want to read is line one 
NEXT_LINE_COUNTER=1
LAST_DIRECTORY="/"
while true    
do
   ATIME=`stat -c %Z ./current`
   if [[ "$ATIME" != "$LTIME" ]]
   then    
       cp current current.temp

       #Read the commands in the history and write new commands to other files
       LINE_COUNTER=1
       while read -r line
       do
	       #if the next expected line is less than or equal to the current line then this is a new line
	       if [ $NEXT_LINE_COUNTER -le $LINE_COUNTER ]
	       then
		       LINE_ARRAY=($line)
		       FIRST_WORD=${LINE_ARRAY[0]}
		       REST_ARRAY=${LINE_ARRAY[@]:1}
		       REST=${REST_ARRAY[*]}   
		       if [ $FIRST_WORD == 'WORKDIR' ]
		       then
			       CURRENT_DIRECTORY=$REST 
			       if [ $CURRENT_DIRECTORY != $LAST_DIRECTORY ]
			       then
				       echo "WORKDIR $CURRENT_DIRECTORY" >> $1 
			       fi
			       LAST_DIRECTORY=$CURRENT_DIRECTORY
		       elif [ $FIRST_WORD == 'RUN' ]
		       then
			       echo "$line" >> $1 
		       elif [ $FIRST_WORD == 'SHA' ]
		       then
			       #Do same thing in test container
			       cp $1 Dockerfile
		       	       docker build -q -t temptest . > /dev/null
			       docker run -it -v $DIR:/host temptest /bin/bash -c "sha1sum $REST > /host/sha1sum"  > /dev/null
			       rm Dockerfile
		       fi
	       fi    
	       #keep incrementing the line counter for every line 
	       LINE_COUNTER=$((LINE_COUNTER + 1))
       done < current.temp
       #the next line counter will be one greater than the current number of lines read (increment happened at the end of the loop
       NEXT_LINE_COUNTER=$LINE_COUNTER
       LTIME=$ATIME
   fi
   sleep 0.5 
done
