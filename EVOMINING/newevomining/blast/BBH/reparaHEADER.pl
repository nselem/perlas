open(FILE, "19gap.aln");
open(OUT, ">19gap.aln2");
while(<FILE>){
chomp;
 if($_ =~ />/){
   #print "antes: $_\n";
   $_ =~ s/\.|\-|=//g;
   print OUT "$_\n";
   #<STDIN>;
   $bandera=1;
 }
 else{
   if($bandera ==1){
     $_ =~ s/^.{1}//;
     $bandera=0;
   }
   print OUT "$_\n";
 }

}
close FILE;
close OUT;
