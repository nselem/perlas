#Renombrar arbol
use strict;
use warnings;

`rm RightNames.txt`;
open (NAMES,"RAST.IDs") or die "Couldn't open NAMES file $!";
open (SEQUENCE,"SalidaConcatenada.txt") or die "Couldn't open Concatenados file $!";
open (BAYES,">>RightNames.txt") or die "Couldn't open RightNames file $!";

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
#	$name=~s/\r//;
	$name=~s/[)(,.-]=/_/g;
	$name=~s/\s/_/g;	
	$name=~s/__/_/g;
	$refNAMES->{$org}=$name;
	print "$org -> $refNAMES->{$org}!\n";
	}
}

sub readSequence{
	my $refSEQUENCES=shift;
	my $refNAMES=shift;

	my $Org="Empty";
	foreach my $line (<SEQUENCE>){
		chomp $line;
		 if ($line=~m/>/){
                        $Org=$line;
			my $peg="";
			if ($Org=~/org(\d*)\_(\d*)$/){
                        	#$Org=~s/>org//;
                        	#$Org=~s/\_\d*$//;
				$Org=$1;
				$peg=$2;
                      		#$Org=~s/peg\_\d*$//;
                        	print "Org #$Org#\n";
				}
                        my $name=$refNAMES->{$Org}."_peg_"."$peg"."_org_"."$Org";
                        print BAYES ">$name\n";
                        }
                else{#  
                        print BAYES "$line\n";

                        }
chomp $line;
		}
	}
