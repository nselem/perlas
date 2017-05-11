use strict;

# Este script utiliza el archivo de salida de FastOrtho (.end) y el archivo con los ID de RAST de cada genoma.

# Para instalar y utilizar FastOrtho se siguieron las instrucciones en https://github.com/grovesdixon/using_FastOrtho/blob/master/fastOrtho_local_WALKTHROUGH.txt

# El script tiene como salida una matriz de ausencia/presencia (ceros y unos), de cada familia de genes encontrada por FastOrtho, dentro de los genomas.


my $name="StreptOrtho.end";
my $R_Ids="RAST.IDs";

my %result= Splits($name);
my @genomes=GenoList($R_Ids);

foreach my $headline (@genomes){
	print ("\t$headline");
}
foreach my $key (keys %result){
	print("\n");	
	print "$key\t";
	foreach my $variable (@genomes){
		my $flag=0;
		foreach my $value (@{$result{$key}}){
			if ($variable eq $value){	
				$flag=1;	
			}
		}
		print "$flag\t";
	}
}


##########################################################################
sub GenoList{
	my $file = shift;
	my $list = `cut -f 1 $file`;
	my @array= split('\n',$list);
	return @array;
}
##########################################################################
sub Splits{
	my $nombre=shift;
	my %dictionary;
	open(FILE,$nombre)or die $!;
	#print("Se abrio el archivo $nombre\n");
	my $count=0;
    
	    foreach my $line (<FILE>){
		chomp $line;
		my @matrixArray=();
	       	my @st = split (/:/,$line);		
		my @first = split (/\s/,$st[0]);				
		$count++;
		#print ("linea $count : $first[0] \n");
		my @others = split (/\s/,$st[1]);
    		
		foreach my $line2 (@others){
			my @others2 = split (/\(/,$line2);						
			$others2[1]=~s/\)//;
			if ($others2[1]=~/\d+/){	
				push (@matrixArray,$others2[1]);				
			}	
		}	
		my %seen;
		my @unique = grep { not $seen{$_} ++ } @matrixArray;
		if(!exists $dictionary{$first[0]}) {$dictionary{$first[0]}=();}		
		@{$dictionary{$first[0]}}=@unique;			
		#print("$first[0] -> @unique-> $dictionary{$first[0]}\n");
	}
close FILE;
return %dictionary;
}
##########################################################################

#___________________________________________________________________________________________

