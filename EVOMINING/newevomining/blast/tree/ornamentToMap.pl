open (FILE,"ls.ornament");
while(<FILE>){
chomp;
 open (FI, "$_");
 $aux=$_;
 $aux=~s/ornament\.//;
 $aux2="$aux.map";
 open (OUT, ">$aux2");
 while ($line=<FI>){
  chomp($line); 
  $line =~ s/"<circle style='fill:red;stroke:black' r='8'\/>"/"stroke-width:4; stroke:red"/;
  $line =~ s/"<circle style='fill:green;stroke:black' r='4'\/>"/"stroke-width:2; stroke:green"/;
  print OUT "$line\n";
  #<STDIN>;
 
 
 }
}
