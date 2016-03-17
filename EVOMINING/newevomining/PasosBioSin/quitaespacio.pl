open(FILE, "ALL_curado.fasta");
open (OUT, ">ALL_curadoHEADER.fast");
while (<FILE>){
chomp;
  if($_ =~ />/){ 
     #$_ =~ s/\_//g;
     @a=split(/\|/, $_);
     $a[2]=~s/\_//g;
      print OUT "$a[0]|$a[1]|$a[2]|$a[3]\n";

 }
 else{
    print OUT "$_\n";
  }

}#end while
