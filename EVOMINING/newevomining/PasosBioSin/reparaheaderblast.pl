open (FILE, "pscpGENOMESDB_300120015repairedVSALL_curado.blast");
open (OUT, ">pscpGENOMESDB_300120015repairedVSALL_curadoHEADER.blast");
while(<FILE>){
chomp;
  #print "$_\n";
  @a=split(/\t/, $_);
  @b=split(/\|/, $a[0]);
  $b[5]=~ s/_//g;
  $a[0]  = join("|", @b);
  $a[0]  ="$a[0]|";
  $_  = join("\t", @a);
  print OUT "$_\n";
  #<STDIN>;
}
close FILE;
close OUT;
