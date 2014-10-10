open(OUT, ">Concatenados1.faa");
open(ALL, "lista.46");


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

