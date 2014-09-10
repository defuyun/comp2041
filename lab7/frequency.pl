#!/usr/bin/perl -w
$#ARGV == 0 or die $!;

my $count = 0;

foreach $file (glob "poets/*.txt"){
   $num_key = `perl count_word.pl $ARGV[0]<$file`;
   chomp($num_key);
   $num_key = (split / /,$num_key)[2];
   $count += $num_key;
   print "$num_key\/";

   $num_total = `perl total_word.pl<$file`;
   chomp($num_total);
   printf "%6d \= ",$num_total;
   $percentage = $num_key*1.0/$num_total;
   printf "%0.9lf ",$percentage;

   $file =~ s/poets\///;
   $file =~ s/\.txt//;
   print "$file\n"
}
