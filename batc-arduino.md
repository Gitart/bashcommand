## Sample
https://www.voss.earth/tonuino/

```
#!/bin/bash

for dir in *; do
    if [ -d "${dir}" ]; then
    
    MP3=`ls "$dir/"*mp3 | head -n 1`
    TRCK=`id3v2 -l "$MP3" | grep TRCK | sed -e 's/.*: .*\///g'`
    ACT=`ls -l "$dir/"*.mp3 | wc -l`
    
    string=""
    cd "$dir"
    for i in `seq 1 $TRCK`; do
	FILE=`ls  $i\ -\ *mp3`
	string="$string|$FILE"
    done

    string=${string:1}

    ffmpeg -i "concat:$string" -acodec libmp3lame -b:a 128k "../$dir.mp3"
#    ffmpeg -i "concat:$string" -acodec copy "../$dir.mp3"

    cd ..
    fi
done
```
Alternativ könnte es auch so klappen (einstellige Tracks müssen mit einer führenden 0 benannt sein (01,02,03, …). Eventuell müsst ihr mit dem Suchmuster „*$i.*mp3“ etwas herum experimentieren:

```
#!/bin/bash

for dir in *; do
    if [ -d "${dir}" ]; then
    
    ACT=`ls -l "$dir/"*.mp3 | wc -l`
    
    string=""
    cd "$dir"
    for i in `seq 1 $ACT`; do
	i=$(printf "%02d" $i)
	FILE=`ls *$i.*mp3`
	string="$string|$FILE"
    done

    string=${string:1}

    ffmpeg -i "concat:$string" -acodec libmp3lame -b:a 128k "../$dir.mp3"

    cd ..
    fi
done
```
