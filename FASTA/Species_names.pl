open FILE,  "$ARGV[0]" or die "USAGE: Species_names.pl <FILE> I cannot open the input FILE\n";

while ($line=<FILE>){
    if ($line=~/>gi/){
        $line=~/\>gi.(\d+).+\[(.+)\]/g;
	#print ">$1_";
	$GI="$1";
	$name="$2";
	$name=~s/\-//g;
	$name=~s/\.//g;
        $name=~s/\///g;
	$name=~s/\'//g;
        $name=~s/\(//g;
        $name=~s/\)//g;
        $name=~s/\#//g;
        $name=~s/\,//g;
        $name=~s/\://g;
        $name=~s/\*//g;
        $name=~s/\=//g;
        $name=~ s/\s/\_/g;
        
	print ">$GI\_$name\n";
    }
	else {
	  print $line;
	}
}
