my $Group="1-40_MINUS_37";
my $directory="/home/fbg/lab/nselem/GRPAPER";
my $directoryNuc="/home/fbg/lab/nselem/GRPAPER/$Group/NUCLEOTIDOS";
my $directoryAmin="/home/fbg/lab/nselem/GRPAPER/$Group/ALIGNMENTS_GB";

#@RequiredFiles=(1,7,11,12,17,21,23,28,29,38,39,40,52,53,54,56,62,68,77,80,90,98,104,108,109,112,113,114,115,119,158,161,164,168,169,186,190,191,193,197,208,209,210,211,215,231,238,239);

#my @DesiredNamesNuc;
#my @DesiredNamesAmin;
my @RequiredFiles;
#for my $number (@RequiredFiles){
#	my $nameNuc=$number.".fasta.nucleotido";
#	push (@DesiredNamesNuc,$nameNuc);
#	my $nameAmin=$number.".orden.muscle";
#	push (@DesiredNamesAmin,$nameAmin);
#	}

###########################################
############ Main 
#print "@DesiredNames\n";
&GetFileNames;
chdir "$directory/RevTrans-1.4";
system(pwd);
&AlignFiles();
###############################################################################################
#################Subroutines
sub AlignFiles{
	for $number (@RequiredFiles){
print "`$directoryNuc/$number.fasta.nucleotido \n";
`python revtrans.py $directoryNuc/$number.fasta.nucleotido $directoryAmin/$number.orden.muscle -mtx 11 > $directoryNuc/$number.alg`;
	
		}

	}


##########################
sub GetFileNames{ ##Pondra en @files los nombres de los archivos que abriremos
#### Voy a abrir todos los archivos del directorio para llenar el arreglo files
	print"Voy a abrir $directoryAmin\n";
     opendir (DIR, $directoryAmin) or die $!;  ### Abriendo el directorio
                 while (my $file = readdir(DIR)) { ####leyendo todos los archivos
                         if (($file=~m/^\d/)&&($file=~m/gb/)&&($file=~m/.*[^htm]$/)){
                                 ######## Si el nombre del archivo empieza con un digito, contiene gb y no acaba con htm, lo guarda
				my $number=$file;	
				 $number=~s/([^0-9]*)//g;  ### En la cadena nombre elimino todo lo que no sea numero.
			        $nombre=$number."\.fasta"."\.nucleotido";
#        			print"Abriendo /directoryNuc"; 
				
				if (-e "$directoryNuc/$nombre"){
					push(@RequiredFiles,$number);
						
 					}
				else{
				print "Error No existe el archivo $nombre en nucleotidos";
					return;
				}	
				
                                if($verbose==$1 ){  print "The File $file will be open\n";}
                        }
                    }
   #print "Se abrio el directorio $directory con los archivos numericos\n\n";
   closedir DIR;
}

