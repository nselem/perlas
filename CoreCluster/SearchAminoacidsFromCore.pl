use Getopt::Long;
use globals2;
#####################################
#REQUERIMIENTOS:
#-LISTA DE GENOMAS
#-BLAST UNO vs OTRO escalonado e.g. 1vs2  2vs3  3vs 4 .../
#- FAA DE CADA GENOMA -> FAA/
#AUTOR: Christian Eduardo Martinez G.
# cmartinez@langebio.cinvestav.mx
#####################################
#!/usr/bin/perl

#$dir="/home/fbg/ilab/ana/RASTtk";

# $dir Global variable from globals
my $infile="$NAME2";  ##Creará una carpeta asi
my $outdir="$dir2/$infile";

my $lista="lista.$NUM2";
my $listaname="$NUM2.lista";
my $DesiredGenes="Core";

#-----------------------------------------
#system "ls FAA/*.faa >lista";

#print "Seleccionando unicos...\n";
if (-e $outdir){
	system "rm -r $outdir/FASTAINTER/";
	system "rm -r $outdir/FASTAINTERporORG/";
	system "rm lista.ORTHOall";
	system "rm -r $outdir";
	}

system "mkdir $outdir";
system "mkdir $outdir/FASTAINTERporORG/";
system "mkdir $outdir/FASTAINTER/";



## Imprimir 
#print "$dir/FASTA";
#readMINI($dir2,$listaname);

### Leer todos los minis
my %MINIS=ReadFasta($dir2,$listaname);#INPUT los .bbh OUTPUT=interseccion de todos en  inter.todos

foreach my $PegId(keys %MINIS){	
#	print "$PegId\n";
#	print "$PegId->$MINIS{$PegId}\n";
	}


## Hacer un hash con el id de cada gen por ortologia
## Imprimir un fasta con esos ids ordenados por ortologos
## Imprimir lista Ortho all
byOrthologues($DesiredGenes,\%MINIS,$outdir);

## Hacer Hash con los id de cada gen en el core por organismo
## Imprmir Fasta con los ids ordenados por organismo (Cada organismo con todos sus genes en el core
byOrganism($DesiredGenes,\%MINIS,$outdir);
print "Done!\n";


####################################
##GENERA FASTA de las intersecciones
####################################


sub ReadFasta{
	my $dir=shift;
	my $listaname=shift;
	my %hashFastaH;

	#print "\n$dir/$listaname\n";
	open (FAA, "$dir/$listaname") or die $!;
#	print"Lista abiertai\n";## Lista con todos los nombres de faa en el directorio

	my $headerFasta="";

	while(my $linea=<FAA>){
		chomp($linea);
		#print "Linea fasta $linea \n";
		######### Get file number
		my $fnumber=$linea;
		$fnumber=~s/\.faa//;
		#print($fnumber,"\n");
		####### llena hash con encabezado-secuencia#####
		open (CU, "$dir/MINI/$linea") or die $linea;
  		while(<CU>){

    			 if($_ =~ />/){
       				chomp;
       				$headerFasta=$_."|$fnumber";
			#	print "$headerFasta\n";
     			}
     			else{
       				$_ =~ s/\*//g;
       				$hashFastaH{$headerFasta}= $hashFastaH{$headerFasta}.$_;
			#	print "$headerFasta => $hashFastaH{$headerFasta}\n";
  
     			}
		 }#end while CU
	}#end while FAA ############# Termina de llenar has con encabezado-secuencia
	################################################
	close CU;
	close FAA;
	return %hashFastaH;
}

#_______________________________________________________________________
sub byOrthologues{
	my $DesiredGenes=shift;
	my $refMINIS=shift;
	my $outdir=shift;
	#my %byOrtho;

	open (ALL, "$dir/$DesiredGenes") or die $!;
	my $count=1;

 	foreach my $linea(<ALL>){

		open (FASTAINTER, ">$outdir/FASTAINTER/$count.interFastatodos") or die "Couldnt open file $count interFastatodos $!";
  #		print "Writing: $outdir/FASTAINTER/$count.interFastatodo\n";
		open (LISTA, ">>$outdir/lista.ORTHOall") or die "Lista ortho all $!";
		print LISTA "$count.interFastatodos \n";

		chomp $linea;
	#	print "Orthologue $count in core\n";
		my @sp=split (/\t/,$linea);
		foreach my $gen (@sp){
			$gen=">$gen";
			#print "#$gen#\n";
			#print "MINIS: #$refMINIS->{$gen}#\n";
			if(exists $refMINIS->{$gen}){
			#	print("Encontrado!\n");
				print FASTAINTER "$gen\n$refMINIS->{$gen}";
     				}
     			else{
       			#	print "NOT FOUND!!!\n*$gen\n**$refMINIS->{$gen}\n";
     				}
			}
		close FASTAINTER;
		close LISTA;
		$count++;
#		print "\n";
		}
	close ALL;
}

#_______________________________________________________________________

sub byOrganism{
	my $DesiredGenes=shift;
	my $refMINIS=shift;
	my $outdir=shift;

	open (ALL, "$dir/$DesiredGenes") or die $!;
	my %Orgs;
	my $count=1;

 	foreach my $linea(<ALL>){ ## para cada linea en el core 
		chomp $linea;
		my @sp=split (/\t/,$linea);
	#	print "Linea $count \n ";
		$count ++;		
		foreach my $gen (@sp){		## obtengo en orden todos sus genes
			$gen=">$gen";
	#		print "#$gen#\n";
			
			if ($gen=~/\>fig\|\d*.\d*\.peg\.\d*\|(\d*\_\d*)$/){
	#			print "Este gen tiene organismo #$1#\n";		
				if (!exists $Orgs{$1}){
					$Orgs{$1}=[];
	#				print "Organismo #$1# es un  array\n";
					}
			
				push(@{$Orgs{$1}},$gen);
				}
	#		print "MINIS: #$refMINIS->{$gen}#\n";
		}	
	}
	close ALL;

	foreach my $orgNumber(keys %Orgs){
    		open (FASTAINTERORG, ">$outdir/FASTAINTERporORG/$orgNumber.interFastatodos") or die "Couldn't open orthologues file $orgNumber $!"; 
     		if(exists $Orgs{$orgNumber}){
			foreach my $gen (@{$Orgs{$orgNumber}}){
     				if(exists $MINIS{$gen}){
 	      				print FASTAINTERORG "$gen\n$MINIS{$gen}";
					}
				else{
	#				print "NOT FOUND por ORG\n$gen\n$MINIS{$gen}\n";
					}
				}
     			}
		else{
         #     		print "Organism $orgNumber doesn't have an array with its genes!!\n";
			}
  		close FASTAINTERORG;
 	}#end while foreach
}

