#Abrir la carpeta ALIGMENTS_GB
# Crear el directorio NUCLEOTIDES
#!/usr/local/bin/perl -w
use Getopt::Long;
###################################################################################################
### Description

$description="Help:\n
#Leer cada archivo
#	Crear un archivo del mismo número con otra extension
#	Inicializar un contador
#	Para cada gen en el archivo-gb buscar en el archivo-genoma correspondiente
#	aumentar el contador
# 	Escribir el gen con el mismo id
#	Cortar el codon del final
# 	Cerrar el archivo
";


#####################################################################################################
####### User Input 

my $help=""; my $verbose=""; my $prefix=""; my $dir="";
GetOptions('help|?' => \$help,'verbose=s' => \$verbose,'prefix=s' => \$prefix,'dir=s' => \$dir);
#####################################################################################################


###############################################################################################
####### Global Variables
my @files; #GB files that contains proteins for which we desire the nucleotides
#my $directory =  '/home/fbg/lab/nselem/RASTtemp/ALIGNMENTS_GB';
$infile="1-47_MINUS_27"; 
my $directory = "/home/fbg/lab/ana/RASTtk/$infile/ALIGNMENTS_GB"; 
my $out_directory = "/home/fbg/lab/ana/RASTtk/$infile/NUCLEOTIDOS";
my $GenomePATH="/home/fbg/lab/ana/RASTtk/*.fna"; 
if (-e $out_directory){`rm -r $out_directory `;}
`mkdir $out_directory`;
my $start=1; $stop=47; #Numered genome files that shall be used
###############################################################################################

############################################################################################## S
################### Leyendo variables proporcionadas por el usuario en la consola 
if ($help){print "$description\n";}
if ($verbose){print "Verbose Mode\n";}
if ($prefix){print "Prefix Archivo de salida: $prefix\n";}
if ($dir){ $directory=$dir;
           print "Directorio de entrada: $dir\n";}
################################################################################################

####################################################################################################################
#####################################################################################################################
########################    #Main Program
####################################################################################################################
        &GetFileNames; ## Saves the dir file names in @files

	if($verbose){
		print "###################The Files that will be modify:###########\n";
		#print join("\n ", @files);
		print "\n#############################################################\n";
		}	

        foreach $archivo (@files){ ## Para cada archivo
#		print "$archivo\n";
	   	@Contenido=&GetContent($archivo);##  Obtengo su contenido
		&EscribiendoSalida($archivo, @Contenido); # Cambio los nombres del fasta a org1, org2...
							 ## Creo un archivo cuyo nombre solo contiene el numero contenido en el original
		### En ese archivo se guardan las secuencias del original, pero con los identificadores cambiados a org1, org 2, etc
		}
######################################################################################################################
#######################################################################################################################


###############################################################################################
#################Subroutines

sub GetFileNames{ ##Pondra en @files los nombres de los archivos que abriremos
#### Voy a abrir todos los archivos del directorio para llenar el arreglo files

     opendir (DIR, $directory) or die $!;  ### Abriendo el directorio
                 while (my $file = readdir(DIR)) { ####leyendo todos los archivos
                         if (($file=~m/^\d/)&&($file=~m/gb/)&&($file=~m/.*[^htm]$/)){
				 ######## Si el nombre del archivo empieza con un digito, contiene gb y no acaba con htm, lo guarda
                                push(@files,$file);     ####Guarda el nombre del archivo en el arreglo @files
                                if($verbose==$1 ){  print "The File $file will be open\n";}
                        }
                    }
   #print "Se abrio el directorio $directory con los archivos numericos\n\n";
   closedir DIR;
}
######################################################################################
########################################################################

sub GetContent{ ######## solo necesita un archivo fasta que abrir 
####### Abro un archivo del Directorio cambiar los nombres de las secuencias
###### Estoy suponiendo yA todos tienen exactamente los mismos 30 genes ordenados.
###### Si no, habría que hacer un paso previo.

        my ($filename)= @_;
        $filename="$directory"."/"."$filename";
	#print "$filename\n";
	open(FILE1,$filename);###########Abrir el archivo 
	@file=<FILE1>; #Saving the information in an array
	close FILE1; # Closing file
	if ($verbose==2){print "Hello @file\n";}
	return @file;
}

