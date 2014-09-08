#!/usr/bin/perl -w

$lenght = 0;
while($word = <>){
	@words = $word =~ /[a-z]+/gi or die;
	$lenght += @words;
}
print $lenght,"\n";
