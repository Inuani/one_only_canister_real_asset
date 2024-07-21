from Crypto.Cipher import AES
from Crypto.Hash import CMAC
from Crypto.Hash import SHA256
import binascii
import argparse
import hashlib

parser = argparse.ArgumentParser(
                    prog='HTML to Motoko',
                    description='Convert an HTML project folder to Motoko',
                    epilog='Enjoy the program! :)')


parser.add_argument('-k', '--key', required=True, type=str, nargs='?', help='The key to use for the SDMMAC')
parser.add_argument('-u', '--uid', required=True, type=str, nargs='?', help='The UID to use for the SDMMAC')
parser.add_argument('-d', '--destination', required=True, type=str, nargs='?', help='The root of the final motoko project')
parser.add_argument('-c', '--count', default=42000, type=int, nargs='?', help='The count value')

args = parser.parse_args()
from Crypto.Cipher import AES
from Crypto.Hash import CMAC
import binascii

def decode(hex_str):
    return binascii.unhexlify(hex_str)

def encode(bytes_str):
    return binascii.hexlify(bytes_str).decode().upper()

def SDMMAC(count, uid, mKey):

    cmac = CMAC.new(decode(mKey), ciphermod=AES)

    sv1 = "3CC300010080" + uid + count
    cmac.update(decode(sv1))

    k1 = encode(cmac.digest())

    fullSDMMAC = CMAC.new(decode(k1), ciphermod=AES)
    fullSDMMAC.update(b'')  # Empty update to mimic the JavaScript code

    fullString = encode(fullSDMMAC.digest())

    s1 = fullString[2:4]
    s2 = fullString[6:8]
    s3 = fullString[10:12]
    s4 = fullString[14:16]
    s5 = fullString[18:20]
    s6 = fullString[22:24]
    s7 = fullString[26:28]
    s8 = fullString[30:32]

    raw_result = (s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8).upper()
    
    # Uncomment if you need SHA-256 hash of the result
    # sha256 = SHA256.new()
    # sha256.update(raw_result.encode('utf-8'))
    # result = encode(sha256.digest())
    return raw_result

def int_to_little_endian_3byte_hex(num):
    # Convert the integer to a little-endian byte representation
    hex_string = format(num, '06x')  # 6 hex digits (3 bytes) wide
    # Split the hex string into 2-character chunks and reverse them
    little_endian_hex = ''.join(reversed([hex_string[i:i+2] for i in range(0, len(hex_string), 2)]))
    return little_endian_hex


def generate_motoko(count, uid, key):
    return f"""
module SDMMAC {"{"}
    public func get_cmacs() : [Text] {"{"}
    return {str([ hashlib.sha256(SDMMAC(int_to_little_endian_3byte_hex(i), uid, key).encode('utf-8')).hexdigest() for i in range(1, count) ]).replace(" ", "").replace("'", '"')};
     {"}"};
{"}"};
"""
    


def main():
    if len(args.key) != 32:
        print("Key must be 32 characters long")
        return

    # if len(args.uid) != 8:
    #     print("UID must be 8 characters long")
    #     return

    # try:
    with open(args.destination, "w") as file:
        file.write(generate_motoko(args.count, args.uid, args.key))
    # except Exception as e:
    #     print(f"Error writing to file : {args.destination}, {e}")

if __name__ == "__main__":
    main()