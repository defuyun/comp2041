#!/usr/bin/python

import sys

i = 1;
while i < len(sys.argv):
	F = open(sys.argv[i],"r");
	line = len(F.readlines());
	F.seek(0)
	j = 0;
	read = F.readline();
	while read:
		if j >= line - 10:
			print read,;
		j = j + 1;
		read = F.readline();
	F.close;i
	i = i+1;
