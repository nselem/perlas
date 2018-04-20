use strict;
use warnings;

##### 
# `perl LiaMut2.pl DatosDate`
# author nselem84@gmail.com
## This script calculates the rutes between mutants
## At the end I keep by the results on rsults
my %Rutas;
my %STARTS;
my %PROFAR;
my %PRA;
my %RESULT;
my $fileData=$ARGV[0];
my $final="10.1";
my $restriction=0.002;

################################################################
##### Reading Data
open (FILE, $fileData) or die "Couldnt open file $fileData\n";

my $header=<FILE>;
foreach my $line (<FILE>){
	chomp $line;
	my @st=split("\t",$line);
	$st[0]=~m/(\d*)\.(\d*)/;
	my $variant=$2;
	if($variant==10){
		$st[0]=~s/($1)\.(10)/$1\.101/;
#		my $pause=<STDIN>;
		}
#	print "$st[0]-> pro $st[3] , pra $st[6]\n";
	$PRA{$st[0]}=$st[6];
	$PROFAR{$st[0]}=$st[3];
	}
#exit;

#	Mutated Residue										
#Variant	20	48	50	66	80	97	127	129	139	214	230
#PriA_Anc	1	1	1	1	1	1	1	1	1	1	1
#subHisA_Anc	0	0	0	0	0	0	0	0	0	0	0
#i	2.1	0	0	1	0	1	0	0	0	0	0	0
## Rutas contains information about which residue was mutated
### Manually constructed
$Rutas{2.1}="00101000000";$STARTS{2.1}="00101000000";
$Rutas{2.2}="10000010000";$STARTS{2.2}="10000010000";
$Rutas{2.3}="00100000100";$STARTS{2.3}="00100000100";
$Rutas{2.4}="01100000000";$STARTS{2.4}="01100000000";
$Rutas{2.5}="10100000000";$STARTS{2.5}="10100000000";
$Rutas{3.1}="00101000100";$STARTS{3.1}="00101000100";
$Rutas{3.2}="10100010000";$STARTS{3.2}="10100010000";
$Rutas{3.3}="10001010000";$STARTS{3.3}="10001010000";
$Rutas{3.4}="10100000100";$STARTS{3.4}="10100000100";
$Rutas{3.5}="01101000000";$STARTS{3.5}="01101000000";
$Rutas{3.6}="01100000100";$STARTS{3.6}="01100000100";
$Rutas{4.1}="10101000100";$STARTS{4.1}="10101000100";
$Rutas{4.2}="00101100100";$STARTS{4.2}="00101100100";
$Rutas{4.3}="00101000101";$STARTS{4.3}="00101000101";
$Rutas{4.4}="01101000100";$STARTS{4.4}="01101000100";
$Rutas{4.5}="10101010000";$STARTS{4.5}="10101010000";
$Rutas{4.6}="00101000110";$STARTS{4.6}="00101000110";
$Rutas{4.7}="00111000100";$STARTS{4.7}="00111000100";
$Rutas{4.8}="10100110000";$STARTS{4.8}="10100110000";
$Rutas{4.9}="01101100000";$STARTS{4.9}="01101100000";
$Rutas{4.101}="10001010100";$STARTS{4.101}="10001010100";
$Rutas{4.11}="10001110000";$STARTS{4.11}="10001110000";
$Rutas{4.12}="01100000110";$STARTS{4.12}="01100000110";
$Rutas{4.13}="11100000100";$STARTS{4.13}="11100000100";
$Rutas{5.1}="10101100100";$STARTS{5.1}="10101100100";
$Rutas{5.2}="11101000100";$STARTS{5.2}="11101000100";
$Rutas{5.3}="10101000101";$STARTS{5.3}="10101000101";
$Rutas{5.4}="01101000101";$STARTS{5.4}="01101000101";
$Rutas{5.5}="01101100100";$STARTS{5.5}="01101100100";
$Rutas{5.6}="00101100101";$STARTS{5.6}="00101100101";
$Rutas{5.7}="10101000110";$STARTS{5.7}="10101000110";
$Rutas{5.8}="00101000111";$STARTS{5.8}="00101000111";
$Rutas{5.9}="01101000110";$STARTS{5.9}="01101000110";
$Rutas{5.101}="10111000100";$STARTS{5.101}="10111000100";
$Rutas{5.11}="11100100100";$STARTS{5.11}="11100100100";
$Rutas{5.12}="00101100110";$STARTS{5.12}="00101100110";
$Rutas{5.13}="10101010100";$STARTS{5.13}="10101010100";
$Rutas{5.14}="11100000110";$STARTS{5.14}="11100000110";
$Rutas{5.15}="11100110000";$STARTS{5.15}="11100110000";
$Rutas{5.16}="00111000101";$STARTS{5.16}="00111000101";
$Rutas{5.17}="10101110000";$STARTS{5.17}="10101110000";
$Rutas{5.18}="11110000100";$STARTS{5.18}="11110000100";
$Rutas{6.1}="11101100100";$STARTS{6.1}="11101100100";
$Rutas{6.2}="11101000101";$STARTS{6.2}="11101000101";
$Rutas{6.3}="10111100100";$STARTS{6.3}="10111100100";
$Rutas{6.4}="11101000110";$STARTS{6.4}="11101000110";
$Rutas{6.5}="01101100101";$STARTS{6.5}="01101100101";
$Rutas{6.6}="10101100110";$STARTS{6.6}="10101100110";
$Rutas{6.7}="01101000111";$STARTS{6.7}="01101000111";
$Rutas{6.8}="10101000111";$STARTS{6.8}="10101000111";
$Rutas{6.9}="10101100101";$STARTS{6.9}="10101100101";
$Rutas{6.101}="11111000100";$STARTS{6.101}="11111000100";
$Rutas{6.11}="00101100111";$STARTS{6.11}="00101100111";
$Rutas{6.12}="01101100110";$STARTS{6.12}="01101100110";
$Rutas{6.13}="10101010110";$STARTS{6.13}="10101010110";
$Rutas{6.14}="11101010100";$STARTS{6.14}="11101010100";
$Rutas{6.15}="11101110000";$STARTS{6.15}="11101110000";
$Rutas{6.16}="10101110100";$STARTS{6.16}="10101110100";
$Rutas{6.17}="10111000101";$STARTS{6.17}="10111000101";
$Rutas{6.18}="11101001100";$STARTS{6.18}="11101001100";
$Rutas{7.1}="11101000111";$STARTS{7.1}="11101000111";
$Rutas{7.2}="11101100101";$STARTS{7.2}="11101100101";
$Rutas{7.3}="11101100110";$STARTS{7.3}="11101100110";
$Rutas{7.4}="10101100111";$STARTS{7.4}="10101100111";
$Rutas{7.5}="11111100100";$STARTS{7.5}="11111100100";
$Rutas{7.6}="10101110110";$STARTS{7.6}="10101110110";
$Rutas{7.14}="10101111100";$STARTS{7.14}="10101111100";
$Rutas{7.7}="11101010110";$STARTS{7.7}="11101010110";
$Rutas{7.8}="01101100111";$STARTS{7.8}="01101100111";
$Rutas{7.9}="11101110100";$STARTS{7.9}="11101110100";
$Rutas{7.101}="11101011100";$STARTS{7.101}="11101011100";
$Rutas{7.11}="10111100101";$STARTS{7.11}="10111100101";
$Rutas{7.12}="01111100101";$STARTS{7.12}="01111100101";
$Rutas{7.13}="11101110010";$STARTS{7.13}="11101110010";
$Rutas{8.1}="11101100111";$STARTS{8.1}="11101100111";
$Rutas{8.2}="11101110110";$STARTS{8.2}="11101110110";
$Rutas{8.3}="11111000111";$STARTS{8.3}="11111000111";
$Rutas{8.4}="11111100101";$STARTS{8.4}="11111100101";
$Rutas{8.5}="11101111100";$STARTS{8.5}="11101111100";
$Rutas{8.6}="11101011101";$STARTS{8.6}="11101011101";
$Rutas{8.7}="11101110011";$STARTS{8.7}="11101110011";
$Rutas{8.8}="10101111110";$STARTS{8.8}="10101111110";
$Rutas{9.1}="11111100111";$STARTS{9.1}="11111100111";
$Rutas{9.2}="11101110111";$STARTS{9.2}="11101110111";
$Rutas{9.3}="11101111110";$STARTS{9.3}="11101111110";
$Rutas{9.4}="11101011111";$STARTS{9.4}="11101011111";
$Rutas{10.1}="11101111111";$STARTS{10.1}="11101111111";
$Rutas{10.2}="11111110111";$STARTS{10.2}="11111110111";
$Rutas{11.1}="11111111111";$STARTS{11.1}="11111111111";

