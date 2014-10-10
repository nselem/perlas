#Abrir la carpeta ALIGMENTS_GB
# Crear el directorio NUCLEOTIDES
#!/usr/local/bin/perl -w
use Getopt::Long;
### LE doy unal ista de pegs y los genomas
## Y me anota las secuencias de mainoacidos en una archivo

# Lista de ids de aminoacidos
# Buscar el archivo, 
# Buscar el gen, escribirlo en archivo salida

$file="Coomons_Luteus_FAST"; 
my $full = "/home/fbg/lab/nselem/CLAVIBACTER/SEGUNDA_CON_GENOMAS_AGUA_FAST/$file";
 my $GenomePATH = "/home/fbg/lab/nselem/CLAVIBACTER/SEGUNDA_CON_GENOMAS_AGUA_FAST"; 

my $out_directory = "/home/fbg/lab/nselem/CLAVIBACTER/SEGUNDA_CON_GENOMAS_AGUA_FAST/AMINOACIDS";
if (-e $out_directory){`rm -r $out_directory `;}
`mkdir $out_directory`;

###################333
my @Content=readList($full);
EscribiendoSalida(@Content);
#######################

sub readList{

	my $input=shift;
	my @LContent=@_;
	open (LISTA,"$input") or die "coudld not open file $file $!";
	while (<LISTA>) {
	chomp;
	#print "#$_#\n";
	push(@LContent,$_)
	};
	return @LContent;
}

sub EscribiendoSalida{  #######Necesita a @file lleno
########## finalmente imprimo archivo de salida
###### Creo un archivo salida
	
	my (@Content)=@_;

	foreach $line (@Content){ ## Para cada clave de organismo
		#print "$line";
                my $g_file=&look_for_file($line);
		my $gen=&look_for_gene($line,$g_file);
		
 		print ">$line\n$gen\n";
	
	}## todo en formato fasta

	################ Ahora si escribiendo la salida##################
	#open (OUTFILE,">$out_directory/Aminoacidos.txt");
        #print OUTFILE ">$line\n$gen\n";
	
#	close OUTFILE; ## Y cierro el archivo de salida
#	print"\n Se escribio archivo de salida $nombre\n";
}

sub look_for_file{
	my $id=shift;
	$id=~s/fig\|//;
	#print "ID $id";

	chomp $id;
	##print "$id $GenomePATH\n";
	my @Grep=`grep -H '$id' *.faa`;

	#print "grep -H $id /home/fbg/lab/nselem/RASTtemp/* \n";
	#print "GREP $Grep[0]";
	my @name=split(":",$Grep[0]);
	my $file=$name[0];
	#print "FILE $file ##\n";	
	return $file;
}
sub look_for_gene{
	my $id=shift;
	my $file=shift;	
	#print "Id $id File $file\n ";
	open(GENOME,$file);
	#print "$file has benn opened\n";
	my @genome=<GENOME>;
	close GENOME;
	my $text=join("",@genome);
	my @pre_gen=split(">",$text);
        
	my %HASH;## Aqui ya sabe en que archivo esta el gen buscado gracias al grep
	foreach my $line(@pre_gen){
	#print "LINE $line\n";
	my @gen=split("\n",$line);
	$secuence=$line;
	$secuence=~s/fig\|[0-9]*.[0-9]*.peg.[0-9]*\n//;
	$HASH{$gen[0]}=$secuence;
	}
	
	foreach my $key (keys %HASH){
	chomp $key;
	my $test=$key;
	#$test=">".$test;
	#print "KEY $key TESt $test ID $id\n HASH $HASH{$key}";
	if($id eq $test){
	#print"LINE $key ID $id $HASH{$key}\n";
	return $HASH{$key};
	}
	}
}

