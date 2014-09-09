#!/usr/bin/perl -w
my $count = 0;

foreach $file (glob "poets/*.txt"){
   $num_key = `perl count_word.pl $ARGV[0]<$file`;
   chomp($num_key);
   $num_key = (split / /,$num_key)[2];
   $count += $num_key;
   print "$num_key\n";
}
print $count,"\n";
