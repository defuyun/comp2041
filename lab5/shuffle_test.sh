#!/usr/bin/sh 

echo "testing input:
0 1 2 3 4 5 6 7 8 9";echo "shuffle output:"
i=0;while test $i -lt 10;do echo $i;i=$((i+1));done|perl shuffle.pl\
|egrep -o "^[0-9]+"|tr "\n" " "|tee /dev/tty|\
(read new;if test "$new" != '0 1 2 3 4 5 6 7 8 9';
then echo "
success";fi)

echo "test random position:";
temp_f="test_file_$$";
temp_o="test_perl_$$"
i=0;while test $i -lt 10;do echo $(($RANDOM%10));i=$((i+1));done >> "$temp_f";
cat $temp_f|egrep -o "^[0-9]+"|tr "\n" " ";
echo "
shuffle output:";
perl shuffle.pl < "$temp_f"> $temp_o;
cat $temp_o|egrep -o "^[0-9]+"|tr "\n" " "; 
if test `diff $temp_f $temp_o > /dev/null;echo $?` -ne 0
then
	echo "
succecss";
fi
rm $temp_f $temp_o;

echo "test reverse:";
i=10;while test $i -gt 0;do echo $i;i=$((i-1));done >> "$temp_f"; 
cat $temp_f|egrep -o "^[0-9]+"|tr "\n" " ";
echo "
shuffle output:";
perl shuffle.pl < "$temp_f"> $temp_o;
cat $temp_o|egrep -o "^[0-9]+"|tr "\n" " "; 
if test `diff $temp_f $temp_o > /dev/null;echo $?` -ne 0
then
	echo "
succecss";
fi
rm $temp_f $temp_o;

