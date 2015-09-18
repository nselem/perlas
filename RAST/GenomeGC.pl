## En una carpeta se le aplicara a todos los faa y escribirá en standar output el resultado
use strict;
use warnings;

my $file = $ARGV[0];
#print "This is ¡$file!\n\n";

open (FILE, "$file") or die "Could not open file $!";
my $TOTAL=0;
my $A=0;
my $C=0;
my $G=0;
my $T=0;

for my $line(<FILE>){
	chomp $line;
	if (not $line=~m/>/){
		#print "$line\n";
		my @st=split("",$line);
		foreach my $char(@st){
			if($char eq'a'){$A++;}
			if($char eq'c'){$C++;}
			if($char eq'g'){$G++;}
			if($char eq't'){$T++;}
		}	
	}
}
close FILE;

my $GC=$G+$C;

$TOTAL=$A+$G+$C+$T;
my $percentage=$GC/$TOTAL;
#print "\n$TOTAL";
print "$file\t$percentage\n";

