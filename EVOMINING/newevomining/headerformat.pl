open (FI ,"/var/www/newevomining/DB/ALLV2.fasta");
#open (FO ,">/var/www/newevomining/DB/ALLtempWS2.out");
while(<FI>){
chomp;
if ($_ =~ />/){
 $temp=$_;
 $_ =~ s/\s//g;
 $_ =~ s/\[|\]/\|/g;
 @arr =split(/\|/, $_);
 if($#arr < 5){
  print "$#arr---$temp\n";
 <STDIN>
 }
#print FO  "$_\n";
#<STDIN>;
}
else{
#print FO "$_\n";

}


}
#close FI;
#close FO;
