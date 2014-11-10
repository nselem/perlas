open FILE,  "$ARGV[0]" or die "I can not open the input FILE\n";

$cont=0;

while ($line=<FILE>){
	chomp $line;
	$cont++;
	$mod=$cont%4;

	if ($mod==2){	
		#  if ($line=~/^[ATCGN]+$/){
		#	if ($mod!=2){print" $mod cont $cont \n";}
		#	print $line\n;
        	$length=length($line);
        	$Totallength+=$length;
        	}
    
	}

$read=$cont/4;
$average_length= $Totallength/$cont;

print "READS\=$read BASES\=$Totallength AVERAGE_LENGTH=$average_length\n";
