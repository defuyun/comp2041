#!/usr/bin/perl -w

$#ARGV == 0 or die $!;
$count = 0;

while($line = <STDIN>){
	@wc = $line =~ /\W$ARGV[0]\W|^$ARGV[0]\W/gi;
    $count += @wc;	
}

print "$ARGV[0] occured $count times\n";
