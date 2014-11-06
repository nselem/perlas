#PBS -N JP2_MG
#PBS -l nodes=1:ppn=8
#PBS -q ensam
#PBS -V

cd  $PBS_O_WORKDIR

DIR=ENSAMBLADO
## Kmer de tamanio 10 a 30 contando de 5 en 5 (10,15,20,...,30)
for i in {10..30..5}
do

/data/storage/software/velvet_1.2.10/velveth ${i} ${i} -fastq -shortPaired -separate $DIR/JP2A_1_p.fastq $DIR/JP2A_2_p.fastq -shortPaired2 -separate $DIR/JP2B_1_p.fastq JP2B_2_p.fastq -shortPaired3 -separate $DIR/JP2C_1_p.fastq $DIR/JP2C_2_p.fastq > velh.log

/data/storage/software/velvet_1.2.10/velvetg ${i} -ins_length 687  -ins_length_sd 350 -ins_length2 687  -ins_length_sd2 350 -ins_length3 687  -ins_length_sd3 350  -min_contig_lgth 1000 -scaffolding yes -exp_cov auto -cov_cutoff 5 > Velg.log

done

#rm ./*0/Sequences ./*0/PreGraph ./*0/LastGraph ./*0/Graph2 ./*0/Roadmaps ./*0/stats.txt ./*0/Graph2
#perl /home/pcruz/GENOMES/contador.pl >RESULTS.txt

