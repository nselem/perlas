open(FILE,"68.aln");
while(<FILE>){
chomp;
if($_ =~ />/){
@a=split(/\|/,$_); 
$result="$a[1]|$a[5]";
$hash{$_}=$result;
#print "$result";
#<STDIN>;

}






}



open (IN, "seqf/ree/68.tree");
open (OUT, ">seqf/tree/68.tree4");
while (<IN>){
chomp;
if($_ =~ /$_/){
$_ =~ s/$_/$hash{$_}/g;

}
print OUT "$_\n";
}
