######################################################################
###This is the main script to run the ortho-group tools
######################################################################

use globals;

#print "This script will help you to find a core between genomes\n";
#print "How many genomes would you like to process?\n";
############################################################

my $specialOrg=$SPECIAL_ORG; #globals.pm
my $nameFolder=$NAME; #globals
my $queries=$QUERIES; #globals
my $num=$NUM;
my $lista=$LIST;
my $download=$DOWNLOAD;
my $formatDB=$FORMAT_DB;
my $rastID=$RAST_IDs;
my $password=$PASS;
my $user=$USER;
my $directorio=$dir;
######################################################################

sub listas;
sub create_listfaa;
sub cleanFiles;
########## Main ######################################################

print "\n\n ##########################################################\n";
print "Bienvenido doctor Cruz\n";
print "\n\n ##########################################################\n";

print "Usted esta usando las herramientas: $nameFolder\n";
print "Su directorio de trabajo es $directorio\n";

if (-e "Report"){`rm Report`;}
open (REPORTE, ">Report") or die "Couldn't open reportfile $!";

my $list=listas($num,$lista);  #$list stores in a string the genomes that will be used
my @LISTA=split(",",$list);

if ($download==1){
	print "Voy a descargar los genomas\n";
	`mkdir GENOMES`;
	`perl 2.Batch_RetrieveFiles.pl $rastID $password $user`;
	print "Genomas Descargados\n\n";
	}
else {
	print "Estamos considerando que ya tiene los genomas instalados, en otro caso cambie el valor DOWNLOAD en el archivo globals.\n";
}

if ($formatDB==1){
	print "Ahora daremos formato a la base datos\n";
	#if (-e Concatenados.faa)´`rm Concatenados.faa`;ç
	`perl header.pl`;
	`makeblastdb -in Concatenados.faa -dbtype prot -out ProtDatabase.db`;
	print "La base recibio formato\n\n";
	}
else {
	print "Estamos considerando que ya tiene su base de datos ProtDatabase lista para realizar blast.\n";
}

#print "Pulse enter to continue\n";
#my $pause=<STDIN>;

print "Buscando secuencias similares al query\n\n";
	if ($lista eq ""){
                `perl 1_Context_text.pl $queries 0 prots`;
		## AQUI QUE PASA CON LOS COLORES!!!!!!!!!!!!!!!!!
                }
        else {
                print "Buscando en base de datos reducida\n";        
                `perl 1_Context_text.pl $queries 1 prots`;
               }
print "Secuencias encontradas\n\n";

print "Analizando clusters con similares al query\n\n";
	`perl ReadingInputs.pl`;
print "Clusters encontrados\n\n";

print "Creando arbol de Hits del query, sin considerar los clusters\n";
`cat *.input2> PrincipalHits`;

my $NumClust= `ls *.input2|wc -l`;
chomp $NumClust;
#$NumClust=~s/\r//;
print "There are $NumClust organisms with similar clusters\n"; 
print REPORTE "There are $NumClust organisms with similar clusters\n"; 

print "Alineando las secuencias \n";
system "muscle -in PrincipalHits -out PrincipalHits.muscle -fasta -quiet -group";

print "Rasurando las secuencias\n";
system "/opt/Gblocks_0.91b/Gblocks PrincipalHits.muscle -b4=5 -b5=n -b3=5";
`perl RenamePrincipalHits.pl`;
#converting RightNames.txt from fasta to stockholm

print "Convirtiendo a formato estocolmo\n";
#system "esl-reformat --informat afa stockholm RightNamesPrincipalHits.txt >PrincipalHits.stockholm";
`perl converter.pl RightNamesPrincipalHits.txt `;

#constructing a tree with quicktree with a 100 times bootstrap
system "quicktree -i a -o t -b 100 RightNamesPrincipalHits.stockholm > PrincipalHits_TREE.tre";
#system "nw_labels -I PrincipalHits_TREE.tre";
system "nw_labels -I PrincipalHits_TREE.tre>PrincipalHits.order";
print "Calculando el core de los clusters\n";
	`perl 2_OrthoGroups.pl`;
#print "Pausa aqui";
#my $sti=<STDIN>;
print "Core calculado\n\n";

my $boolCore= `wc -l Core`;
chomp $boolCore;
print "Numero lineas core $boolCore!\n";
$boolCore=~s/[^0-9]//g;
$boolCore=int($boolCore);
print "Numero lineas core ¡$boolCore!\n";

