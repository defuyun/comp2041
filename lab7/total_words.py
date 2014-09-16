#!/usr/bin/python

import sys;
import re;

count = 0;
for line in sys.stdin:
	words = re.split('\W',line);
	for word in words:
		if(re.match("\w",word)):
			count += 1;

print count,"words";
