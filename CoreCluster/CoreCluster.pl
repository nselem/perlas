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
sub Star;
######################################################################
########## Main ######################################################

print "\n\n ##########################################################\n";
print "Bienvenido doctor Cruz\n";
print "\n\n ##########################################################\n";

print "Usted esta usando las herramientas: $NAME\n";
print "Su directorio de trabajo es $dir\n";

my $list=listas($NUM,$LIST);  #$list stores in a string the genomes that will be used
my @LISTA=split(",",$list);

if ($DOWNLOAD==1){
	print "Voy a descargar los genomas\n";
	`mkdir GENOMES`;
	`perl 2.Batch_RetrieveFiles.pl $RAST_IDs $PASS $USER`;
	print "Genomas Descargados\n\n";
	}
else {
	print "Estamos considerando que ya tiene los genomas instalados, en otro caso cambie el valor DOWNLOAD en el archivo globals.\n";
}

if ($FORMAT_DB==1){
	print "Ahora daremos formato a la base datos\n";
	#if (-e Concatenados.faa)´`rm Concatenados.faa`;ç
	`perl header.pl`;
	`makeblastdb -in Concatenados.faa -dbtype prot -out ProtDatabase.db`;
	print "La base recibio formato\n\n";
	}
else {
	print "Estamos considerando que ya tiene su base de datos ProtDatabase lista para realizar blast.\n";
}

print "Buscando secuencias similares al query\n\n";
	if ($LIST eq ""){
                `perl 1_Context_text.pl $QUERIES 0 prots`;
                }
        else {
                print "Buscando en base de datos reducida\n";        
                `perl 1_Context_text.pl $QUERIES 1 prots`;
               }
print "Secuencias encontradas\n\n";

print "Creando arbol de Hits del query, sin considerar los clusters\n";
`cat *.input2> PrincipalHits`;
print "Alineando las secuencias \n";
system "muscle -in PrincipalHits -out PrincipalHits.muscle -fasta -quiet -group";
print "Rasurando las secuencias\n";
system "/opt/Gblocks_0.91b/Gblocks PrincipalHits.muscle -b4=5 -b5=n -b3=5";
#converting RightNames.txt from fasta to stockholm
print "Convirtiendo a formato estocolmo\n";
system "esl-reformat --informat afa stockholm PrincipalHits.muscle-gb >PrincipalHits.stockholm";
#constructing a tree with quicktree with a 100 times bootstrap
system "quicktree -i a -o t -b 100 Principal.stockholm > PrincipalHits_TREE.tre";


print "Analizando clusters con similares al query\n\n";
	`perl ReadingInputs.pl`;
print "Clusters encontrados\n\n";

print "Generando grafica de clusters\n\n";
	`perl 2.Draw.pl`;
print "Archivo SVG generado\n\n";

print "Pausa aqui\nPulsa enter para continuar";
my $pausa=<STDIN>;

print "Calculando el core de los clusters";
	`perl OrthoGroups.pl`;
print "Core calculado\n\n";

print "Calculando alineamiento\n";
	`perl multiAlign_gb.pl`;
print "Alineados\n\n";


print "Concatenando\n";
	`perl ChangeName.pl`;
	`perl EliminadorLineas.pl`;
	`perl Concatenador.pl`;
	`perl Rename_Ids_Star_Tree.pl`;
`rm *.lista`;
`rm lista.*`;
`rm *.input`;
`rm *.input2`;
`rm Core`;
`rm PrincipalHits`;
`rm PrincipalHits.muscle`;
`rm PrincipalHits.muscle-gb`;
`rm PrincipalHits.muscle-gb.htm`;
`rm Core0`;
`rm -r OUTSTAR`;
`rm -r MINI`;

#lines added by Cruz himself
#converting RightNames.txt from fasta to stockholm
system "esl-reformat --informat afa stockholm RightNames.txt >RightNames.stockholm";
#constructing a tree with quicktree with a 100 times bootstrap
#system "quicktree -i a -o t -b 100 RightNames.stockholm > BGC_TREE.tre";

print "Done\n";
print "Que tenga usted un feliz dia\n\n";


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
sub Star{
	my $NUM=shift;
	my $lista=shift;
	$COLS=$NUM+1;
	$MIN=$NUM-1;

	  system("cut -f2-$COLS ./OUTSTAR/Out_$lista.Ortho | sort | uniq -c |  awk '\$1>$MIN' >Core0");


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
