#!/usr/bin/perl

$#ARGV+1 == 2 or die "Usage: $0";
$ARGV[0] =~ /^[0-9]+/ or die "Usage: $0";

foreach $a (1..$ARGV[0]){
	print $ARGV[1],"\n";
}
