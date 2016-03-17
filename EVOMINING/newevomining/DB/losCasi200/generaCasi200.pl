open(LIST,"../LITSOLD") or die $!;
open(BD,"../NellyDaniel/11Oct2015HEADER.fasta") or die $!;


while(<LIST>){
chomp;
$_ =~ s/\d+\.+\d+\s+//g;
$_ =~ 
#$_ =~ s/\*+/\t/g;
#@id_name=split(/\t/,$_);

 $hash{$_}=$_;
 print "$_\n$id_name[1]\n";
 <STDIN>;
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
