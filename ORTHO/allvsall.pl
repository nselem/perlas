use warnings;
use strict;
use Getopt::Long;

####################################################################################################
# This program produces lists of orthogroups
# Needs:
# Req: Numerical list of desired genomes to explore in order to look for orthogroups
# input: An input file with an all vs all blast that includes at least the numbers in Req
# Optional:
# verbose mode 
# Output file name of the outputfile
#

##################################################################################################################

#############################################
## Subs
sub Options;
sub bestHit(); #Lines on a file, Arguments hash of hashes reference
sub ListBidirectionalBestHits; #HAsh of hashes reference (empty), Hash of hashes full with best hits
sub EmptyIntersection();  ##I also could ask not in some
sub IsEverybody();
sub SelecGroup(); 
############################################3
#Variables
my $verbose;
my $inputblast;
my $output;
 #my $FileA="OUTSTAR/SalidaListaJunio15_10_29";
 #open(FILEA, "$FileA")  or die "cannot open $FileA: $!";

my %BH = (); #Hash de hashes
#my $n = 385;
my $n = 8069670;
my %Universales;
my %BiBestHits;
my @Required=Options(\$verbose,\$inputblast,\$output);
#################################################################################################

sub Options{
	my $Req; ## Genoms liist to look for otrho groups
	#my $Total=(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29);
	GetOptions ("In=s" => \$inputblast,"Out=s" => \$output,"Req=s" => \$Req,"verbose" => \$verbose) or die("Error in command line arguments\n");

	if(!$inputblast) {
		die("Please provide an all vs all file");
		} 
	if (!$output){
		$output="Out_".$Req.".Ortho";
		}
	if(!$Req){
		die ("You must specify from which organisms you desire an ortho-group");
		}	
	else{
		my @Required=split(",",$Req);
		if ($verbose){
			print("You want ortho groups of the following genomes\n");
			for my $req(@Required){
				print "$req \t";
				}
				print("\n");
			}
		return @Required;
		}
	}
########## Wich organisms do we want
my @NotAllowed=();
#my @subgroup=(10,11,12,13,14,15,16,17,18,19,20,21,34);


########################################################
## Main
print "Finding Hits for each gene, takes some minutes, be patient!\n"; 
&bestHit($n,\%BH,$inputblast);
print "Now finding Best Bidirectional Hits List\n";
&ListBidirectionalBestHits(\%BiBestHits,\%BH);
#&SelecGroup(\%BiBestHits,\@Required);
print ("Selecting List that contains orthologs from all desired genomes\n");
&SelecGroup(\%BiBestHits,@Required);

##############################################################################




##################### Subs implementation
sub SelecGroup(){
	my $refBBH=shift;
	open (OUT,">./OUTSTAR/$output");
	#my $refRequired=shift;
	for my $gen (keys %$refBBH){
		my $oo1 = '';
		if($gen =~ m/\|(\d+)$/) { $oo1 = $1; }
		#print "$oo1\t";
		#print " $gen: @ORGS \n"; ## Descomentando podemos ver los orgnanismos donde tiene BBH

		my @ORGS=sort (keys %{$refBBH->{$gen}});
		#print " $gen: @ORGS \n"; ## Descomentando podemos ver los orgnanismos donde tiene BBH

		if ($oo1~~@Required){	
			#print "$oo1: @Required\t";	
			if(&IsEverybody(\@Required,\@ORGS) ){
				############### Voy a escribir listas de ortologos del subgrupo ######################
 				print OUT "$oo1\t";
				for(my $i=0;$i<scalar  @ORGS;$i++){			
					my $ortoi;
					if ($ORGS[$i]==$oo1){
						$ortoi=$gen; ## SI no tiene ortologo es que es el mism
						}
					else{   if($ORGS[$i]~~@Required){
							 $ortoi=$refBBH->{$gen}{$ORGS[$i]};
							}
						}
					if($ortoi){
						print OUT "$ortoi\t";
						}
					}		
				print OUT "\n";
				}
			}
		}
	close OUT;
	}

#print (@group);
#my $bool2=&EmptyIntersection(\@group,\@subgroup);
#my $bool=&IsEverybody(\@group,\@subgroup);

#print("##################\n");
#print("\nBool $bool\n");
#print("\nEmpty Intersection $bool2\n");

