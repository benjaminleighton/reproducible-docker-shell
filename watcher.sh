#!/bin/bash
rm -f current
touch current
#the first line we want to read is line one 
NEXT_LINE_COUNTER=1
LAST_DIRECTORY="/"
while true    
do
   ATIME=`stat -c %Z ./.bash_history`
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
		       LINE_ARRAY=($LINE)
		       FIRST_WORD={$LINE_ARRAY[0]}
		       REST_ARRAY=${LINE_ARRAY[@]:1}
		       REST=${REST_ARRAY[*]}   
		       if [ $FIRST_WORD -eq 'WORKDIR' ]
		       then
			       CURRENT_DIRECTORY=$REST 
			       if [ $CURRENT_DIRECTORY -eq $LAST_DIRECTORY  ]
			       then
				       echo "WORKDIR $CURRENT_DIRECTORY" >> $1 

			       fi
			       LAST_DIRECTORY=$rest
		       elif [ $FIRST_WORD -eq 'CMD' ]
		       then
			       echo "RUN $line" >> $1 
		       fi
	       fi    
	       #keep incrementing the line counter for every line 
	       LINE_COUNTER=$((LINE_COUNTER + 1))
       done < .bash_history.temp 
       #the next line counter will be one greater than the current number of lines read (increment happened at the end of the loop
       NEXT_LINE_COUNTER=$LINE_COUNTER
       LTIME=$ATIME
   fi
   sleep 0.5 
done
