#!/bin/bash
#FILES=./shared/*
#for f in $FILES
#do
#     echo "ADD ./shared/$f /shared/$f" >> $1 
#done
echo "ADD ./shared/ /shared/" >> $1 
#inotifywait -m ./shared -e create -e moved_to |
#while read path action file; do
#        echo "ADD ./shared/$file /shared/$file" >> $1 
#	# do something with the file
#done

