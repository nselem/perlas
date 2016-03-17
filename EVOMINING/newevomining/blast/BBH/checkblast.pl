open (FILE, "pscpNellyDaniel240915.blast");
while (<FILE>){
chomp;
 @a=split(/\t/, $_);
 @b=split(/\|/,$a[1]);
 #if($b[5] eq 'StreptomycesspGBA9410s' and $a[11] >= 50){
 if( $b[3] == 1421){
     print "$_";
     <STDIN>;
 }

}#end while
