#Ensamblado de genomas  

## I ANALISIS DE CALIDAD   
1. Analizar la calidad en fastqc   
`$./fastqc file`   
1.1 Contar el coverage   
`fastq_count.pl`    

##RECORTE DE SECUENCIAS DE MALA CALIDAD  

2. Correr el Trimmomatic   
`$ java -jar trimmomatic-0.32.jar PE MyGenomeDir/FB1AC3SS14-16_S12_L001_R1_001.fastq  MyGenomeDir/FB1AC3SS14-16_S12_L001_R2_001.fastq MyGenomeDir/output_forward_paired.fq.gz MyGenomeDir/output_forward_unpaired.fq.gz MyGenomeDir/output_reverse_paired.fq.gz MyGenomeDir/output_reverse_unpaired.fq.gz LEADING:33 TRAILING:33 MINLEN:200`  
  
2.1 Recontar el coverage con     
`script fastq_count.pl`  

## II ENSAMBLADO  
3. En mazorca   
3.1. Subir los archivos de salida del Trimmomatic a una carpeta  
Ejemplo: ENSAMBLADO/NOMBRE_DEL_GENOMA  

3.2 Editar el script Kmer.sh con el nombre del directorio del genoma    

3.3 Correr velvet con     
`$ qsub Kmer.sh`    

3.4 Escojer el mejor ensamblado leyendo el archivo RESULTS.txt en la carpeta del genoma  
## III Otros
Tabla de rendimiento   
Rendimiento sobre tamao de genoma:
Ejemplo 1G rendimiento , 4G Genome-size  
->  
1G/4G=>250X coverage  
