#!/usr/bin/perl -w

my @courses;

$recursion = 0;
foreach (@ARGV){
	if($_ eq "-r"){
		$recursion = 1;
	}else{
		&prereq($_);
	}
}

foreach(sort @courses){
	print $_,"\n";
}

sub prereq{
	$url1 = "http://www.handbook.unsw.edu.au/postgraduate/courses/2014/$_[0].html";
	$url2 = "http://www.handbook.unsw.edu.au/undergraduate/courses/2014/$_[0].html";

	open my $F, "wget -q -O- $url2 $url1|" or die;	
	while ($line = <$F>) {
   		if ($line =~ /.*Prerequisite:.*/){
      		$line = (split /<p>/,$line)[1];	
			my @all = $line =~ /[A-Z]{4}[0-9]{4}/g;
       		foreach (@all){
     	    	if(&added($_) == 0){
					push @courses,$_;
					if($recursion == 1){
						&prereq($_);
					}
				}
			}	
	    }
	}
}

sub added{
	my $found = 0;
	foreach(@courses){
		if($_ eq $_[0]){
			$found = 1;
		}
	}
	return $found;
}
