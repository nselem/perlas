
open(TOT, "ls.viasB");
while($line=<TOT>){
chomp($line);
  open (FILE, "preDB/$line");
  $line =~ s/\.fasta/newHEADER.fasta/;
  open (OUT, ">$line");
  
  while(<FILE>){
     chomp;
     if(!$_){
       next;
     }
      if($_=~ />/){
        $_ =~ s/\s//g;
 
      }
      print OUT "$_\n";
      #<STDIN>;
  }
  close FILE;
  close OUT;
}
close TOT;
