open(BLAST, "pscp10.blast");
open (OUT, ">pscp10rep3.blast");
while (<BLAST>){
chomp;
@a=split(/\t/,$_);
#print "$a[0]\n$a[1]\n$a[2]\n****";
#<STDIN>;

@array =split (/\|/, $a[1]);
$array[4] =~ s/\_//g;
$array[5] =~ s/\_//g;
#print "$array[7]\n";
#$array[7] =~ s/\.//g;
#$temp=join( "\|", @array);
#print "$temp\n";
#$_ =~ s/\_|\.//g;
#print "$_\n";
#<STDIN>;
$temp1=join("\|",@array);
$a[1]=$temp1."|";
$final=join("\t", @a);
print OUT "$final\n";
#print "$a[0]\n$a[1]\n$a[2]\n****";
#<STDIN>;

#print OUT "$a[0]\tray[5]\t$a[2]\t$a[3]\t$a[4]\t$a[5]\t$a[6]\t$a[7]\t$a[8]\t$a[9]\n";




}
close OUT;
close BLAST;
