#print "This script will help you to find a core between genomes\n";
#print "How many genomes would you like to process?\n";
#my $NUM=<>;
#chomp $NUM;
use globals;
print "#$NUM#";
print "NAME: $NAME\n";
print "your dir $dir\n";
$infile="CORE";  ##Creará una carpeta asi
$outdir="$dir"."/"."$infile";
$lista="lista.$NUM";
$listaname="$NUM.lista";
$DesiredGenes="Core";

my $lista;

#`cp /home/fbg/lab/nselem/ORTHO/globals.pm .`;
#`cp /home/fbg/lab/nselem/ORTHO/header.pl .`;
#`cp /home/fbg/lab/nselem/ORTHO/allvsall.pl .`;
#`cp /home/fbg/lab/nselem/ORTHO/depuraANA.pl .`;
#`cp /home/fbg/lab/nselem/ORTHO/multiAlign_gb.pl .`;
#`cp /home/fbg/lab/nselem/ORTHO/SearchNucleotides.pl .`;
#`cp /home/fbg/lab/nselem/ORTHO/ChangeName.pl  .`;
#`cp /home/fbg/lab/nselem/ORTHO/EliminadorLineas.pl .`;
#`cp /home/fbg/lab/nselem/ORTHO/AlignByCodons.pl .`;



my $COUNT=1;
########### Creates a numbers lists
open (LISTA, ">>","lista.$NUM");

while  ( $COUNT <= $NUM ){
	print LISTA "$COUNT\n";
	
	$lista.=$COUNT;
	if($COUNT<$NUM){
		$lista.=",";
		}
	
	$COUNT=$COUNT+1;
	}

close LISTA;
#print "lista = $lista\n";
########### Step r Runs the blast all vs all
#header.pl
#/opt/ncbi-blast-2.2.28+/bin/makeblastdb -in Concatenados1.faa -dbtype prot -out Database.db
#/opt/ncbi-blast-2.2.28+/bin/blastp -db Database.db -query Concatenados1.faa -outfmt 6 -evalue 0.001 -num_threads 4 -out BLAST.blast
# `rm -r OUTSTAR`;
system(mkdir OUTSTAR);

#perl allvsall.pl -R 1,2,3,4,5,6,7,8,9 -v 0 -i BLAST.blast;
$COLS=$NUM+1;
$MIN=$NUM-1;

  system("cut -f2-$COLS ./OUTSTAR/Out_$lista.Ortho | sort | uniq -c |  awk '\$1>$MIN' >Core0");


open (CORE0,"<","Core0") or die "Could not open the file Core0:$!";
open (CORE,">","Core") or die "Could not open the file Core:$!";

for my $line (<CORE0>){
	$line=~s/\s*\d*\s*//;
	print CORE $line;
	}
close CORE0;
close CORE;
`rm Core0`;

open (LISTA,"<","lista.$NUM") or die "Could not open the file lista.$NUM:$!";
open (LISTAFAA,">","$NUM.lista") or die "Could not open the file $NUM.lista:$!";

for my $line (<LISTA>){
	chomp $line;
	$line.="\.faa\n";
	print LISTAFAA $line;
	}
close LISTA;
close LISTAFAA;

#`perl depuraANA.pl`;
#`rm lista.$NUM`;
