#!/usr/bin/perl
use warnings;
use strict; 
###################################################################

# open a list of folders with cores
# InterFastatodos
# Read Core Functions (once)
# print all functions
# Print all genomes

my $DIR="/home/nelly/nselem/TREE/DatosFamilias";
my @DIRStoOPEN=("unclassified_micrococcineae","Micrococcaceae");

sub readGloblaL;
sub genomesInFamilies;
sub ReadCVSFile;
sub getCore;

my %MEGATABLE; ## Function{Family.GenomeNumber}=["GeneCoreNumbersinFamily"]
my %MEGAPEGS; ## Function{Family.GenomeNumber}=["GeneCoreNumbersinFamily"]

my %GENOMSin; ##GENOMSin{$family}= $ "1,2,..,k,n" 

###################################################################
##################### Main    #####################################
###################################################################
%GENOMSin=genomesInFamilies($DIR,@DIRStoOPEN);

foreach my $family (keys %GENOMSin){
	my @GENOMS=split(",",$GENOMSin{$family});

	foreach my $genome(@GENOMS){
		print ("$family:$genome\n");		#Working in Family GEnome number
		my %FIG=ReadCVSFile($DIR,$family,$genome); #Read its CvS File
		my @CORE=getCore($DIR,$family,$genome); #Getting its Core
		FillTableFunKeys($DIR,$family,$genome,\%FIG,\@CORE,\%MEGATABLE,\%MEGAPEGS);#Fill Function GeneCoreNumber
		}
	}

printTable();

printTableTranspose();

####################################################################


#________________________________________________________________________________

#________________________________________________________________________________


sub printTableTranspose{
	open (MEGATABLE, ">CoreDynamicsTranspose.cvs") or die;
	open (COUNTER, ">CoreCounterTranspose.cvs") or die;

	foreach my $family (keys %GENOMSin){
		my @GENOMS=split(",",$GENOMSin{$family});
		foreach my $num (@GENOMS){
			my $genomeID=$family.$num;
			print MEGATABLE ("\t$genomeID");  #Columns names
			print COUNTER ("\t$genomeID");  #Columns names
			}
		}		

	print MEGATABLE ("\n");
	print COUNTER ("\n");

	foreach my $function (sort keys %MEGATABLE){
		print MEGATABLE ("$function\t"); #Rows names
		print COUNTER ("$function\t"); #Rows names
		foreach my $family (keys %GENOMSin){
			my @GENOMS=split(",",$GENOMSin{$family});

			foreach my $num (@GENOMS){
				my $genomeID=$family.$num;
				my $ref=$MEGATABLE{$function}{$genomeID};
				my $Size=scalar @{$ref}-1;
				print COUNTER ("$Size\t");	
			
				foreach my $GenCoreNumber (@{$ref}){
					print MEGATABLE ("$GenCoreNumber ");
					#print (":$GenCoreNumber ");
					}
		
			#print ("\t");
			print MEGATABLE ("\t");
			}
		}
		print MEGATABLE ("\n");
		print COUNTER ("\n");
	}
close MEGATABLE;
close COUNTER;
}
#_________________________________________________________________________________________
sub printTable{
	open (MEGATABLE, ">CoreDynamics.cvs") or die;
	open (MEGAPEGS, ">CoreDynamicsPegs.cvs") or die;
	open (COUNTER, ">CoreCounter.cvs") or die;

	foreach my $function (sort keys %MEGATABLE){
		print MEGATABLE ("\t$function"); #Columns names
		print MEGAPEGS ("\t$function");
		print COUNTER ("\t$function");
		}
	print MEGATABLE ("\n");
	print MEGAPEGS ("\n");
	print COUNTER ("\n");

	foreach my $family (keys %GENOMSin){
	my @GENOMS=split(",",$GENOMSin{$family});

	foreach my $num (@GENOMS){

		my $genomeID=$family.$num;
		print MEGATABLE ("$genomeID\t");  #Rows names
		print MEGAPEGS ("$genomeID\t");
		print COUNTER ("$genomeID\t");

		foreach my $function (sort keys %MEGATABLE){
			my $ref=$MEGATABLE{$function}{$genomeID};
			my $Size=scalar @{$ref}-1;
			#print ("$function\t$genomeID\t#$Size#\t");
			##print MEGATABLE ("$Size\t");	
			##print MEGAPEGS ("$Size\t");	
			print COUNTER ("$Size\t");	
		#	print MEGATABLE ("$function>$Size: ");

			
			foreach my $GenCoreNumber (@{$ref}){
				print MEGATABLE ("$GenCoreNumber ");
				print MEGAPEGS ("$GenCoreNumber ");
				#print (":$GenCoreNumber ");
				}

			print MEGAPEGS ("$function=>$MEGAPEGS{$function}");
		
			#print ("\t");
			print MEGATABLE ("\t");
			print MEGAPEGS ("\t");
			}
		print MEGATABLE ("\n");
		print COUNTER ("\n");
		print MEGAPEGS ("\n");
		}
	}
close MEGATABLE;
close MEGAPEGS;
close COUNTER;
}
#________________________________________________________________________________
sub FillTableFunKeys{  ## Returns the function for each gene (Sorted by Fig number)
 	#mainFig($num,\%FIG,\@CORE,$core,$dir,$NAME,$refMega);   #escribe Salida
	my $dir=shift;
	my $NAME=shift;   ##Family name
	my $num=shift;  ##Genome Number
	my $refFig=shift;
	my $refCORE=shift;  ##When CORE passed it is numbered
	my $refMega=shift;
	my $refPegs=shift;

	my @CORE=@{$refCORE}; ##Core or complement members
	my %GenCoreNumber;	

	for (my $i=0;$i<@CORE;$i++){  ##Fill geneCoreNumber
		my $fig=$CORE[$i];
		$GenCoreNumber{$fig}=$i+1;
		}

	foreach my $fig (@CORE){ ## fig has function $function stored at FIGS
		if (exists $refFig->{$fig}){
			my $function=$refFig->{$fig}[6];
			print("$GenCoreNumber{$fig}:=>$fig:>$function\n");
			
			if (!(exists $refMega->{$function})){ #If this function is not yet in %MEGAtABLE
				$refMega->{$function}=(); ##We aff the function to the keys of MEGATABLE

				foreach my $family (keys %GENOMSin){ #And for each genome in each family start an array
					my @GENOMS=split(",",$GENOMSin{$family});
					foreach my $genome (@GENOMS){
						$refMega->{$function}{$family.$genome}=["#"];					
						}
					}
				#$refMega->{$function}{$NAME.$num}=[$GenCoreNumber{$fig},$fig];	
				#In particular We store the Gen Family andfd function os this gene
				}
			push ($refMega->{$function}{$NAME.$num}, $GenCoreNumber{$fig});
			$refPegs->{$function}=$NAME.$num;	
				#Works: push ($refMega->{$function}{$NAME.$num}, $fig);
			}
		else {die "No Function for Family $NAME GENOME $num peg #$fig#";}
		}
	}
