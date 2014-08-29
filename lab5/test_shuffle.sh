#!/usr/bin/sh 

echo "testing input:\n0 1 2 3 4 5 6 7 8 9";echo "shuffle output:"
i=0;while test $i -lt 10;do echo $i;i=$((i+1));done|perl shuffle.pl\
|egrep -o "^[0-9]+"|tr "\n" " "|tee /dev/tty|\
(read new;if test "$new" != '0 1 2 3 4 5 6 7 8 9';then echo "\nsuccess";fi)