my $sec="";
Ruta($final,$sec);  ## Triunfé en la recursión
## Descomentar para imprimir todas las posibles rutas
my $count=0;

sub Ruta{
	my $goal=shift; ## donde quiero llegar
	my $sec=shift; 
	$count++;
	foreach my $key(sort keys %STARTS){
		## Aui selecciono que rutas quiero
		if ($PROFAR{$key}>=$restriction){
			##if ($PROFAR{$key}>=-1){
			## if ($PROFAR{$key}>=.004 and $PRA{$key}>=.0001){
			#print "$key->¡$STARTS{$key}!\n";
			#my $pause=<STDIN>;
		 	my @sp=split("",$STARTS{$key});
	         	my $size=scalar @sp;
		 	for (my $i=0;$i<$size;$i++){
		    		my @ruta_modificar=@sp;
		    		my $mut=($sp[$i]+1)%2;
				#  print "$i: $sp[$i] -> $mut\n"; 
		    		$ruta_modificar[$i]=$mut;
		    		my $posible=join('',@ruta_modificar);
		    		if (($key< (int $goal)) and $Rutas{$goal} eq $posible){
          				#print "->$key->$goal";
					#print "Count: $count \n";
					#print "key $key goal $goal\n";
					$sec.="\t$key";
					#$sec.=" $goal<-$key ";
					my $temp=$sec;
					#print "Temp $temp\n";
					#print "llamo ruta de $key, Sec $sec\n";
					#print "$sec\n";	
					if ($key < 3){
						#print $sec;
						print "$sec\n";# @RUTA\n";
						$count=0;
						#print"Fin de  ruta\n";
						#$sec="";
						}
					else {
						Ruta($key,$sec);
						}
					#$sec=~s/ $goal<-$key //;
					$sec=~s/\t$key//;
          				} ## end if 
    		    		} ## end for
			} ## End if PROFAR
		} ## end for
	}## end sub
exit;
