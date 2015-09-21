#Renombrar arbol
use strict;
use warnings;

`rm RightNames.txt`;
open (NAMES,"NAMES.ids") or die "Couldn't open NAMES file $!";
open (SEQUENCE,"SalidaConcatenada.txt") or die "Couldn't open Concatenados file $!";
open (BAYES,">RightNames.txt") or die "Couldn't open RightNames file $!";

my %SEQUENCES;
my %NAMES;

#########################################################################

readNames(\%NAMES);
readSequence(\%SEQUENCES,\%NAMES);
for my $key(keys %SEQUENCES){
	print BAYES ">$key\n$SEQUENCES{$key}\n";
}
close NAMES;
close SEQUENCE;

##########################################################################
sub readNames{
my $refNAMES=shift;

foreach my $line (<NAMES>){
	chomp $line;
	my @st=split("\t",$line);
	my $org=$st[0];
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

	my $Org="";
	foreach my $line (<SEQUENCE>){
		chomp $line;
		if ($line=~m/>/){
			if (exists $refSEQUENCES->{$refNAMES->{$Org}}){
				$refSEQUENCES->{$refNAMES->{$Org}}="";
				}
			$Org=$line;
			$Org=~s/>org//;
			#print "¡$Org!\n";
			}
		else{#	
			$refSEQUENCES->{$refNAMES->{$Org}}.=$line;
			}
		}
	}


