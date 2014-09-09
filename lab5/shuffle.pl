#!/usr/bin/perl -w

$n = 0;
while($arr[$n] = <STDIN>){
	$n++;
}
pop @arr;

foreach (0..($n-1)){
	$index = rand(($n-1));
	($arr[$index],$arr[$_]) = ($arr[$_],$arr[$index]);
}

print @arr;
