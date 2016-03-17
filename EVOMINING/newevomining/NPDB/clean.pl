open (FILE, "NP_DB_NOVEMBER2014.txt");
open (OUT, ">NP_DB_NOVEMBER2014clean.txt");

while(<FILE>){
chomp;
 $_ =~ s/\r//g;
 if($_ eq '' ){
   next;
 }
 if($_ !~ />/){
   $_ =~ s/\-//g;
 }
 print OUT "$_\n";
}

close FILE;
close OUT;
#################indexar BDNP#######################
system "makeblastdb -dbtype prot -in NP_DB_NOVEMBER2014clean.txt -out NP_DB_NOVEMBER2014clean.db";
