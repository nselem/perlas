############################## def-DBM #################################
use Fcntl ; use DB_File ; $tipoDB = "DB_File" ; $RWC = O_CREAT|O_RDWR
;
############################## def-SUB  ################################

my $tfm2 = "mi_hashNUMVia.db" ;
$hand2 = tie my %hashNUMVia, $tipoDB , "$tfm2" , 0 , 0644 ;
print "$! \nerror tie para $tfm2 \n" if ($hand2 eq "");

print "-$hashNUMVia{15}\n-";


open (VIAS, "/var/www/newevomining/PasosBioSin/concat/ALL.fasta");
#open (VIAS, "/var/www/newevomining/blast/pscp.blast");
$counter=0;
while (<VIAS>){
chomp;
  if($_ =~ />/){
     @nomb =split (/\|/, $_);
     $nomb[2]=~ s/_//;
     if(!exists $uniqVIA{$nomb[2]}){
        $uniqVIA{$nomb[2]}=$counter; ## hash qeu contiele relacion:via original --> numero de via general de trabajo
        $counter++;
	#print "llave: $nomb[2],  valor:$counter, \n";
     }
     $hashnombreVIA{$counter}=$nomb[2];
     #print "llave: $counter,  valor:$nomb[2] \n";
  }
}
