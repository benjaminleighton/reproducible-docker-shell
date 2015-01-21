#!/bin/bash
#the first line we want to read is line one 
NEXT_LINE_COUNTER=1
while true    
do
   ATIME=`stat -c %Z ./.bash_history`
   if [[ "$ATIME" != "$LTIME" ]]
   then    
       cp .bash_history .bash_history.temp 
       LINE_COUNTER=1
       while read -r line
       do
	       #if the next expected line is less than or equal to the current line then this is a new line
	       if [ $NEXT_LINE_COUNTER -le $LINE_COUNTER ]
	       then
		       echo "RUN $line" >> $1 
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
