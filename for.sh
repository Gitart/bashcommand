#!/bin/bash

for j in 0 1 2 3; do
    for i in 0 1 2 3; do
        for k in $(./mygo/bin/mc ls -r --json t****-node$i-st$j | jq -r 'select(.type != "folder")' | jq -r .key); do
            ./mygo/bin/mc cat t***-node$i-st$j/$k | md5sum;
        done
    done
done
