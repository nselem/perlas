##Application 1: Converting GI numbers to accession numbers

##Goal: Starting with a list of nucleotide GI numbers, prepare a set of corresponding accession numbers.

###Solution: Use EFetch with &retttype=acc
####Input: $gi_list – comma-delimited list of GI numbers

####Output: List of accession numbers.

use LWP::Simple;
# my $acc_list='numero,numero2,numero3';
###@acc_array = split(/,/, $acc_list);
my @acc_array;

#atpD, JX889733 to JX889821; 
#for ($i=889733;$i<=889821;$i++){
#	my $id="JX"."$i";
#	push(@acc_array,$id);
#	}

#dnaK, JX889911 to JX889999; 
#for ($i=889911;$i<=889999;$i++){
#	my $id="JX"."$i";
#	push(@acc_array,$id);
#	}

#gyrB, JX890000 to JX890088; 
#for ($i=890000;$i<=890088;$i++){
#	my $id="JX"."$i";
#	push(@acc_array,$id);
#	}

#ppk,  JX890089 to JX890177;
#for ($i=890089;$i<=890177;$i++){
#	my $id="JX"."$i";
#	push(@acc_array,$id);
#	}

#recA, JX890178 to JX890266;
#for ($i=890178;$i<=890266;$i++){
#	my $id="JX"."$i";
#	push(@acc_array,$id);
#	}

#rpoB, JX889822 to JX889910.
for ($i=889822;$i<=889910;$i++){
	my $id="JX"."$i";
	push(@acc_array,$id);
	}

foreach $number (@acc_array){
	#assemble the URL
	$base = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
	#$url = $base . "efetch.fcgi?db=protein&id=$number&rettype=fasta";	
	$url = $base . "efetch.fcgi?db=Nucleotide&id=$number&rettype=fasta";
	#$url = $base . "efetch.fcgi?db=taxonomy&id=$number&rettype=seqid";

	#post the URL
	$output = get($url);
	print "$output";
	### Notes: The order of the accessions in the output will be the same order as the GI numbers in $gi_list.
}
