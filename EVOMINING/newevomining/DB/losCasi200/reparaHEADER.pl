###################################################
# reparaHAEDER.pl
#
# modifica encabezado de fastas de genomas para
# funcionar con evomining
#
# cmartinez@langebio.cinvestav.mx
#
# INPUT: genomas en formato fasta.
#
# OUTPUT: genoma  en formato para evomining
#         con 6 campos divididos por pipes, sin
#         parentesis, corchetes, apostrofes, 
#         guiones, caracteres vacios.
#
#         Adicionalmente genera hash en Disco que
#         se utilizaran para generar el heatplot
#         en evom-0-3.pl
# 
#
# OPCIONAL: makeblasdb y blast.
#
###################################################

############################## HASH en disco #################################
use Fcntl ; use DB_File ; $tipoDB = "DB_File" ; $RWC = O_CREAT|O_RDWR
;
##############################################################################
my $tfm1A = "hashOrdenNombres1_old.db" ;
$hand1A = tie my %hashNOMBRES, $tipoDB , "$tfm1A" , $RWC , 0644 ;
print "$! \nerror tie para $tfm1A \n" if ($hand1A eq "");

my $tfm2A = "hashOrdenNombres2_old.db" ;
$hand2A = tie my %hashOrdenNOMBRES, $tipoDB , "$tfm2A" , $RWC , 0644 ;
print "$! \nerror tie para $tfm2A \n" if ($hand2A eq "");

my $tfm3A = "hashOrdenNombres3_old.db" ;
$hand3A = tie my %hashOrdenNOMBRES2, $tipoDB , "$tfm3A" , $RWC , 0644 ;
print "$! \nerror tie para $tfm3A \n" if ($hand3A eq "");
#----------------------------------------------------------------------------



#-------------CONFIGURACION------------------------

# $genomes="GENOMESDB_230220015.fasta";
# $genomesOUT="GENOMESDB_230220015HEADER.fasta";
# $genomesOUTDB="GENOMESDB_230220015HEADER.fasta.db";
# $MEtCentral="tRAPs_EvoMining.fa";
#$genomes="NellyDaniel/Todos";
#$genomesOUT="NellyDaniel/TodosHEADER.fasta";
#$genomesOUTDB="NellyDaniel/TodosHEADER.fasta.db";

 $genomes="losCasi200.fasta";
 $genomesOUT="losCasi200HEADER.fasta";
 $genomesOUTDB="losCasi200HEADER.db";
 #$MEtCentral="tRAPs_EvoMining.fa";
 $MEtCentral="ALL_curado.fasta";
 $listaNombres="listaold";
 
 
#--------------------------------------------------


open (DB, "$genomes") or die $!;
open (DBOUT, ">$genomesOUT")or die $!;
open (NAMESOUT, ">$listaNombres")or die $!;
open (HASHESOUT, ">HASHESnombres")or die $!;# solo para ver como qeudaria el hash en disco

