use strict;
    use warnings;
####################################################
######### Description  
####
####################################################
#Creates a list that compares functions between GENOMES
# Uses cvs files 

######### Subs and variables #######################

my @GENOMES=qx/ls *.bindings/; ## Read all cvs
my @ID=qx/ls *.txt/; ## Read all text files
my $N=scalar @GENOMES; ## Number of files
#my %GENOME_NAMES; ## Hash Genome_Id -> Organisms Name
my %FUNC;
my @functions;

sub readOrganisms;
sub CountFunctions;
sub headers;
sub Output;

####################################################

####################################################
#################################
###### Main program
####################################################

my %GENOME_NAMES=readOrganisms(@ID); ##Read txt files and fill Hash Genome_Id -> Organisms Name
#for my $key (keys %GENOME_NAMES){print "$key->$GENOME_NAMES{$key}\n";}
%FUNC=CountFunctions($N,@GENOMES);
#for my $key (keys %FUNC){print "$key->$FUNC{$key}[0]\t$FUNC{$key}[1]\t$FUNC{$key}[2]\n";}
headers(\%GENOME_NAMES,@GENOMES);	
Output($N,%FUNC);
#print "NN $N\n";


####################################################
sub readOrganisms{
	my @ID=shift;
	my %GENOME_NAMES;
	foreach my $ID(@ID){
		open(FILE,$ID) or die "Could not open file $ID $!";
		while ( my $line = <FILE> ) {
			$line=~s/\n|\r//g;
			my @st=split("\t",$line);
			my $Id=$st[0];
			my $name=$st[2];
			$GENOME_NAMES{$Id}=$name;
			#print "$Id => $GENOME_NAMES{$Id}\n";
			}
		close FILE; 
		}
	return (%GENOME_NAMES);
	}


sub CountFunctions{
	my $N=shift;
	my @GENOMES=@_;
	my $count=0;
	my %FUNC;		

	foreach my $genome(@GENOMES){
		chomp $genome;
		print "genome: $genome count $count\n";
		open(FILE,$genome) or die "Could not open file $genome $!";	

		while ( my $line = <FILE> ) {
			my @st=split("\t",$line); 
			my $func=$st[1];
		
			if(!exists $FUNC{$func}) { 
				$FUNC{$func} = [];
				for (my $i=0;$i<$N;$i++){ 
					$FUNC{$func}[$i]=0;
					}	
				}

			$FUNC{$func}[$count]++;
			#print "$func => $FUNC{$func}[$count]\n";		
	
			}
		close FILE;
		$count++; 
		}

	return %FUNC;
	}


sub headers{	
	my $refNAMES=shift;
	my @GENOMES=@_;

	open (FILE,">Salida") or die "Could not open file Salida $!";
	my $headers="FUNCTION\t";
	foreach my $genome(@GENOMES){
		chomp $genome;
		$genome=~s/\.bindings//;
		print "#$genome# => #$refNAMES->{$genome}#\n";
		$headers=$headers.$refNAMES->{$genome}."\t";
		}
	print FILE "$headers\n";	
	close FILE;
	}


sub Output{
	my $N=shift;
	my %FUNC=(@_);
	open (FILE,">>Salida") or die "Could not open file Salida $!";
	foreach my $func(sort keys %FUNC){
		#print "$func\n";
		my $line = $func."\t";
		for (my $i=0;$i<$N;$i++){ 
			$line=$line.$FUNC{$func}[$i]."\t";
			}

		print FILE "$line\n";
		}
	close FILE;
	}
