#!bin/usr/sh

i=0;while test $i -lt 10;do echo $(($RANDOM%10));i=$((i+1));done >> "test_file_$$";
