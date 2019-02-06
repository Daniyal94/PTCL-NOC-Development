# PTCL-NOC-Development
Perl Script
#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Std;
use Net::SMTP;


##########	Opening LOG file
open(my $log, ">>", "E:\\test1.log") or die "Can't open my.log: $!";
print $log "test\n";

##########	Declaring Variables	
my ($error_msg,$error_code,$seibel_tt_id,$state,$description,$ne_id,$noc_tt_id) = (" "); 
my (@report,@send_list);
my ($mailto,$cc,$subject);
my ($indx,$email,$email1);


########        COMPARISON OF TIME
my $path = 'c:\\Program Files\\TelAlert';
my $filename = 'abcdefg.txt';
my $b = 60;
my $mod = (stat "$path/$filename")[9];
my $startTime = time();
my $comparison = $startTime - $mod;
my $difference = $comparison/$b;
print "System Time is = ", scalar localtime $startTime, "\n";
print "File Last Modified Time is = ", scalar localtime $mod, "\n";
print "Difference between File Last Modified Time and System Time is = ", $difference,"minutes.\n";
