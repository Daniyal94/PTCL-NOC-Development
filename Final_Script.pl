#!/usr/bin/perl


##########	Opening LOG file
open(my $log, ">>", "E:\\test1.log") or die "Can't open my.log: $!";
print $log "test\n";

##########	Declaring Variables	
my ($error_msg,$error_code,$seibel_tt_id,$state,$description,$ne_id,$noc_tt_id) = (" "); 
my (@report,@send_list);
my ($mailto,$cc,$subject);
my ($indx,$email,$email1);


my $path = 'c:\\Program Files\\TelAlert';
my $mod = (stat "$path/$filename")[9];
my $difference = $comparison/$b;
$subject	= "SMS log is not updating.Kindly check asap";
$email   = "";
$email1  = "";
$mailto  = "";
$cc      = "";
$mailto = "rizwan.ismail\@ptcl.net.pk;faizan.puri\@ptcl.net.pk";

########	GENERATING EMAIL BODY

$email	=	$mailto . ";" . $cc . ";123";

$indx = index($email,";");
while($indx != -1)
{
	$email1	=	substr($email,0,$indx);
	$email = substr($email,$indx+1);
	push(@send_list,$email1);
	$indx = index($email,";");
#print $log "\ntest1";
}



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
print "\n ok @cmmnd";		
{
my @cmmnd = `telalertc -host 10.254.170.165 -cpl SMPP 923345380195 923438502028 -m "CRM integration is not working fine"`;
print "\n oknot @cmmnd";
}
exit(0);