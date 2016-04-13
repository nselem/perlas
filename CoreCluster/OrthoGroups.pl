######################################################################
###This is the main script to run the ortho-group tools
######################################################################

use globals2;

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
sub Star;
######################################################################
########## Main ######################################################

print "NAME: $NAME2\n";
print "your dir $dir2\n";

my $list=listas($NUM2,$LIST2);  #$list stores in a string the genomes that will be used
my @LISTA=split(",",$list);

run_blast($e2);

print "I will run allvsall with blast $BLAST2\n";
#print "`perl allvsall.pl -R $list -v 0 -i $BLAST`\n";
`perl allvsall.pl -R $list -v 0 -i $BLAST2`;
#`perl allvsall.pl -R 8,12,57,58,59,60,61,248,261,262,273,275,277,282,310 -v 0 -i ClusterTools1.blast`;


Star($NUM2,$list);

`perl SearchAminoacidsFromCore.pl`;
`perl ReadReaccion.pl`;


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
	if (-e "MINI/Concatenados.faa"){
		print "File concatenados.faa removed\n";
		unlink ("MINI/Concatenados.faa");
		}
	`perl header2.pl`;
	my $e=shift;
	`makeblastdb -in MINI/Concatenados.faa -dbtype prot -out MINI/Database.db`;
	`blastp -db MINI/Database.db -query MINI/Concatenados.faa -outfmt 6 -evalue $e -num_threads 4 -out $BLAST2`;
	
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
sub Star{
	my $NUM=shift;
	my $lista=shift;
	$COLS=$NUM+1;
	$MIN=$NUM-1;

	  system("cut -f2-$COLS ./OUTSTAR/Out.Ortho | sort | uniq -c |  awk '\$1>$MIN' >Core0");


	open (CORE0,"<","Core0") or die "Could not open the file Core0:$!";
	open (CORE,">","Core") or die "Could not open the file Core:$!";

	for my $line (<CORE0>){
		$line=~s/\s*\d*\s*//;
		print CORE $line;
		}
	close CORE0;
	close CORE;
#	`rm Core0`;

}

#_____________________________________________________________________________________
#`perl depuraANA.pl`;
#`rm lista.$NUM`;
