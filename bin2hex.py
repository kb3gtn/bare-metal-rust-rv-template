#!/usr/bin/env python3

import os
import sys
import struct 

def bin2hex(fd_bin_in, fd_hex_out):
    """ take file discriptors for a bin and hex files
        read binary convert to hex, 4 bytes per line. """
    data = fd_bin_in.read(4)
    while data:
        hex_str = data.hex()
        hex_str = hex_str[6:8]+hex_str[4:6]+hex_str[2:4]+hex_str[0:2]
        print(f"{hex_str}", file=fd_hex_out)
        data = fd_bin_in.read(4)

def main():
    if len(sys.argv) != 3:
        print("2 arguments required, input bin file and output hex file")
        sys.exit(-1)

    bin_fn = sys.argv[1]
    hex_fn = sys.argv[2]
    print(f"reading from {bin_fn}, outputing to {hex_fn}")
    fd_bin_in = open(bin_fn, "rb")
    fd_hex_out = open(hex_fn, "w")

    bin2hex(fd_bin_in, fd_hex_out)


if __name__ == "__main__":
    main()
