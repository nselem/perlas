    use strict;
    use warnings;

my $file=$ARGV[0]; ##File to change
my $fileNames=$ARGV[1]; ##Informatio for the change
my %NAMES=read_names($fileNames);
changenames($file);

###### OrgS Hash de arrays
sub read_names{
	my $file=shift;
	my %ORGS;

	open (FILE,$file) or die "Could not open file";
	foreach my $line (<FILE>){
		chomp $line;
		my @sp=split("\t",$line);
		$ORGS{$sp[0]}=$sp[1];	
		#print"$sp[0] $ORGS{$sp[0]}\n"	
		}
	return %ORGS;
	}
###### OrgS Hash de arrays
sub changenames{
	my $file=shift;

	open (FILE,$file) or die "Could not open file $!";
	open (SALIDA, ">$file.changed") or die "Could not open file $!";
	foreach my $line (<FILE>){
		foreach my $id(keys %NAMES){
			if($line=~m/$id/g){
				print "$id\n";
				chomp $line;
				my $NAMES{$id};
				#my $new_name=$id."_".$NAMES{$id};
				$line=~s/$id/$new_name/g;
				print SALIDA "$line";
				}			

			}
		}
	close FILE; close SALIDA;
	}

