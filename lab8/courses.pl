#!/usr/bin/perl -w

$#ARGV == 0 or die $!;

%corss = ();

$line = `wget -q -O-  http://www.timetable.unsw.edu.au/current/$ARGV[0]KENS.html`;
@cors = $line =~ /$ARGV[0]\d{4}/g;
foreach $cors (@cors){
	$corss{$cors}++;
}

foreach $corss(sort keys %corss){
	print $corss,"\n";
}
