$infile="NUEVOCORE";
$lista="lista.nuevocore";
$Working_dir="/home/fbg/lab/ana/RASTtk/$infile";
system "rm -r /home/fbg/lab/ana/RASTtk/$infile/ALIGNMENTS_GB/";
system "mkdir /home/fbg/lab/ana/RASTtk/$infile/ALIGNMENTS_GB/";
###############################################################################################
##############################################
$TOTAL=203;
$NumOrg=47;

open (LS, "$lista") or die $!;
while (<LS>){
 chomp;
  push(@lista0, $_);
}

print ("@lista0\n");
for($gen=1;$gen<=$TOTAL;$gen++){
	&align($gen);
	}
######## 
sub align{
#print "#$_[0]#";
system "muscle -in $Working_dir/FASTAINTER/$_[0].interFastatodos -out $Working_dir/ALIGNMENTS_GB/$_[0].muscle.pir -fasta -quiet -group";
	$nombre="$Working_dir/ALIGNMENTS_GB/$_[0].muscle.pir";
	open(FILE2,$nombre)or die $!;
	print("Se abrio el archivo $nombre\n");
	@content=<FILE2>;
	foreach $line (@content){
		#print" $line";
		if($line =~ />/){
                                chomp;
                                $headerFasta=$line;
                                $org=$line;
				chomp $org;
                        	$org=~s/>fig\|*.*.peg.*\|//g; #Obtengo el indicador de organismo
                                $hashFastaH{$org}=$headerFasta;
                        }
                        else{
                               # $line =~ s/\*//g;
                                $hashFastaH{$org}=$hashFastaH{$org}.$line;
                                #print"$headerFasta => $hashFastaH{$headerFasta}\n";

                        }


	}
	
	open ORDEN,">$Working_dir/ALIGNMENTS_GB/$_[0].orden.muscle" or die $!;

	 for ($i=1;$i<=$NumOrg;$i++){
		#foreach $i (keys %hashFastaH){
         	#print("KEY:#$i# VALUE:$hashFastaH{$i} \n");
		if ($i~~@lista0){
		print ORDEN "$hashFastaH{$i}";
		}
	}
	close ORDEN;
	#print @content;  ### Anaaa que eran las opciones del Gblocks??
	system "/opt/Gblocks_0.91b/Gblocks $Working_dir/ALIGNMENTS_GB/$_[0].orden.muscle -b4=5 -b5=n -b3=5";
	close(FILE2);
}
############################################
	
print "TERMINE DE ALINEAR Y RECORTAR CON GBLOCK\n";


