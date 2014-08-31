#!/usr/bin/perl -w

@files = ();
$line = 10;
foreach $arg (@ARGV) {
	if ($arg eq "--version") {
		print "$0: version 0.1\n";
		exit(0);
	} 
	elsif($arg =~ /^-[0-9]+$/) {
		$line = $arg;
		$line =~ s/-//g;
	}
	else {
		push @files, $arg;
	}
}

foreach $f (@files) {
	open(F,"<$f") or die "$0: Can't open $f: $!\n";
	while(<F>){
		$num_line = $.
	}
	seek F,0,0;
	if(@files > 1){
		print "==> $f <==\n"
	}
	$iter = 0;
	while($p = <F>){
		if($iter++ >= ($num_line - $line)){
			print $p;
		}
	}
	close(F);
}

if (@ARGV == 0){
	$i = 0;
	while($p = <STDIN>){
		$arr[$i] = $p;
		$i++;
	}
	$c = $i-10;
	while($c < $i){
		print $arr[$c];
		$c++;
	}
}
