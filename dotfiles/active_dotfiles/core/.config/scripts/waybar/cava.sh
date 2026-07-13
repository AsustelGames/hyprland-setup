#!/usr/bin/env bash
# Script from
# https://github.com/ray-pH/waybar-cava/blob/main/cava.sh

trap '' PIPE


bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# write cava config
config_file="/tmp/waybar_cava_config"
echo "
[general]
bars = 8

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
" > $config_file

# read stdout from cava
cava -p $config_file | while read -r line; do
    printf '{"text":"%s","class":""}\n' "$(printf '%s' "$line" | sed "$dict")"
    #echo $line | sed $dict
done
