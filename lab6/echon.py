#!/usr/bin/python

import sys
import re

if len(sys.argv)!=3:
	sys.exit("Usage: " + sys.argv[0])

if re.search(r"^[0-9]+$",sys.argv[1]) is None:	
	sys.exit("Usage: " + sys.argv[0]);

i = 0;
while i < int(sys.argv[1]):
	print sys.argv[2];
	i = i+1;
