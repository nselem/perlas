use warnings;
use strict;
#
#Correrlo para todos menos para ciertos orgs

my $Rem_Total="1";
my $NumOrg="130";
my @List;

for(my $j=1;$j<=$NumOrg;$j++){
	#generateGlobal($j);
	#`perl OrthoGroups.pl`;
	$Core=`wc -l < core`;
	`rm globals.pm`;
	}

sub generateGlobal{
	my $j=shift;
	open (FILE, ">globals.pm") or die "Could not open file $!";

	my $string="";
	for(my $k=1;$k<$NumOrg;$k++){
		if ($k!=$j){
			$string.="$k,";			
			}
		}

	if ($j!=$NumOrg){
		$string.="$NumOrg";
		}
	else{
		chop($string)
		} 

	my $whitout=$NumOrg-$Rem_Total;

	print FILE "\$LIST =\"$string\"\;\n";                                             
	print FILE "\$NUM=\"$whitout\"\;\n";                                                  
	print FILE "\$NAME=\"ActinosIII_$j\"\;\n";                                     
	print FILE "\$BLAST=\"ActinosIII.blast\"\;";
	print FILE "\$dir=\"/home/nelly/Escritorio/ActinosIII/Genomas\"\;\n";       
	print FILE "\$e=\"0.001\"\;\n";                                             
	close FILE;

}
