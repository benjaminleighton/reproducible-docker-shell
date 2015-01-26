#!/bin/bash
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
		       echo "First word $FIRST_WORD"
		       REST_ARRAY=${LINE_ARRAY[@]:1}
		       REST=${REST_ARRAY[*]}   
		       echo "Other words $REST"
		       echo "Again first word is $FIRST_WORD"
		       if [ $FIRST_WORD == 'WORKDIR' ]
		       then
		       	       echo "FIRST_WORD is apparently WORKDIR"
			       CURRENT_DIRECTORY=$REST 
			       echo "Current dir is $CURRENT_DIRECTORY"
			       echo "Last dir is $LAST_DIRECTORY"
			       if [ $CURRENT_DIRECTORY != $LAST_DIRECTORY ]
			       then
				       echo "WORKDIR $CURRENT_DIRECTORY" >> $1 

			       fi
			       LAST_DIRECTORY=$CURRENT_DIRECTORY
		       elif [ $FIRST_WORD == 'RUN' ]
		       then
			       echo "$line" >> $1 
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
