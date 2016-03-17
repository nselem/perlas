open (H, "/var/www/newevomining/hash.log");
while(<H>){
  chomp;
  $_ =~ s/===.*---/,/;
  @w=split(/,/,$_);
  print "@w";
  <STDIN>;

}

open (D, "distance.4");
while (<D>){
chomp;
 @a=split("\t", $_);
 $hash{$a[1]}=$a[0];
 #print "$_\n";
 #<STDIN>;

}
close D;
$cont=0;
foreach my $x (sort{$b<=>$a} keys %hash){
 
 @num=split(//,$x);
 $equal=$num[0].$num[1].$num[2].$num[3];
   if(exists $comp{$equal}){
     push(@important,$hash{$x});
     
   } 
   elsif($cont ==0) {
      $comp{$equal}=$x;
      push(@important,$hash{$x});
      $cont++;
   }   
 #print "$hash{$x}\n";
 #<STDIN>;

}



foreach my $y (@important){
  print "$y\n";
  <STDIN>;

}
