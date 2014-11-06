open FILE,  "$ARGV[0]" or die "I can not open the input FILE\n";

while ($line=<FILE>){
    if ($line=~/^[ATCGN]+$/){
        $cont++;
        $length=length($line);
        $Totallength+=$length;
        
        }
    
}
$average_length= $Totallength/$cont;
print "READS\=$cont BASES\=$Totallength AVERAGE_LENGTH=$average_length\n";
