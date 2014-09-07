#!/usr/bin/sh

temp = "out_$$"
temp2 = "out2_$$"
echo "Running /usr/bin/paste -s $1"
paste -s $1 > $temp;

echo "Running ./paste.pl $1"
perl paste.pl $1 > $temp2;

echo "Running diff on output"
if diff $temp $temp2
then
	echo "Test succeeded - output of ./paste.pl matched /usr/bin/paste"
fi