#________________________________________________________________________________
####################################################################
sub getCore {
	my $dir=shift;
	my $NAME=shift;
	my $num=shift;
	my @CORE;
	my $core_file="$DIR/$NAME/$NAME/FASTAINTERporORG/$num.interFastatodos";
	@CORE=readList($core_file);  ## Fills Querys with the querys figs  ##Cambiarlo al interFAsta todos		
	return @CORE;
}
#_______________________________________________________________________________________________

sub readList{

	my $input=shift;
	my @LContent;
	open (LISTA,"$input") or die "could not open file $input $!";
        my @Genome=<LISTA>;
	foreach my $line (@Genome) {
		chomp $line;
		if ($line=~/>/ ){
		$line=~s/\|\d*$//g;
		$line=~s/>//g;
		#print("#$line#\n");
			push(@LContent,$line)
			}
		};
	return @LContent;
}
#________________________________________________________________________________
sub ReadCVSFile {
	my $dir=shift;
	my $NAME=shift;
	my $num=shift;

	my %FIG; #Fig, Category, SubCategory # Subsystem #Role 
	my $ReactionFile="$dir/$NAME/$num.cvs";  ## File cvs from RAST with ALL the reactions (From the spreadsheet reaction)
	readSubsystem($ReactionFile,\%FIG);  #Stores en %FIG the information in cvs file
	return %FIG;							
}
#________________________________________________________________________________
sub genomesInFamilies{
	my $DIR=shift;
	my @DIRStoOPEN=@_;
	my %GENOMSin;

	foreach my $family (@DIRStoOPEN){
		$GENOMSin{$family}=readGlobal($DIR,$family);	
		my @GENOMS=split(",",$GENOMSin{$family});
		}			
	return %GENOMSin;
	}





#___________________________________________________________
sub readGlobal{

	my $DIR=shift;
	my $name=shift;
	
	open (GLOBAL, "$DIR/$name/globals.pm") or die "could not open global file $name $!";

	my $NUM="ERROR"; my $LIST="ERROR";
	while (my $line = <GLOBAL>){
		chomp $line;		
		if ($line=~/LIST/){
			my @sp=split("\"",$line);
			$LIST=$sp[1];
			}

		if ($line=~/NUM/){
			my @sp=split("\"",$line);
			$NUM=$sp[1];
			}
		}
	#print "LISTA:$LIST##\nNUMERO:$NUM##\n\n";	 
	my $list=listas($NUM,$LIST);  #$list stores in a string the genomes that will be used
close GLOBAL;

	return $list;

}
#____________________________________________________________________
sub listas{ ##IN case we only have a NUM and no a LIST
	my $NUM=shift;
	my $LIST=shift;
	my $lista="";

	if ($LIST){ 
		##print "Lista de genomas deseados $LIST";
		$lista=$LIST;
		}
	else {
		for( my $COUNT=1;$COUNT <= $NUM ;$COUNT++){
			$lista.=$COUNT;
			if($COUNT<$NUM){
				$lista.=",";
				}
			}
		}
	return $lista;
		
	}
#_______________________________________________________________________________________________

sub readSubsystem{ ## Get the full reaction and function information from the organism
	my $input=shift;
	my $refFig=shift;

	my @LContent;
	open (LISTA,"$input") or die "Could not open file $input : $!";

	while( my $line = <LISTA>) {
		$line=~ s/\r//g;   ##Cleaning what interferes with chomp
		chomp ($line);
		#print ">$line#\n";
		my @Parts=split("\t",$line);

		chomp @Parts;

		my $contig_id=$Parts[0];
		my $feach=$Parts[1];
		my $type=$Parts[2];
		my $location=$Parts[3];
		my $start=$Parts[4];
		my $stop=$Parts[5];
		my $strand=$Parts[6];
		my $function=$Parts[7];
		my $aliases=$Parts[8];
		my $figfam=$Parts[9];
		my $evidence_codes=$Parts[10];
		my $nucleotide_sequence=$Parts[11];
		my $aa_sequence=$Parts[12];
		
		if($feach=~/fig/){
			chomp $feach;	
			$feach=~s/^\s*//;	
			$feach=~s/\n//;	
			$refFig->{$feach} = [$contig_id,$type,$location,$start,$stop,$strand,$function,$aliases,$figfam,$evidence_codes,$nucleotide_sequence,$aa_sequence]; 
			}
		}
	close LISTA;
	}
