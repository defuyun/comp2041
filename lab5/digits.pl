#!/usr/bin/perl -w

while ($v = <STDIN>){
	$v =~  s/[0-4]/</g;
	$v =~  s/[6-9]/>/g;
	print $v;
}

