use strict;
use warnings;

my $file=$ARGV[0]; ##File with genome ids
my $fileNames=$ARGV[1]; ##File with genome ids

#print "Reading $file\n";
my %LIST;
my %NAMES;
my $ClusterSize=3; ##Gen number around

###################### Main ########################################
read_list($file,$fileNames,\%LIST,\%NAMES);

foreach my $gi (keys %LIST){
	my $gi_file=$LIST{$gi};
	#print "working on $gi on $gi_file\n";
	ContextArray($gi_file,$gi,\%NAMES);
}


#____________________________________________________________________________________________
sub ContextArray{
	my $orgs=shift;
	my $peg=shift;
	my $refNAMES=shift;	

	open(FILE,">$peg.input")or die "could not open $orgs.input file $!";
	my @CONTEXT;

	my ($hit0,$start0,$stop0,$dir0,$func0,$contig0)=getInfo($peg,$orgs);
	$CONTEXT[0]=[$hit0,$start0,$stop0,$dir0,$func0];
	print FILE "$CONTEXT[0][1]\t$CONTEXT[0][2]\t$CONTEXT[0][3]\t1\t$refNAMES->{$peg}\t$CONTEXT[0][4]\t$CONTEXT[0][0]\n";
	my $count=1;	
	my @sp=split(/\./,$peg);
	my $genId=$sp[2];
	
	for (my $i=$genId-$ClusterSize;$i<$genId+$ClusterSize;$i++){
		my $neighbourId=$sp[0].".".$sp[1].".".$i;
		my ($hit,$start,$stop,$dir,$func,$contig)=getInfo($neighbourId,$orgs);
		my $color;
				
		if(!($hit eq "")){
			if($contig0 eq $contig){
				$CONTEXT[$count]=[$hit,$start,$stop,$dir,$func];
				}
			}
		$color=0;			
#		print "$peg, $org, $color \n";

		if ($contig0 eq $contig and $i!=$genId){
  			#print "$contig0 $contig\n";
			print FILE "$CONTEXT[$count][1]\t$CONTEXT[$count][2]\t$CONTEXT[$count][3]\t0\t$refNAMES->{$peg}\t$CONTEXT[$count][4]\t$CONTEXT[$count][0]\n";		
			$count++;
			}
		}
close FILE;
}





sub getInfo{
	my $gen=shift;
	my $file=shift;
	#print "Gen $gen\n";
	my @sp0=split(/\./,$gen);
	my $peg=$sp0[0].".".$sp0[1].".peg.".$sp0[2];
	#print "$peg\n";	
	
	my $Grep=`grep 'peg.$sp0[2]\t' $file.txt`;
	my @sp=split("\t",$Grep);
	my $contig=$sp[0];	
	my $hit=$sp[1];
	my $start=$sp[4];
	my $stop=$sp[5];
	my $dir=$sp[6];
	my $func=$sp[7];
	#print "hit $hit start $start stop $stop dir $dir func $func cont $contig\n\n";	
	return ($hit,$start,$stop,$dir,$func,$contig);
}


#_________________________________________________________________________________
sub read_list{  ## Get the files where the genes belongs
	my $file=shift;
	my $fileNames=shift;	
	my $refLIST=shift;
	my $refNAMES=shift;
	open (FILE, $file) or die "Could not open file $file \n $!";

	for my $line (<FILE>){
		chomp $line;
		#print "$line\n";
		my @sp=split(/\./,$line);

		if ($sp[0] and $sp[1]){
#			print("0:$sp[0],1:$sp[1],2:$sp[2]\n");
			my $genome=$sp[0].".".$sp[1];
			open (NAMES,$fileNames) or die "Could not open names file\n $!";
				for my $line2 (<NAMES>){
					chomp $line2;
					my @sp2=split(/\t/,$line2);
					if($line2=~/$genome/){
						#print "$line\t$sp2[0]\t$sp2[2]\n";
						$refLIST->{$line}=$sp2[0];
						$refNAMES->{$line}=$sp2[2];
						last;
					 	}
					close NAMES;
					}						
				}
			}
	close FILE;	
	}
