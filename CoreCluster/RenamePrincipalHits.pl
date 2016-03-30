#Renombrar arbol
use strict;
use warnings;

`rm RightNamesPrincipalHits.txt`;
open (NAMES,"RAST.IDs") or die "Couldn't open NAMES file $!";
open (SEQUENCE,"PrincipalHits.muscle-gb") or die "Couldn't open PrincipalHits.muscle-gb file $!";
open (BAYES,">>RightNamesPrincipalHits.txt") or die "Couldn't open RightNamesPrincipalHits.txt file $!";

my %SEQUENCES;
my %NAMES;

#########################################################################

readNames(\%NAMES);
readSequence(\%SEQUENCES,\%NAMES);
close NAMES;
close SEQUENCE;
close BAYES;
##########################################################################
sub readNames{
my $refNAMES=shift;
my $count=1;
foreach my $line (<NAMES>){
	chomp $line;
	my @st=split("\t",$line);
	my $org=$count;
	$count++;
	my $name=$st[2];
	$name=~s/[)(,.-]=/_/g;
	$name=~s/\s/_/g;	
	$name=~s/__/_/g;
	$refNAMES->{$org}=$name;
	print "$org¡$refNAMES->{$org}!\n";
	}
}

sub readSequence{
	my $refSEQUENCES=shift;
	my $refNAMES=shift;

	my $Org="Empty";
	foreach my $line (<SEQUENCE>){
		chomp $line;
		print "LINE $line\n";
		if ($line=~m/>/){
			$Org=$line;
			my $peg="";
			if($Org=~/peg/){
				$Org=~s/peg_(\d*)//;
				$peg=$1;
				}
			$Org=~s/>_org//;

			$Org=~s/>_org//;
			print "¡$Org!\n";
			my $name=$refNAMES->{$Org}."_peg_".$peg."_org_"."$Org";
			print BAYES ">$name\n";
			}		
		else{#	
			print BAYES "$line\n";
			
			}
		}
	}
