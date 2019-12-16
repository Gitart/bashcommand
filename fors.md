#!/bin/sh

# This script depends on imagemagick being installed

for imgsize in 16 32 64 128 4567 38489 49004
do
	echo $imgsize

done



## now loop through the above array
for i in element1 element2 element3
do
   echo "$i"
   # or do whatever with individual element of the array
done


for i in $( ls ); do
            echo File: $i
done


 for i in `seq 1 10`;
 do
     echo $i
 done

            
