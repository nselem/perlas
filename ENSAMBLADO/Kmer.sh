#PBS -N GVFAST
#PBS -l nodes=1:ppn=8
#PBS -q ensam
#PBS -V

cd  $PBS_O_WORKDIR

DIR=ENSAMBLADO/GVFAST
cd $DIR

pwd

## Kmer de tamanio 10 a 30 contando de 5 en 5 (10,15,20,...,30)
for i in {20..200..10}
do

/data/storage/software/velvet_1.2.10/velveth ${i} ${i} -fastq -shortPaired -separate output_forward_pairedA.fq output_reverse_pairedA.fq -shortPaired2 -separate output_forward_pairedB.fq output_reverse_pairedB.fq> velh.log

/data/storage/software/velvet_1.2.10/velvetg ${i} -ins_length 1174  -ins_length_sd 500 -ins_length2 1174  -ins_length_sd2 500 -min_contig_lgth 1000 -scaffolding yes -exp_cov 110 -cov_cutoff 15 > Velg.log

done

rm ./*0/Sequences ./*0/PreGraph ./*0/LastGraph ./*0/Graph2 ./*0/Roadmaps ./*0/stats.txt ./*0/Graph2
perl /home/nselem/contador.pl >RESULTS.txt

