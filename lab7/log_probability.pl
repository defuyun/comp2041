#!/usr/bin/perl -w
$#ARGV == 0 or die $!;

my $count = 0;

foreach $file (glob "poets/*.txt"){
   $num_key = `perl count_word.pl $ARGV[0]<$file`;
   chomp($num_key);
   $num_key = (split / /,$num_key)[2];

   $num_total = `perl total_words.pl<$file`;
   chomp($num_total);
   
   $file =~ s/poets\///;
   $file =~ s/\.txt//;

   $log_p = log(($num_key+1)/$num_total); 

   printf "log((%d+1)/%6d) = %8.4f %s\n",$num_key,$num_total,$log_p,$file;
}
