open(FILE, "pscp9rep.blast");
while(<FILE>){
chomp;
@array=split(/\|/, $_);
#$hash{$array[1]}=$rray[1];
print "$array[1]\n";
#<STDIN>;
}

