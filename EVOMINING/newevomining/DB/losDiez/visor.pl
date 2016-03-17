
############################## HASH en disco #################################
use Fcntl ; use DB_File ; $tipoDB = "DB_File" ; $RWC = O_CREAT|O_RDWR
;
##############################################################################
my $tfm1A = "hashOrdenNombres1_10.db" ;
$hand1A = tie my %hashNOMBRES, $tipoDB , "$tfm1A" , 0 , 0644 ;
print "$! \nerror tie para $tfm1A \n" if ($hand1A eq "");

my $tfm2A = "hashOrdenNombres2_10.db" ;
$hand2A = tie my %hashOrdenNOMBRES, $tipoDB , "$tfm2A" , 0 , 0644 ;
print "$! \nerror tie para $tfm2A \n" if ($hand2A eq "");

my $tfm3A = "hashOrdenNombres3_10.db" ;
$hand3A = tie my %hashOrdenNOMBRES2, $tipoDB , "$tfm3A" , 0 , 0644 ;
print "$! \nerror tie para $tfm3A \n" if ($hand3A eq "");
#----------------------------------------------------------------------------


foreach my $x (sort keys %hashNOMBRES){
  print "$x->$hashNOMBRES{$x}\n";
  <STDIN>;
}
