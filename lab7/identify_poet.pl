#!/usr/bin/perl -w

$#ARGV >= 0 or die $!;

%total_word_file = ();
%word_file_per_author = ();
%p_wc = ();
%total_log_count = ();

foreach my $file (glob "poets/*.txt"){
	open $F,$file or die $!;
	$total_w = `perl total_words.pl<$file`;
	$file =~ s/poets\///;
	$file =~ s/\.txt//;
	$total_word_file{$file} = $total_w;
	while($line = <$F>){
    @words = $line =~ /[a-z]+/gi;
	  foreach $word (@words){
			$word =~ tr/A-Z/a-z/;
	  	$word_file_per_author{$file}{$word}++;
	  }
	}
	
  foreach $word(keys %{$word_file_per_author{$file}}){
		$p_wc{$file}{$word} = log(($word_file_per_author{$file}{$word}+1)/$total_word_file{$file});
	}
}

$debug = 0;
foreach $files (@ARGV){
	if($files eq "-d"){
		$debug = 1;
		next;
	}
  open $H,$files or die $!;

	foreach $author(keys %p_wc){
	$total_log_count{$author} = 0;
		while($line = <$H>){
    	@words = $line =~ /[a-z]+/gi;
	  	foreach $word (@words){
				$word =~ tr/A-Z/a-z/;
				if($p_wc{$author}{$word}){
					$total_log_count{$author} += $p_wc{$author}{$word};
				}else{
					$total_log_count{$author} += log(1/$total_word_file{$author});
				}
	  	}
		}
		$least = $total_log_count{$author};
		$resemble = $author;
		seek $H,0,0;
	}

	foreach $author(keys %total_log_count){
		if($debug){
			printf ("%s: log_probability of %.1f for %s\n",$files,$total_log_count{$author},$author);
		}	
		if($total_log_count{$author} > $least){
			$least = $total_log_count{$author};
			$resemble = $author;
		}
	}
	printf("%s most resembles the work of %s(log-probablity=%.1f)\n",$files,$resemble,$least);	
}