sub look_for_file{
	my $id=shift;
	$id=~s/>fig\|//;
	#print "ID $id";

	chomp $id;
	##print "$id $GenomePATH\n";
	my @Grep=`grep -H '$id' $GenomePATH`;

	#print "grep -H $id /home/fbg/lab/nselem/RASTtemp/* \n";
	#print "GREP $Grep[0]";
	my @name=split(":",$Grep[0]);
	my $file=$name[0];
	print "FILE $file ##\n";	
	return $file;
}
sub look_for_gene{
	my $id=shift;
	my $file=shift;	
	#print "Id $id File $file\n ";
	open(GENOME,$file) or die $!;
	#print "$file has benn opened\n";
	my @genome=<GENOME>;
	close GENOME;
	my $text=join("",@genome);
	my @pre_gen=split(">",$text);
        
	my %HASH;## Aqui ya sabe en que archivo esta el gen buscado gracias al grep
	foreach my $line(@pre_gen){
	#print "LINE $line\n";
	my @gen=split("\n",$line);
	$secuence=$line;
	$secuence=~s/fig\|[0-9]*.[0-9]*.peg.[0-9]*\n//;
	$HASH{$gen[0]}=$secuence;
	}
	
	foreach my $key (keys %HASH){
	chomp $key;
	my $test=$key;
	$test=">".$test;
	#print "KEY $key TESt $test ID $id\n HASH $HASH{$key}";
	if($id eq $test){
	#print"LINE $key ID $id $HASH{$key}\n";
	return $HASH{$key};
	}
	}
}

sub cut_stop{
	my $secuence=shift;
	if ($secuence=~m/tga$/){
	#print "stop codon detected at $secuence";
	$secuence=~s/tga$//;
	}
	return $secuence;	
}
#########################################################################################
sub EscribiendoSalida{  #######Necesita a @file lleno
########## finalmente imprimo archivo de salida

###### Creo un archivo salida
	
	my $nombre=shift;
	my (@Content)=@_;
	my $count=1;
	#print "$nombre\n";
	my %GEN;
	my %IDs;
	#print"\n#########Contenido:##########\n";
	#print join(", ", @Content);

 	$nombre=~s/([^0-9]*)//g;  ### En la cadena nombre elimino todo lo que no sea numero.
	$nombre=$nombre."\.fasta"."\.nucleotido";
				  ### Así pues en $nombre se guarda solamente el numero incluido en el nombre del archivo

	if ($verbose) {print "Nuevo nombre $nombre\n";}

	open(OUTFILE,">$out_directory/$nombre");

	foreach $line (@Content){ ## Para cada clave de organismo
                if($line=~m/>/){
		#$count++;
		if ($verbose==3){print "$line";}
		chomp $line;
		#print("Busco el gen $line\n");
		#$gen=$line;
		$line=~s/\|\d*$//;
		#print("Sin el tag $line\n");
		#my $genome_file=$count;
		#$genome_file="/home/fbg/lab/nselem/RASTtemp/$genome_file"."\.fna";
		#print "$genome_file\n";
	#	print "COUNT $count\n";
		my $g_file=&look_for_file($line);
		my $gen=&look_for_gene($line,$g_file);
		
 		$name_file=$g_file;
		$name_file=~s/([^0-9]*)//g;  ### En la cadena nombre elimino todo lo que no sea numero.
		
		$GEN[$name_file]=$gen;
		$IDs[$name_file]=$line."_File_"."$name_file";

		#print "$IDs[$name_file]\n";
		#print "$GEN[$name_file]\n";
		#print "####$name_file###\n";		
		if($verbose){print "$line\n";}     ###imprimo en pantalla su secuencia concatenada 
		#print OUTFILE "$line$count\n";###imprimo en archivo salida la secuencia concatenada
		}	
	}## todo en formato fasta

	################ Ahora si escribiendo la salida##################
	open (ERROR,">errores.txt");

	my $i;
	for ($i=$start;$i<=$stop;$i++){
		
		my $gen=$GEN[$i];
		my $cut_gen=&cut_stop($gen);
		print OUTFILE "$IDs[$i]\n$cut_gen";
		

		if($GEN[$i] eq ""){
			print "IDs[$i] is empty\n";
			print ERROR "IDs[$i] is empty\n";
		}
	}
	close OUTFILE; ## Y cierro el archivo de salida
	print"\n Se escribio archivo de salida $nombre\n";
}
################################################################################################
exit;


