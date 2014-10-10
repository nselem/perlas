#!/usr/local/bin/perl -w
use Getopt::Long;
#################################################################################################


########################################################################################################
#############   Variables del usuario 
my $help=""; my $verbose=""; my $outputfile=""; my $dir="";
GetOptions('help|?' => \$help,'verbose' => \$verbose,'outputfile=s' => \$outputfile,'dir=s' => \$dir);
#########################################################################################################

if ($help){print "Help:\n
#########################################################################\n
#########################################################################\n
######### Author Nelly Selem   nselem84\@gmail.com 22 Nov 2013\n
######### Laboratory Phd Francisco Barona\n
#########################################################################\n
######### This script will concatenate several gene in one sequence in order\n
## to construct a species philogenetic tree. As a result it creates an output file.\n
#########################################################################\n
### You can ask for verbose mode -v \n
### You can specify the out pufile -o outfile.fas \n
### You can also specify the input dir -d directory \n
#########################################################################\n
###      Algorithm \n
###  (It it is asumed that every file has the correct fasta name of the organisms)\n
###   it may need a previous script to check this assumption.\n
#### 
#### 1. It will open one file in order to get a list of the organisms names.\n
###  2. It will open a Dir with numbered files (only numbers in their names) \n
#### 	each numbered file has homologs of one conserved gene.\n
###  3. Once the files were opened a Hash is constructed by the sequences\n
###     concatenation HASH{organism}=gen1.gen2.gen3....\n
###  4. This HASH is printed in an output file.\n
#########################################################################################\n
";}

##############################################################################################
############ Leyendo variables de usuario
if ($verbose){print "Verbose Mode\n";}
if ($outputfile){print "Archivo de salida: $outputfile\n";}
if ($dir){print "Directorio de entrada: $dir\n";}
###############################################################################################


####### Global Variables
my @keys;    ### Aqui guardare los nombres de los organismos
my %HASH;    ### Aqui se guardaran las secuencias concatenadas
my @files;   ######### Arreglo que contendrá los archivos del directorio que tengan nombre numerico

my $infile="NUEVOCORE2";
my $directory =  "/home/fbg/lab/ana/RASTtk/$infile/CONCATENADOS";
#my $out_directory = "/home/fbg/lab/nselem/GRPAPER/$infile/CONCATENADOS";
	
#################################################################################################
#################################################################
######  Main program

&GetKeys;        #######Obtiene los nombres de los organismos (org1, org2, etc) Deben ser iguales en todos los archivos
&CreateHash;     ####### Crea un HAsh que contendra las secuencias concatenadas
&GetFileNames;   #####Abre el directorio y obtiene el nombre de todos los archivos a concatenar
&concatenar; 	##### Concatena en el hash las secuencias correspondientes (una por cada archivo)
&EscribiendoSalida;  ## Escribe el hash concatenado en un archivo de salida
##################################################################
####################################################################


#################Subroutines
########################################################################

sub GetKeys{ ######## solo necesita un archivo fasta que abrir 
####### Abro un archivo del Directorio para obtener los nombres del hash
###### Estoy suponiendo yA todos tienen exactamente los mismos genes.
###### Si no, habría que hacer un paso previo.
	$OpenFile="$directory/1";
	open(FILE1,$OpenFile); 
	@file0=<FILE1>; #Saving the information in an array
	close FILE1; # Closing file

############# Guardo los nombres de los organismos en el arreglo keys
	foreach $line (@file0) {### Recorro todas las lineas del archivo
		if ($line=~m/>/) {#Reconozco las lineas que tienen el caracter >
			chomp $line;## Recorto el salto de linea
	    	       $key=substr($line,1);#Recorto el >
			push (@keys,$key); # las lineas con > seran las llaves del hash  		  
		}
	}
}
#########################################################################################


##########################################################################################

sub CreateHash{  ######### Necesito lleno @keys
	for my $key ( @keys) { ## Recorro todas llaves del array
		$key=">".$key; ## Para los nombres del HAsh necesito agregar el >
		$HASH{$key}=""; #Se inicializa el HASH que contendra los concatenados
		if($verbose) {print "Se guardo en HASH la llave: $key con contenido: $HASH{$key}\n ";}	
	    }
	print "Se creo hash de genes a concatenar\n";
}
#####################################################################################



#####################################################################################
sub GetFileNames{ ##Pondra en @files los nombres de los archivos que abriremos
#####################################################################################
#### Voy a abrir todos los archivos del directorio para llenar hash de concatenados

#  my $directory = '/home/fbg/lab/nselem/RASTtemp/CONCATENADOS';
  if ($dir){$directory=$dir;}

     opendir (DIR, $directory) or die $!;  ### Abriendo el directorio
		 while (my $file = readdir(DIR)) { ####leyendo todos los archivos
 if ($file=~m/^\d/&&($file=~m/^((?!pir).)*$/)){ ######## Si el nombre del archivo empieza con un dig
push(@files,$file);	####Guarda el nombre del archivo en el arreglo @files
			if($verbose ){	print "The File $file will be open\n";}
			}	
		    }
print "Se abrio el directorio con los archivos numericos\n\n";
	closedir DIR;
}
######################################################################################


########################################################################################
sub concatenar{
#######	    Se creará un solo string sin espacios por archivo para facilitar la manipulación
#######     Las secuencias estarán separadas solo por el caracter >
#######     Procedimiento	
#######     Creo un conjunto de arrays, (uno para cada archivo) 
#######     cada array guarda la informacion de todo su archivo y luego usaré la función join

	foreach $fastaTotal (@files){  ## Para cada archivo con nombre numerico

               print "trabajando el archivo $fastaTotal\n";
		$OpenFile="$directory/$fastaTotal"; #opening the file fastaTotal
		open(FILE,$OpenFile);
		@fasta=<FILE>; #Saving all its information in an array. Guardamos su informacion
		close FILE; ## Cerramos el archivo
                
	############3 Hago todo el archivo una sola cadena sin saltos de linea
		my $archivo=join("",@fasta); ## HAcemos una sola cadena
		$archivo=~s/\n//g;### Eliminamos saltos de linea
		my @cadenas=split(">",$archivo);###En el arreglo cadenas cortamos la linea gigante
						###siempre que aparezca el caracter >
		## Partiendo el archivo en secuencias de una linea separadas por el >
		shift @cadenas;#Quitando la primera cadena porque es vacia
		if ($verbose){print "##########################\n";}

	#################################################################
	
		if($verbose){### imprimiendo las cadenas para checar que este todas
			foreach $item (@cadenas) {print "Cadenas: $item\n";}
			print "##########################\n";
		}
	######################################################################

		for my $key ( @keys) { #recorro el array de las claves es decir los nombres de todos los 				
		#organismos
			if($verbose){	print "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n";
		        	print "KEY:$key\n"; 
			}       
			foreach $cadena (@cadenas){	# Para cada cadena
				$number=$cadena;
				$number=~s/([^0-9]*)//g;
				$subcadena=">"."org"."$number";
					
	              		if($verbose){print"Subcadena $subcadena Key $key \n";}
				if($subcadena eq $key){ # si corresponde realmente a su clave
				if ($verbose){print "########## Cadena $subcadena ";
				print "equal to Key $key ##########\n";}
				
					if($verbose){print "STRING $cadena \n" ;}
					$secuencia=substr($cadena,length($key)-1);## Obtengo la secuencia
					$HASH{$key}=$HASH{$key}.$secuencia;## Y la concateno al hash 
					####     En el lugar de su clave correspondiente
					 ### concateno esta secuencia a las de otros archivos peviamente 				
		concatenados 
					## del mismo organismo	
					if($verbose) {print "HASH de $key es $HASH{$key}\n ";}	
				}
			}

    		}
	}
}
####################################################################################################


####################################################################################################
sub EscribiendoSalida{  #######Necesita a HASH lleno
########## finalmente imprimo archivo de salida

###### Creo un archivo salida
	$EscribirSalida="$directory/SalidaConcatenada.txt";
	if($outputfile){$EscribirSalida=$outputfile;}
	open(OUTFILE,">$EscribirSalida");


	foreach $key (@keys){ ## Para cada clave de organismo
		#print "$key\n$HASH{$key}\n"; ###imprimo en pantalla su secuencia concatenada 
		print OUTFILE "$key\n$HASH{$key}\n";###imprimo en archivo salida la secuencia concatenada
		}## todo en formato fasta
	close OUTFILE; ## Y cierro el archivo de salida
	print"\n Se escribio archivo de salida $outputfile\n";
}

################################################################################################

exit;

