open(LIST, "idRAST")or die $!;
while (<LIST>){
chomp;
 $_ =~ s/\r//g;
 $_ =~ s/\s//g;
 $hash{$_}=$_;
 #print "$_";
 #<STDIN>;
}
close LIST;

open(OUT, ">losCasi200.fasta") or die$!;
open(FILE, "../NellyDaniel/11Oct2015HEADER.fasta") or die$!;
while (<FILE>){
  chomp;
  if($_ =~ />/){
     $flag=0;
    @a=split(/\|/,$_);
    if(exists $hash{$a[2]} ){
      print OUT "$_\n";
      #<STDIN>;
      $flag=1;
    
    }
    
  }
  else{
    if($flag ==1){
     print OUT "$_\n";
     
    } 
  }
}
close FILE;
close OUT;
