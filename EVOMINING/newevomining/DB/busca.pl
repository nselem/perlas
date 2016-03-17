open(LIST,"listamil") or die $!;
open(OUT,">finalID") or die $!;
open(OUTT,">oldSII") or die $!;
while(<LIST>){
 chomp;
 @b=split(/\t/,$_); 
  @a=split(/\s/,$b[1]);
 $r=$a[1].$a[2];
 $r =~ s/\.//g;
 print "\n**$r\n---$_\n";
 $sys= `grep '$r' listanombresOLD`;
 if($sys)
 {
   print "\n**fin  $sys\n";
   $next=<STDIN>;
   chomp($next);

   if($next eq 's'){
    #print "ENTROOOOOO";
    #<STDIN>;
    print OUT "$_\n";
    print OUTT "$sys";
    #close OUT;
    #close OUTT;
    #exit(1);
   }
 #
}

}
