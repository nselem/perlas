#!/usr/local/bin/perl -w

###############################################################################################################
############Este archivo remueve saltos de lineas dobles
#################################################################################################################
#################### Global variables 
 my $infile="ACTINOS";

  #my $directory =  '/home/fbg/lab/ana/RASTtk/1-47_MINUS_27/CONCATENADOS';
  my $directory =  "/home/fbg/lab/ana/RASTtk/$infile/NUCLEOTIDOS";
##################################################################################################################




#### Voy a abrir todos los archivos del directorio para llenar el arreglo files
     opendir (DIR, $directory) or die $!;  ### Abriendo el directorio
                 while (my $file = readdir(DIR)) { ####leyendo todos los archivos
#			$file=$directory."/".$file;
                         if (($file=~m/^\d/)&&($file=~m/^((?!pir).)*$/)){ ######## Si el nombre del archivo empieza con un digito
	  		`perl -pi -e "s/^\n//" $file`;            ####Removiendo saltos dobles                    
			 my $lineCount=`wc -l $file `;    ###### Contando lineas
			print "File $file has $lineCount lines\n";## Imprimiendo numero de lineas en pantalla
                        }
                    }
   print "Se abrio el directorio $directory con los archivos numericos\n\n";
   closedir DIR;

