###### Este script pone un identificador de organismo a cada rast id
use globals;

open(OUT, ">Concatenados.faa");
open(ALL, "lista.$NUM");


while(<ALL>){
chomp;
#print "$_\n";
# <STDIN>;
  open(EACH, "$_.faa");
  while($line=<EACH>){
   chomp($line);
    if($line =~ />/){
      print OUT "$line|$_\n";
      #<STDIN>;  
    }
    else{
      print OUT "$line\n";
    
    } 
    
    
  }#end while EACH
  close EACH;
}#end while ALL
close ALL;
close OUT

