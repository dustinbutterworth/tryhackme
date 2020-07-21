#!/usr/bin/env python3
import base64, binascii, os

hexkey = os.environ.get('HEXKEY')

encoded = base64.urlsafe_b64encode(binascii.a2b_hex(f'{hexkey}')).decode().replace('=','')

print(encoded)