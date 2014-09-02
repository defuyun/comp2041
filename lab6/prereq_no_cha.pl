#!/usr/bin/perl -w

$url1 = "http://www.handbook.unsw.edu.au/postgraduate/courses/2014/$ARGV[0].html";
$url2 = "http://www.handbook.unsw.edu.au/undergraduate/courses/2014/$ARGV[0].html";
open F, "wget -q -O- $url2 $url1|" or die;
while ($line = <F>) {
	if ($line =~ /.*Prerequisite:.*/){
		$line = (split /<p>/,$line)[1];
		@all = $line =~ /[A-Z]{4}[0-9]{4}/g;
		foreach (@all){
			print $_,"\n";
		}
	}
}
