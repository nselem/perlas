#Para ensamblar genomas

######################################################################################################3
ANALISIS DE CALIDAD 
1. Analizo la calidad en fastqc
$./fastqc file
1.1 Cuento el coverage fastq_count.pl

######################################################################################################3
RECORTE DE SECUENCIAS DE MALA CALIDAD

2. Corro el Trimmomatic 
$ java -jar trimmomatic-0.32.jar PE U12-GV_FAST/FB1AC3SS14-16_S12_L001_R1_001.fastq  U12-GV_FAST/FB1AC3SS14-16_S12_L001_R2_001.fastq U12-GV_FAST/output_forward_paired.fq.gz U12-GV_FAST/output_forward_unpaired.fq.gz U12-GV_FAST/output_reverse_paired.fq.gz U12-GV_FAST/output_reverse_unpaired.fq.gz LEADING:33 TRAILING:33 MINLEN:200

2.1 Recuento el coverage con el script fastq_count.pl
######################################################################################################3
ENSAMBLADO

3. En mazorca 
3.1. Subo los archivos de salida del Trimmomatic a una carpeta
En mi caso ENSAMBLADO/NOMBRE_DEL_GENOMA

3.2 Edito el script Kmer.sh con el nombre del directorio del genoma

3.3 Corro el velvet con 
$ qsub Kmer.sh

3.4 Escojo el mejor leyendo el archivo RESULTS.txt en la carpeta del genoma

######################################################################################################3