$counting=0;
while (<DB>){
chomp;
  if($_ =~ />/){ 
   #$_=~s/\n/\|\n/;	
   #@ar=split(/\|/,$_);
  # if($#ar == 5){#>gi|E96434_23447|gb|E96434_23447| Gb|AAF35419.1 [Streptomyces_sp_CS022]
    # $_=$ar[0]."|".$ar[1]."|".$ar[2]."|".$ar[3]."|".$ar[4].$ar[5];
     
  # }
  # else {
  #    # se probo el formato:
  # }
      
   #$_ =~ s/\]\n/\|\n/;  #>gi|E96434_23447|gb|E96434_23447| Gb|AAF35419.1 [Streptomyces_sp_CS022]
   #$_ =~ s/\[/&&&/;  #>gi|E96434_23447|gb|E96434_23447| Gb|AAF35419.1 [Streptomyces_sp_CS022]
   #$_ =~ s/\[(\w+)\|\n/\|$1\|\n/;  #>gi|E96434_23447|gb|E96434_23447| Gb|AAF35419.1 [Streptomyces_sp_CS022]
   #$_ =~ s/&&&(\w+)\]/$1/;  #>gi|E96434_23447|gb|E96434_23447| Gb|AAF35419.1 [Streptomyces_sp_CS022]
   #$_ =~ s/&&&(\w+)\|\n/\|$1\|\n/;  #>gi|E96434_23447|gb|E96434_23447| Gb|AAF35419.1 [Streptomyces_sp_CS022]
   #$_ =~ s/\]|\[\n//g;
   $_ =~ s/\]|\[//g;
   $_ =~ s/&&&//;
    $_ =~ s/\+//g;
    $_ =~ s/\-//g;
    $_ =~ s/\r//g;
    $_ =~ s/\://g;
    #$_ =~ s/\|\s/|/g;   #>gi|E96434_23447|gb|E96434_23447| Gb|AAF35419.1 [Streptomyces_sp_CS022]
    #$_ =~ s/\s\|/|/g;  #>gi|E96434_23447|gb|E96434_23447| Gb|AAF35419.1 [Streptomyces_sp_CS022]
     $_ =~ s/\s\s/\s/g;
    $_ =~ s/ /_/g;
    $_ =~ s/\'/_/g;
    #$_ =~ s/\(//g;
#    $_ =~ s/\.//g;
    $_ =~ s/\,//g;
    $_ =~ s/\///g;
    $_ =~ s/\(//g;
    $_ =~ s/\)//g;
    @arr=split(/\|/,$_);
    @arr=split(/\|/,$_);
    #print "$_\n";
    $arr[$#arr]=~ s/\.//g;
    $legible=$arr[$#arr];
    print NAMESOUT "$legible\t";   #Legible
    $arr[$#arr]=~ s/\_//g;
    $arr[$#arr]=~ s/ //g;
    print NAMESOUT "$arr[$#arr]\n";	#nombre concatenado
    
    $_=join("\|",@arr);  
     #<STDIN>;
    print DBOUT "$_\n";
    
    #if(!exists $hashUniq{$arr[$#arr]} and $arr[$#arr] =~ /\w/){
    if(!exists $hashUniq{$arr[$#arr]}){
       $hashNOMBRES{$arr[$#arr]}=$legible;
       $hashOrdenNOMBRES{$legible}=$counting;
       $hashOrdenNOMBRES2{$counting}=$legible;
       print HASHESOUT qq/\$hashNOMBRES{'$arr[$#arr]'}="$legible";-->$hashNOMBRES{$arr[$#arr]}\n/;
       print HASHESOUT qq/\$hashOrdenNOMBRES{'$arr[$#arr]'}=$counting;-->$hashOrdenNOMBRES{$legible}\n/;
       print HASHESOUT qq/\$hashOrdenNOMBRES2{$counting}="$arr[$#arr]";-->$hashOrdenNOMBRES2{$counting}\n\n\n/;
       $hashUniq{$arr[$#arr]}=1;
       $counting++;
    }
    
    
    
    #<STDIN>;
  }
  else {
    print DBOUT "$_\n";
  
  }
}

close DB;
close DBOUT;
close NAMESOUT;
close HASHESOUT;
#untie %hashNOMBRES;
#untie %hashNOMBRES2;
#sudo rm ultimosPAblo/new_genomesrepaired.db*
#sudo rm ultimosPAblo/pscp30012015prueba.blast
#sudo rm ../blast/pscp30012015.blast

print "Indexando base de datos...\n";
system "makeblastdb -dbtype prot -in $genomesOUT -out $genomesOUTDB";
print "blast...\n";
system "blastp -db $genomesOUTDB -query ../../PasosBioSin/$MEtCentral -outfmt 6 -num_threads 4 -evalue 0.0001 -out ../../blast/pscporigina190216.blast";
#print "concatenando base de datos ../blast/pscp10rep3.blast con ultimosPAblo/pscp30012015prueba.blast, resultado en ../blast/pscp30012015.blast\n";
#system "cat ../blast/pscp10rep3.blast ultimosPAblo/pscp30012015prueba.blast >../blast/pscp30012015.blast";
print "Finished!!\n";

