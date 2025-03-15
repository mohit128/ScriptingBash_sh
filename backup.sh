#!/bin/bash



curr=$(pwd)
d=$(date +%Y%m%d)
add="${curr}_${d}"

echo "$add"

mkdir $add

