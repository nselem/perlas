###############################################################
############   Declare Functions  ############################
###############################################################
sub CleanFile;

###############################################################
############		Main     ##############################
CleanFile;

###############################################################
###############################################################

sub CleanFile{
	open FILE,  "$ARGV[0]" or die "I can not open the input FILE\n";
	open (SALIDA, ">$ARGV[1]" );
	while (my $line=<FILE>){
		chomp $line;
		if ($line=~/>/){
			print "$line\n";
			@Name=split(" ",$line);
			print"$Name[0]#\n";
			$line="";
			$line=$Name[0];
			}
		print SALIDA "$line\n";
		}
	close SALIDA;
}

