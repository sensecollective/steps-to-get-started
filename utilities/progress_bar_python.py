#!/usr/bin/env python3

# http://stackoverflow.com/questions/5598181/python-print-on-same-line#comment45568040_5598349

import time
import sys

def backspace(n):
    # print((b'\x08' * n).decode(), end='') # use \x08 char to go back
    x = '\r' * n
    print(x, end="", flush=True)            # use '\r' to go back

for i in range(101):                        # for 0 to 100
    s = str(i) + '%'                        # string for output
    print(s, end='')                        # just print and flush
    # sys.stdout.flush()                    # needed for flush when using \x08
    backspace(len(s))                       # back for n chars
    
    time.sleep(0.02)  
