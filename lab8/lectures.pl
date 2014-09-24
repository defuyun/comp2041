#!/usr/bin/perl -w

#check valid input
$#ARGV >= 0 or die $!;

#a counter for the repeat_check array
$c = 0;

#used to check if the captured time has already been captured before e.g. there may be 2 1917 Mon 11 - 13
@repeat_check = ();

#a hash to store the timetable used in -t
%timetable = ();
$flag = 0;

foreach $url (@ARGV){
   if ($url eq "-d"){
     $flag = 1;
     next;
   }elsif($url eq "-t"){
     $flag = 2;
     next;
   }

   @line = `wget -q -O- http://www.timetable.unsw.edu.au/current/$url.html`;
   chomp @line;

   for ($i = 0;$i < scalar(@line);$i++){
      if ($line[$i] =~  /<td class="data"><a href="#(S1|S2|X1|X2)-\d+">Lecture<\/a><\/td>/ && $line[$i+6] =~ /Weeks/){ #finds the Lecture line and read 6 lines after (which is usually the time)
         $line[$i+6] =~ s/<.*?>//g; #remove tags
         $line[$i+6] =~ s/\s+/ /g;  #remove whitespace
         $line[$i] =~ /(S1|S2|X1|X2)/;
         $sem = $&;
         
         $courses = $url.$line[$i+6].$sem; 
         if(&exist($courses)){ #check if this time has already been captured
               next;
         }
         $repeat_check[$c] = $courses;$c++;
		 if($flag == 0){
            print $url,": ",$sem,$line[$i+6],"\n";
         }elsif($flag == 1){
            @time = split ', ',$line[$i+6];
		    foreach $time (@time){
               $time =~ s/^\s//; #removes the leading whitespace of the first time
                                 #split by , would remove the whitespace of the following time but wouldn't remove the first one
               $time =~ /(\w{3}) (\d+)/; # take the abbrev of the day and the starting time
               $day = $1;
               $t1 = $2;
               $time =~ /\- (\d+)/;#take the ending time
               $t2 = $1;
               while($t1 < $t2){
                  print $sem," ",$url," ",$day," ",$t1,"\n";
                  $t1++;
               }
            }
         }elsif($flag == 2){ 
            @time = split ', ',$line[$i+6];
		    foreach $time (@time){
               $time =~ s/^\s//;
               $time =~ /(\w{3}) (\d+)/;
               $day = $1;
               $t1 = $2;
               $time =~ /\- (\d+)/;
               $t2 = $1;
               $timetable{$sem}{$day}{$t1} += ($t2-$t1);#use a hash table to get sem day and time
               $sems{$sem}++;#create a hash table for sem because wwe won't always get all the semesters
            }
         }
      }

   }
}
if($flag == 2){
   @dayst = ("Mon","Tue","Wed","Thu","Fri");
   @timet = ('09',"10","11","12","13","14","15","16","17","18","19","20") ;
   foreach $sem (sort keys %sems){
      print "$sem\t\tMon\tTue\tWed\tThu\tFri\n";#print out the days
      foreach $timer (@timet){
         print "$timer:00\t";#print out the time
         foreach $day (@dayst){
            print "\t";
            if($timetable{$sem}{$day}{$timer}){ #check if there is class in the time period 
                printf "%2d",$timetable{$sem}{$day}{$timer};
            }
         }
         print "\n";
      }
   }
}

sub exist
{
   my $intime;
   foreach $intime (@repeat_check){
      if($intime eq $_[0]){
         return 1;
      }
   }
   return 0;
}
