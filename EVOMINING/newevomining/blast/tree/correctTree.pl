open (FILE, "666.tree");
open (OUT, ">666_2.tree");
while(<FILE>){
 #chomp;
 $_ =~ s/_CORE_/|/g;
 $_ =~ s/\,(\d+)_(\w+)\:/,$1\|$2:/g;
 $_ =~ s/\,(\(+\d+)_(\w+):/,$1|$2:/g;
print OUT "$_";
#<STDIN>;
}
close FILE;
close OUT;
