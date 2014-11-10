
use globals;

my $list=listas($NUM,$LIST);  #$list stores in a string the genomes that will be used
my @LISTA=split(",",$list);
#print "##lista $list## $LISTA[0] ## $LISTA[1]";

my $nucleotidos=1;
my $aminos=abs(1-$nucleotidos);
## Correr un blast dado un gen buscarlo en otros organismos de interés
## Anotar en un cuadro los figs, secuencias aminos, nucleótidos, anotación funcional, (columnas)
## Un organismo por línea

my $key="16s";
my $Seq= ">NCPPB382_16s
CATTTATGGAGAGTTTGATCCTGGCTCAGGACGAACGCTGGCGGCGTGCTTAACACATGC
AAGTCGAACGGTGATGTCAGAGCTTGCTCTGGCGGATCAGTGGCGAACGGGTGAGTAACA
CGTGAGTAACCTGCCCCCGACTCTGGGATAACTGCTAGAAATGGTAGCTAATACCGGATA
TGACGATTGGCCGCATGGTCTGGTCGTGGAAAGAATTTCGGTTGGGGATGGACTCGCGGC
CTATCAGGTTGTTGGTGAGGTAATGGCTCACCAAGCCTACGACGGGTAGCCGGCCTGAGA
GGGTGACCGGCCACACTGGGACTGAGACACGGCCCAGACTCCTACGGGAGGCAGCAGTGG
GGAATATTGCACAATGGGCGAAAGCCTGATGCAGCAACGCCGCGTGAGGGATGACGGCCT
TCGGGTTGTAAACCTCTTTTAGTAGGGAAGAAGCGAAAGTGACGGTACCTGCAGAAAAAG
CACCGGCTAACTACGTGCCAGCAGCCGCGGTAATACGTAGGGTGCAAGCGTTGTCCGGAA
TTATTGGGCGTAAAGAGCTCGTAGGCGGTTTGTCGCGTCTGCTGTGAAATCCCGAGGCTC
AACCTCGGGTCTGCAGTGGGTACGGGCAGACTAGAGTGCGGTAGGGGAGATTGGAATTCC
TGGTGTAGCGGTGGAATGCGCAGATATCAGGAGGAACACCGATGGCGAAGGCAGATCTCT
GGGCCGTAACTGACGCTGAGGAGCGAAAGCATGGGGAGCGAACAGGATTAGATACCCTGG
TAGTCCATGCCGTAAACGTTGGGAACTAGATGTGGGGACCATTCCACGGTCTCCGTGTCG
CAGCTAACGCATTAAGTTCCCCGCCTGGGGAGTACGGCCGCAAGGCTAAAACTCAAAGGA
ATTGACGGGGGCCCGCACAAGCGGCGGAGCATGCGGATTAATTCGATGCAACGCGAAGAA
CCTTACCAAGGCTTGACATATACCGGAAACATGCAGAAATGTGTGCCCCGCAAGGTCGGT
ATACAGGTGGTGCATGGTTGTCGTCAGCTCGTGTCGTGAGATGTTGGGTTAAGTCCCGCA
ACGAGCGCAACCCTCGTTCTATGTTGCCAGCACGTAATGGTGGGAACTCATAGGAGACTG
CCGGGGTCAACTCGGAGGAAGGTGGGGATGACGTCAAATCATCATGCCCCTTATGTCTTG
GGCTTCACGCATGCTACAATGGCCGGTACAAAGGGCTGCGATACCGTAAGGTGGAGCGAA
TCCCAAAAAGCCGGTCTCAGTTCGGATTGAGGTCTGCAACTCGACCTCATGAAGTCGGAG
TCGCTAGTAATCGCAGATCAGCAACGCTGCGGTGAATACGTTCCCGGGCCTTGTACACAC
CGCCCGTCAAGTCATGAAAGTCGGTAACACCCGAAGCCAGTGGCCTAACCGCAAGGGAGG
AGCTGTCGAAGGTGGGATCGGTGATTAGGACTAAGTCGTAACAAGGTAGCCGTACCGGAA
GGTGCGGCTGGATCACCTCCTTTCTAAGGA";

if ($nucleotidos==1){
	print"Doing blast database\n";
	header(@LISTA);
	makeDB();
}


open (SEQ, ">$key") or die "Could not open $key $!";
print SEQ $Seq;
close SEQ;
$eSeq=".00000000001";
blastSeq($eSeq);
#_____________________________________________________________________________________
sub blastSeq{
	my $e=shift;
	if (-e 	"$key.parser"){unlink ("$key.parser");}	if (-e 	"$key.BLAST"){unlink ("$key.BLAST");}
	`blastn -db NucDatabase.db -query $key -outfmt 6 -evalue $eSeq -num_threads 4 -out $key.BLAST`;
	`blastn -db NucDatabase.db -query $key -evalue $e -num_threads 4 -out $key.parser` ;
	open (PARSER,"$key.parser") or die "Could not open $key.parser $!";
	my %SEQ;
	my $name;
	foreach my $line (<PARSER>){
		chomp $line;
		
		if ($line=~m/>/){
			$name=$line;
			$SEQ{$name}="";
			#print "LINE $name\n";
			}
		if ($line=~/Sbjct/){
			#print "BEFORE $line\n";
			$line=~s/[^ACGT]//g;

			#print "AFTER $line\n";
			$SEQ{$name}.=$line;
			
			}
		}
	close PARSER;
	unlink ("$key.parser");

	open (PARSER,">$key.parser") or die "Could not open $key.parser $!";

	foreach my $KEY (keys %SEQ){
		print PARSER "$KEY\n$SEQ{$KEY}\n";
		}
	close PARSER;
	#if (-e BLAST ){system (rm -r BLAST);}
	#system(mkdir BLAST);
	#print "Se corrió el blast\n";
	#print "\nLista $list#\n";
	#print "Inicia búsqueda de listas de ortologos \n";
	}


sub listas{
	my $NUM=shift;
	my $LIST=shift;
	my $lista="";

	if ($LIST){ 
		print "Lista de genomas deseados $LIST";
		$lista=$LIST;
		}
	else {
		for( my $COUNT=1;$COUNT <= $NUM ;$COUNT++){
			$lista.=$COUNT;
			if($COUNT<$NUM){
				$lista.=",";
				}
			}
		}
	print "Se crearon listas del programa\n";
	print "Se agregó identificador de organismo a cada secuencia\n";

	return $lista;
		
	}

#_____________________________________________________________________________________
sub header{
	my @LISTA=@_;
	open(OUT, ">Concatenados.fna");

	foreach $num (@LISTA){
		#print "NUM $num\n";
	  	open(EACH, "$num.fna") or die "Could not open file $num.fna $!";
  		while($line=<EACH>){
		   	chomp($line);
    			if($line =~ />/){
			      print OUT "$line|$num\n";	
		    		}
    			else{
      				print OUT "$line\n";
    				} 
    			}#end while EACH
  		close EACH;
		#print "Acane el archivo $num\n";

		}#end 

	close OUT
	}

#_____________________________________________________________________________________
sub makeDB{
		print "Se realizo base de datos de nucleotidos \n";

	`makeblastdb -in Concatenados.fna -dbtype nucl -out NucDatabase.db`;

}
