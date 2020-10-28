#!/usr/bin/env python
import requests
import json
from progress.spinner import MoonSpinner

def main():
    status_code = '200'
    path = ''
    thmflag=[]
    host = 'http://10.10.169.100:3000/'
    with MoonSpinner('Processing...') as bar:
        while path != 'end':
            response = requests.get(host + path)
            status_code = response.status_code
            json_response = response.json()
            path = str(json_response['next'])
            flag_value = str(json_response['value'])
            if flag_value != 'end':
                thmflag.append(flag_value)
            bar.next()
    finalflag = "".join(thmflag)
    print(f'Flag: {finalflag}')

if __name__ == '__main__':
    main()
