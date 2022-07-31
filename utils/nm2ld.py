#!/usr/bin/env python3

import sys

for line in sys.stdin:
    a = line.strip().split()
    if a[1] != "T":
        continue
    if not a[2].startswith("furi"):
        continue
    print("%s = 0x%s;" % (a[2], a[0]))
