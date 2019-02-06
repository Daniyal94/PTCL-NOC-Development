#!/usr/bin/perluse strict;use warnings;use Getopt::Std;use Net::SMTP;


##########	Opening LOG file
open(my $log, ">>", "E:\\test1.log") or die "Can't open my.log: $!";
print $log "test\n";

##########	Declaring Variables	
my ($error_msg,$error_code,$seibel_tt_id,$state,$description,$ne_id,$noc_tt_id) = (" "); 
my (@report,@send_list);
my ($mailto,$cc,$subject);
my ($indx,$email,$email1);

########        COMPARISON OF TIME
my $path = 'c:\\Program Files\\TelAlert';my $filename = 'abcdefg.txt';my $b = 60;
my $mod = (stat "$path/$filename")[9];my $startTime = time();my $comparison = $startTime - $mod;
my $difference = $comparison/$b;print "System Time is = ", scalar localtime $startTime, "\n";print "File Last Modified Time is = ", scalar localtime $mod, "\n";print "Difference between File Last Modified Time and System Time is = ", $difference,"minutes.\n";if ($difference >= 5) {	########	GENERATING EMAIL SUBJECT
$subject	= "SMS log is not updating.Kindly check asap";
$email   = "";
$email1  = "";
$mailto  = "";
$cc      = "";
$mailto = "rizwan.ismail\@ptcl.net.pk;faizan.puri\@ptcl.net.pk";

########	GENERATING EMAIL BODY#@report = "<font size=\"6\" color=\"maroon\"> <div align=\"center\">  <b> CRM Error Notification Test</b> </font> </div><hr /><font size=\"4\" color=\"blue\"><b></b></font><table border=\"1\"> <tr><td width=\"150\">NOC TT ID:</td><td width=\"800\">$noc_tt_id</td></tr> <tr><td width=\"150\">State:</td><td width=\"800\">$state</td></tr> <tr><td width=\"150\">Seibel TT ID:</td><td width=\"800\">$seibel_tt_id</td></tr> <tr><td width=\"150\">Error Code:</td><td width=\"800\">$error_code</td></tr> <tr><td width=\"150\">Error Message:</td><td width=\"800\">$error_msg</td></tr> <tr><td width=\"150\">DESCRIPTION:</td><td width=\"800\">$description</td></tr> <tr><td width=\"150\">Network Element ID:</td><td width=\"800\">$ne_id</td></tr> </table><hr /><br />";			
#############	PUSH EMAIL ID's to SEND LIST
$email	=	$mailto . ";" . $cc . ";123";

$indx = index($email,";");
while($indx != -1)
{#print $log "\ntest";
	$email1	=	substr($email,0,$indx);
	$email = substr($email,$indx+1);
	push(@send_list,$email1);
	$indx = index($email,";");
#print $log "\ntest1";
}


########	GENERATING EMAIL SIGNATURE						push(@report,"<font>This is an Automatically generated Email. Please do not reply.</font><br />");	
	##########	SENDING Email
	my $from = "nocoutage.ews\@ptcl.net.pk";
	my $smtp = Net::SMTP->new('10.254.170.165', Timeout => 60);
	$smtp->mail($from);
	foreach my $recipient (@send_list)
	{
		$smtp->recipient("$recipient");	
	}
	$smtp->data();
	$smtp->datasend("MIME-Version: 1.0\n");
	$smtp->datasend("Content-Type: text/html; charset=us-ascii\n");
	$smtp->datasend("From: NOC HKP<noc.notify\@ptcl.net.pk>\n");
	$smtp->datasend("To: $mailto\n");
	if ($cc ne "" && $cc ne "NIL")	{	$smtp->datasend("CC: $cc\n");		}
	$smtp->datasend("Subject: $subject");
	$smtp->datasend("\n");
	$smtp->datasend(@report);
	$smtp->datasend("\n");
	$smtp->dataend;
	$smtp->quit; 

############     GENERATE SMS

my @cmmnd = `telalertc -host 10.254.170.165 -cpl SMPP 923345380195 923438502028 -m "CRM integration is working fine"`;
print "\n ok @cmmnd";		}		else
{
my @cmmnd = `telalertc -host 10.254.170.165 -cpl SMPP 923345380195 923438502028 -m "CRM integration is not working fine"`;
print "\n oknot @cmmnd";
}	close ($log);	
exit(0);