#!/usr/bin/perl -w
$#ARGV == 1 or die $!;

#store the course each zid is doing
%zid_course = ();

#store the name of the course
%code_name = ();

#store student doing the course
%code_zid = ();

#store student name for each zid
%zid_name = ();

#a hash containing courses that actually appear
%zid_code_course = ();

#c is abbrev for course
#z is abbrev for zid

open FILE, "<$ARGV[0]" or die $!; #student file
open CNAME,"<$ARGV[1]" or die $!; #course name file

# create the hash table for 
# 1. the name attached to each zid
# 2. the course each zid is doing
foreach $line (<FILE>)
{
	($course,$zid,$name) = split /\|/, $line;
    $name =~ s/\s+$//g; #remove trailing whitespace
    $zid_name{$zid} = $name;
    $zid_course{$zid}{$course}++;
}

# create the hash table for course code
foreach $line (<CNAME>)
{
    $line =~ /(^\w{4}\d{4}) (.+)/;
    $code = $1; # the cours code
    $cname = $2;# the course name 
    $code_name{$code} = $cname;
}

# create hash table for what people are doing what courses
foreach $z (sort keys %zid_course)
{
    foreach $c (sort keys %{$zid_course{$z}}){
       $code_zid{$c}{$z}++;
       $zid_code_course{$c} = $code_name{$c};
    }
}
close FILE;
close CNAME;

#creating the course page
foreach $c (sort keys %code_zid)
{
    open FILE, ">html/$c\.html" or die $!;
    my $content = &write_course($c);
    print FILE $content;
}
close FILE;

#creating the student page
foreach $z (sort keys %zid_course)
{
    open FILE, ">html/$z\.html" or die $!;
    my $content = &write_zid($z);
    print FILE $content; 
}
close FILE;

#create index page
open FILE, ">html/index\.html" or die $!;
$content = &write_index;
print FILE $content;
close FILE;

#========================================  SUB FUNCTIONS ===============================================#
sub write_course
{
    my $ccode = $_[0];
    $string = "<html>\n".
              "<head><title>Students Enrolled in $ccode $code_name{$ccode}</title></head>\n".
              "<h2>Students Enrolled in $ccode $code_name{$ccode}</h2>\n".
              "<body>\n".
              "<ul>\n";
   foreach $z (sort keys %{$code_zid{$ccode}}){
      $string .= "<li><a href = \"$z\.html\">$z $zid_name{$z}</a>\n";
   }
   $string .= "</ul>\n<a href = \"index\.html\">Back to Index</a>\n".
              "<hr>\n<small>Created on Tuesday 24 September  22:39:23 EST 2014 by Carl Liu ".
              "as a COMP2041/COMP9041 lab exercise \n</body>\n".
              "</html>\n";

   return $string;
 
}

sub write_zid
{
   my $zzid = $_[0];
   $string = "<html>\n".
			 "<head><title>Courses taken by $zzid $zid_name{$zzid}</title></head>\n".
             "<h2>Courses taken by $zzid $zid_name{$zzid}</h2>\n".
             "<body>\n".
             "<ul>\n";
   foreach $c (sort keys %{$zid_course{$zzid}}){
      $string .= "<li><a href=\"$c\.html\">$c $code_name{$c}</a>\n";
   }

   $string .= "</ul>\n".
              "<a href=\"index\.html\">Back to Index</a>\n".
              "<hr>".
              "<small>Created on Tuesday 24 September  22:39:22 EST 2014 by Carl Liu".
              " as a COMP2041/COMP9041 lab exercise\n".
              "</body>\n".
              "</html>\n";

   return $string;
}

sub write_index
{
    $string = "<html>\n".
              "<head><title>Index Page</title></head>\n".
              "<body>\n".
              "<h2>Index Page</h2>\n".
              "<h2>All Courses</h2>\n".
              "<ul>\n";
   foreach $c (sort keys %zid_code_course){
      $string .= "<li><a href=\"$c\.html\">$c $zid_code_course{$c}</a>\n";
   }

   $string .= "</ul>\n".
              "<h2>All Students</h2>\n".
              "<ul>\n";

   foreach $z (sort keys %zid_name){
     $string .= "<li><a href = \"$z\.html\">$z $zid_name{$z}</a>\n";
   }

   $string .= "</ul>".
              "<hr>".
              "<small>Created on Tuesday 24 September  22:39:20 EST 2014 by Carl Liu ".
              "as a COMP2041/COMP9041 lab exercise\n".
              "</body>\n".
              "</html>\n";
   return $string; 
}
