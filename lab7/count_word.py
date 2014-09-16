#!/usr/bin/python

import sys;
import re;

if(len(sys.argv) != 2):
	sys.exit("Usage:");

count = 0;
for line in sys.stdin:
	words = re.split("\W",line);
	for word in words:
		if(word == sys.argv[1]):
			count += 1;
print sys.argv[1],"ocurred",count,"times"; 
