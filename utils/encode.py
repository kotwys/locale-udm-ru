#!/usr/bin/env python3

import sys

def encode(char: str) -> str:
    """
    Encodes characters in Unicode for locale files.

    Arguments:
        char - single character to encode.

    Returns string in form <U{code}>
    """
    code = ord(char)
    if code >= 255:
        return '<U{:04X}>'.format(code)
    else:
        return char

if __name__ == '__main__':
    try:
        for line in sys.stdin:
            new_line = ''.join(map(encode, line))
            sys.stdout.write(new_line)
    except BrokenPipeError as e:
        exit(0)
