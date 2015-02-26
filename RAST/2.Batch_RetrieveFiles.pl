

###############################################################
############   Declare Functions  ############################
###############################################################
use LWP::Simple;

my %ORGS;
sub ReadFile;
sub RetrieveGenome;


###############################################################
############		Main     ##############################
%ORGS=ReadFile;
foreach my $ID (keys %ORGS){
	print"Retrieving RAST job $ID corresponding to the org:\n";
	#$OrgName=$ORGS{$ID};
	RetrieveGenome($ID);
}
#ReadID;

###############################################################
###############################################################

sub ReadFile{
	open FILE,  "$ARGV[0]" or die "I can not open the input FILE\n";
	my %orgs;
	while (my $line=<FILE>){
		chomp $line;
		print "$line\n";
		my @content= split(/\t/,$line);
		print "$content[0]=>$content[1]=>$content[2]\n";
		#print"$content[0] => $content[1]\n";	
		$orgs{$content[0]}=$content[1];
		#$orgs{$content[0]}=($content[1],$content[2]);
		#print"$content[0]=>$ORGS{$content[0]}\n\n";
		}
	return %orgs;
}

###############################################################
##2	Upload Genomes to RAST using SVR svr_submit_RAST_job.pl and my account
sub RetrieveGenome{
	my $ID=shift;
	`svr_retrieve_RAST_job nselem35 q8Vf6ib $ID table_txt > $ID.cvs`;
}
