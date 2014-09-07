#!/usr/bin/perl -w

foreach (@ARGV) {
	open F, "<$_" or die $!;
	chomp($line = <F>);
	print $line;
	while ($line = <F>) {
		chomp $line;
		print "\t$line";
	}
	close (F);
	print "\n";
}
