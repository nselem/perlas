############################## def-DBM #################################
use Fcntl ; use DB_File ; $tipoDB = "DB_File" ; $RWC = O_CREAT|O_RDWR
;
############################## def-SUB  ################################
#--- Generados con /var/www/newevomining/DB/reparaHEADER.pl------------------ 
my $tfm1A = "DB/hashOrdenNombres1.db" ;
$hand1A = tie my %hashNOMBRES, $tipoDB , "$tfm1A" , 0 , 0644 ;
print "$! \nerror tie para $tfm1A \n" if ($hand1A eq "");

my $tfm2A = "DB/hashOrdenNombres2.db" ;
$hand2A = tie my %hashNOMBRES2, $tipoDB , "$tfm2A" , 0 , 0644 ;
print "$! \nerror tie para $tfm2A \n" if ($hand2A eq "");
#----------------------------------------------------------------------------


foreach my $x (keys %hashNOMBRES2){
  print "$hashNOMBRES2{$x}\n";
  <STDIN>;
}
