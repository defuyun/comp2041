#!/usr/bin/perl -w

$#ARGV == 0 or die $!;
$count = 0;

while($line = <STDIN>){
	@wc = $line =~ /$ARGV[0]/ig;
    $count += @wc;	
}

print "$ARGV[0] occured $count times\n";