sub IsEverybody(){
	#print "Checking Intersection";
	my ($Required,$query)=@_;
	my $flag=1;
	for my $element(@$Required){
		#print("elemento $element\n");
		if($element~~@$query){
		$flag=$flag*1;	
		#print("Esta en query \n")
			}
		else{
		      #print("No en query \n");
		      return 0;
			}
		}
return $flag;
}


sub EmptyIntersection(){
	my ($NotAllowed,$query)=@_;
	my $flag=1;
	for my $element(@$NotAllowed){
	#	print("elemento $element\n");
		if($element~~@$query){
		#	print("Esta en query \n");

			return 0;
			}
		else{
		      $flag=1;
		#	print("No en query \n")
			}
		}
return $flag;
}
############################## 
### Sub implementation

sub bestHit(){
	my $n=shift;
	my $BH=shift;
	my $input=shift;
	open(FILE, $input);

	foreach my $line(<FILE>) {
	#	chomp;
 #
		my @sp = split(/\t/, $line);
		#print $sp[0] . "\t" . $sp[1] . "\t\t" . $sp[2] . "\n";

		my $o1 = ''; ## Obtengo el organismo de A
		if($sp[0] =~ m/\|(\d+)$/) { $o1 = $1; }

		my $o2 = '';
		if($sp[1] =~ m/\|(\d+)$/) {  
			$o2 = $1; ## Obtengo el organismo de Columna B
			#if($o1 eq $o2) { next; }# NO queremos el mismo organismo
		} 

	##sp[0] es el gen de la columna A
	#Si no existen hits para ese gen de la columna A
		if(!exists $BH->{$sp[0]}) { $BH->{$sp[0]} = (); }## Entonces inicializo una lista
		if(!exists $BH->{$sp[0]}{$o2}) { $BH->{$sp[0]}{$o2} = [0]; } ## Si no existe hit para genColumnaA y orgColumnaB inicializo en 0.

		if($sp[2] > $BH->{$sp[0]}{$o2}[0]) { ## si para su organismo la nueva linea tiene mejor match
			$BH->{$sp[0]}{$o2} = [$sp[2], $sp[1]]; ## la cambio ##Como no estoy considerando el igual, puede ser que pierda algunos genes ampliando al igual mejora precision pero se complica un poco el tratamiento
		} elsif($sp[2] > $BH->{$sp[0]}{$o2}[0]) {
			push($BH->{$sp[0]}{$o2}, $sp[1]);
		}
		#if(--$n == 0) { last; }### ESTe si no se ajajaja diferencia else elseif
	}
	close(FILE);
	}
##############################################3
#He llenado el hash BestHit (BH) Con los mejores hits de cada gen


#fig|411481.12.peg.1870|9 y fig|6666666.64913.peg.898|4 Checar caso
## Arguments HAsh Best Hits
## Return a hash of hashes with bidirectional best hits for each gen
sub ListBidirectionalBestHits(){
	my $RefBiBestHits=shift;
	my $RefBH=shift;
	my $count=0;
	for my $gen (keys %$RefBH) {
		#print("\n Gen $gen\n has BBH in orgs\n");
		for my $org (keys %{$RefBH->{$gen}}) {#Organismos kk
			#print("$org\t");
			my $hit=$RefBH->{$gen}{$org}[1];
			if($hit and( exists $RefBH->{$hit})) {
				my $oo1 = '';
				if($gen =~ m/\|(\d+)$/) { 
					$oo1 = $1; 
					}
				if(exists $RefBH->{$hit}{$oo1}[1] and $gen eq $RefBH->{$hit}{$oo1}[1]) {
					$RefBiBestHits->{$gen}{$org}=$hit;
					#print("$org\n");
					$count++;
					}
				}
			}
		}
	}

#for my $k (keys %BH) {
#	my $count=0;
#	for my $kk (keys %{$BH{$k}}) {#Organismos kk
		
#		if(exists $BH{$BH{$k}{$kk}[1]}) {
#			my $oo1 = '';
#			if($k =~ m/\|(\d+)$/) { $oo1 = $1; }
#			if($k eq $BH{$BH{$k}{$kk}[1]}{$oo1}[1]) {
#				$count++;
#					
#			}
#		
#		}
#	}

#}

