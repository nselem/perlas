open(LIST,"lista10") or die $!;
open(BD,"../NellyDaniel/11Oct2015HEADER.fasta") or die $!;


while(<LIST>){
chomp;
 $hash{$_}=$_;
 #print "---$_\n";
}
close LIST;
#print "hash loaded\n";
#<STDIN>;

while(<BD>){
chomp;
 if($_ =~ />/){
   @a =split(/\|/, $_);
   if(exists $hash{$a[5]}){
     $header=$_;
     $flag=1;
     print "$_\n";
    # <STDIN>;
   }
   else {
      $flag=0;
   }
 }
 else{
   if ($flag==1){
     print "$_\n";
   }
 
 }


}#end while