#$boolCore=0;
my $INPUTS=""; ## Orgs sorted according to a tree (Will be used on the Context draw)
my $orderFile="PrincipalHits.order";
if ($boolCore>1){
	print "There is a core with at least to genes on this cluster\n";
	print REPORTE "There is a core composed by $boolCore orhtolog on this cluster\n";
	print REPORTE "LAs funciones de las enzimas core en el organismo de referencia estan dadas por:\n";


	## Obteniendo el cluster del organismo de refrenecia mas parecido al query
	# Abrimos los input files de ese organismo y tomamos el de mejor score	
	my $specialCluster=specialCluster($specialOrg);
	print "Mejor cluster $specialCluster\n";
        `cut -f1,2 $nameFolder/FUNCTION/$specialCluster.core.function >> Report`;
        `cut -f1,2 $nameFolder/FUNCTION/$specialCluster.core.function`;
	print "Aligning...\n";
	`perl multiAlign_gb.pl`;
	print "Sequences were aligned\n\n";


	print "Creating matrix..\n";
	`perl ChangeName.pl`;
	`perl EliminadorLineas.pl`;

	print "Aqui vamos con el renombramiento Stoop\n";
#	my $stop = <STDIN>;

	`perl Concatenador.pl`;
	`perl Rename_Ids_Star_Tree.pl`;

	print "Formating matrix..\n";
	`perl converter.pl RightNames.txt`;
	print "constructing a tree with quicktree with a 100 times bootstrap";
	system "quicktree -i a -o t -b 100 RightNames.stockholm > BGC_TREE.tre";
	system "nw_labels -I BGC_TREE.tre>BGC_TREE.order";
 	$orderFile="BGC_TREE.order";
	print "I will draw with concatenated tree order\n";
	$INPUTS=getDrawInputs($orderFile);
	}
	else{  ### If there is no core, then sort according to principal hits
	print REPORTE "The only gen on common on every cluster is the main hit\n";
	if (-e $orderFile){
		print "I will draw with the single hits order\n";
		print  REPORTE "I will draw with the single hits order\n";
		$INPUTS=getDrawInputs($orderFile);
        I	}
        }

print "Generando grafica de clusters con los archivos $INPUTS : \n\n";
	`perl 3_Draw.pl $INPUTS`;
print "Archivo SVG generado\n\n";

print "New version firefox \n";
#`perl -p -i -e 'if(/<polygon/){s/title=\"/>\n<title>/g;if(/\/>/){s/\" \/>/<\/title><\/polygon>/g;}}else{if((!/^\t/) and /\/>/){s/\" \/>/<\/title><\/polygon>/g;}}' Contextos.svg`;

cleanFiles;

print "Done\n";
print "Que tenga usted un feliz dia\n\n";

sub specialCluster{
	my $specialOrg=shift;
	my @CLUSTERS=qx/ls $specialOrg\_*.input/;
	my $specialCluster="";
	my $score=0;
	foreach my $cluster (@CLUSTERS){
		chomp $cluster;
		#print "I will open #$cluster#\n";
		open (FILE, $cluster) or die "Couldn't open $cluster\n"; 
		my $firstLine = <FILE>; 
		chomp $firstLine;
		close FILE;
		#print "Primera linea $firstLine\n";
		my @sp=split(/\t/,$firstLine);
			#print "Score $sp[7]\n";
			#print "6 $sp[6] 7 $sp[7]\n";
			if ($score<=$sp[7]){
				$specialCluster=$cluster;
				}
		}
	$specialCluster=~s/\.input//;
	return $specialCluster;
}
######################################################################
######################################################################
###   Sub  Rutinas (llamadas a los distintos pasos del script
#######################################################################
#######################################################################
sub cleanFiles{
        `rm *.lista`;
        `rm lista.*`;
        `rm *.input`;
        if (-e "*.input2"){`rm *.input2`;}
        `rm *.input2`;
        `rm Core`;
        `rm PrincipalHits`;
        `rm PrincipalHits.muscle`;
        `rm PrincipalHits.muscle-gb`;
        `rm PrincipalHits.muscle-gb.htm`;
        `rm *.order`;
        `rm Core0`;
        `rm -r OUTSTAR`;
        `rm -r MINI`;
        `rm -r *.stockholm`;
        `rm -r *.faa`;
        `rm -r *.blast`;
        `rm -r *.txt`;
        }
#_____________________________________________________________________________________

sub getDrawInputs{
	my $file=shift;
	my $INPUTS="";
	open (NAMES,$file) or die "Couldnt open $orderFile $!";

	foreach my $line (<NAMES>){
		chomp $line;
		my @spt=split(/_org_|_peg_/,$line);
		$INPUTS.=$spt[2]."_".$spt[1]."\.input,";
		#print "$INPUTS\n";
		}
		my $INPUT=chop($INPUTS);
		#print "!$INPUTS!\n";
	#obtener el numero de organismos
	#pasarselo al script 2.Draw.pl
	return $INPUTS;
	}
#_________________________________________________________________________
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
