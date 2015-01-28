######################################################################
###This is the main script to run the ortho-group tools
######################################################################

use globals;

#print "This script will help you to find a core between genomes\n";
#print "How many genomes would you like to process?\n";
#my $NUM=<>;
#chomp $NUM;


#$infile="CORE";  ##Creará una carpeta asi
#$outdir="$dir"."/"."$infile";
#$DesiredGenes="Core";

############################################################
sub listas;
sub run_blast;
######################################################################
########## Main ######################################################

print "NAME: $NAME\n";
print "your dir $dir\n";

my $list=listas($NUM,$LIST);  #$list stores in a string the genomes that will be used
my @LISTA=split(",",$list);

run_blast($e);


######################################################################
######################################################################
###   Sub  Rutinas (llamadas a los distintos pasos del script
#######################################################################
#######################################################################

sub listas{
	my $NUM=shift;
	my $LIST=shift;
	my $lista="";

	create_list($NUM,$LIST);
	create_listfaa($NUM,$LIST);	
   
	if ($LIST){ 
		print "Lista de genomas deseados $LIST";
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
	print "Se crearon listas del programa\n";
	print "Se agregó identificador de organismo a cada secuencia\n";

	return $lista;
		
	}

#_____________________________________________________________________________________
sub create_list{  ########### Creates a numbers lists			
	
	my $NUM=shift;
	my $LIST=shift;

	if (-e "lista.$NUM"){
			unlink("lista.$NUM");
			}
	open (LISTA, ">","lista.$NUM");


	if ($LIST){
		my @Genomas=split(",",$LIST);	
		foreach (@Genomas) {
		print LISTA "$_\n";		
			}
		}
	else{	

		my $COUNT=1;
		while  ( $COUNT <= $NUM ){
			print LISTA "$COUNT\n";		
			$COUNT=$COUNT+1;
			}
		}


	close LISTA;
	}

#_____________________________________________________________________________________

sub create_listfaa{
	
	my $NUM=shift;
	my $LIST=shift;

	if (-e "$NUM.lista"){unlink( "$NUM.lista");}
	
	open (LISTA,"<","lista.$NUM") or die "Could not open the file lista.$NUM:$!";
	open (LISTAFAA,">$NUM.lista") or die "Could not open the file $NUM.lista:$!";

	for my $line (<LISTA>){
		chomp $line;
		$line.="\.faa\n";
		print LISTAFAA $line;
		}
	close LISTA;
	close LISTAFAA;
		
	}
#_____________________________________________________________________________________
sub run_blast{
	`perl header.pl`;
	my $e=shift;
	`makeblastdb -in Concatenados.faa -dbtype prot -out Database.db`;
	`blastp -db Database.db -query Concatenados.faa -outfmt 6 -evalue $e -num_threads 4 -out $BLAST`;
	if (-e "Concatenados.faa"){
		print "File concatenados.faa removed\n";
		unlink ("Concatenados.faa");
		}
	if (-e "Core"){
	
print "File Core removed\n";
		unlink ("Core");
		}
	if (-e OUTSTAR ){system (rm -r OUTSTAR);}
	system(mkdir OUTSTAR);
	print "Se corrió el blast\n";
	print "\nLista $list#\n";
	print "Inicia búsqueda de listas de ortologos \n";

}

#_____________________________________________________________________________________

