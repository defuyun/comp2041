#!/usr/bin/perl -w

$lenght = 0;
while($word = <STDIN>){
	@words = $word =~ /[a-z]+/gi;
	$lenght += @words;
}
print $lenght,"\n";
