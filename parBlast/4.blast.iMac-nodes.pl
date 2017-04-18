#!/usr/bin/env perl

# Este script corre blastp de una base de datos contra si misma, 
# copia el archivo fasta a procesar y la base de datos de la iMac a los nodos del cluster
use warnings;
use strict;

### global parameters
##Directorio donde estan
my $in_path = "nelly\@10.10.100.156:/home/nelly/Escritorio/parBlast/input_split_blast";
## Donde esta la base de datos
my $db_path = "nelly\@10.10.100.156:/home/nelly/Escritorio/parBlast";
my $db_name = "Concatenados";
# Directorios de salida
my $out_path = "nelly\@10.10.100.156:/home/nelly/Escritorio/parBlast/blast_results_split";
my $log_path = "$ENV{HOME}/LOGS";
my $key_file = "fasta_files.txt";
my $evalue = 0.001;
my $format="\'6 std qlen\'";
# directorio temporal dentro del nodo
my $tmp_path = "/scratch/nselem"; # se cambio a /tmp/ por /scratch/, este posee mayor capacidad de almacenamiento
#my $tmp_path = "/tmp"; # se cambio a /tmp/ por /scratch/, este posee mayor capacidad de almacenamiento
#my $tmp_path = "/LUSTRE/usuario/nselem"; # se cambio a /tmp/ por /scratch/, este posee mayor capacidad de almacenamiento
### global parameters

system("scp $in_path/$key_file .");

# creamos directorios de salida
mkdir $out_path || die "couldn't create $out_path!\n";
mkdir $log_path || die "couldn't create $log_path!\n"; 
# OJO!!! El script falla si no se han creado previamente, el directorio de salida y el de logs en la iMac

open(IN, "<$key_file") || die "no se pudo abrir $key_file\n";
# leemos linea por linea el archivo que nos dira que archivos procesar
while(<IN>){
	my $line = $_;
	chomp($line);
	my $in_file = "$in_path/$line";	

   # ejemplo: 1.fsa
   my $in_tmp = $in_file;
   $in_tmp =~ s/$in_path/$tmp_path/;

   # archivo de salida
	my $out_file = $in_file;
	$out_file =~ s/$in_path/$out_path/;
	$out_file =~ s/.fsa$/.tab/;

   # archivo de reporte
	my $log_file = $in_file;
	$log_file =~ s/$in_path/$log_path/;
	$log_file =~ s/.fsa$/.log/;

	# Los archivos temporales (tmp) se usan dentro de los nodos
	my $out_tmp = $out_file;
	$out_tmp =~ s/$out_path/$tmp_path/;

	my $job_name = $in_file;
	$job_name =~ s/$in_path\///;
	$job_name =~ s/.fsa$/.blast/;
	
	if (-e $log_file){
		print "$log_file exists!\n";
	}else{
		print "$in_file -> $log_file\n\n";
		# Instruccion medular del script
		my $instruction = qq{echo "hostname;
rm -r $tmp_path;
mkdir $tmp_path; 
scp $in_file $tmp_path;
scp $db_path/$db_name* $tmp_path;
module load ncbi-blast+/2.2.31;
blastp -db $tmp_path/$db_name -num_threads 8 -query $in_tmp -outfmt $format -evalue $evalue -out $out_tmp;
scp $out_tmp $out_file; 
rm -r $tmp_path" | 
qsub -N $job_name -l nodes=1:ppn=8,vmem=8G,mem=8G,walltime=100:00:00 -V -o $log_file -j oe && touch $log_file};
	#       print "$instruction\n\n";
		$instruction =~ s/\n//g;
		system($instruction);
	}
}
close(IN);
## Instruccion principal comentada ##
## usamos qq{} para ahorrar el uso de comillas dobles, imprimimos el nombre del nodo en el que se realiza el trabajo
# my $instruction = qq{echo 'hostname; 
## Nos cambiamos al directorio de trabajo, home? sale sobrando porque usamos directorios explicitos
# cd \$PBS_O_WORKDIR;
## copiamos el archivo de entrada de la iMac al nodo en el que estamos trabajamdo 
# scp $in_file $tmp_path; 
## descomprimimos el archivo fastq .gz "on the fly"
# gzip -fdc $in_tmp | 
## llamamos a bowtie2, lo ejecutamos aprovechando 4 procesadores, especificamos el archivo de los indices, el archivo de los reads vie
ne de STDIN/de un pipe
# /data/storage/software/bowtie2-2.1.0/bowtie2 -p 4 -x $ebwt_file -U - | 
## guardamos el resultado en formato bam en el nodo
# /data/storage/software/samtools-0.1.18/samtools view -Sb - > $out_tmp; 
## borramos el archivo de entrada que fue copiado al nodo
# rm $in_tmp; 
## copiamos nuestro resultado del nodo a la iMac
# scp $out_tmp $out_file; 
## borramos nuestro resultado del nodo
# rm $out_tmp' | 
## especificaciones al sistema de colas, nombre del trabajo, recursos asignados, utilizar variables de ambiente del usuario, archivo a
 utilizar para almacenar el STDOUT, el std ouput y std error seran unidos en el std output, se "tocan" los archivos logs esto es en ca
so de no haber sido generados se crean archivos vacios
#qsub -N $in_file -l nodes=1:ppn=4,mem=8G,walltime=24:00:00 -V -o $log_file -j oe && touch $log_file};

