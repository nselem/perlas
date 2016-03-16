use strict;

my @CLUSTERS=qx/ls *.input/; 	## Read all input Uncomment to read all
my $list="";
my $relevant=0; #number of clusters with more than one coincidence
#open (HITS,">PrincipalHits") or die "couldnt open hits file";
#open (FASTA,">PrincipalHits.FASTA") or die "couldnt open hits file";

foreach my $context(@CLUSTERS){
	chomp $context;
	my $file=$context;
	$file=~s/.input//;
	print "$context\n";
	my $column=`cut -f4 $context`;
	my $firstline=`head -n 1 $context | cut -f7 `;
	chomp $firstline;
#	print "$context : _$firstline _\n";
#	print HITS "$firstline\n";

	my @content=split(/\n/,$column);
	my %seen;
	my @unique = grep { not $seen{$_} ++ } @content;
	print "@unique\n";
	if (@unique>2){print "OK\n";
		$relevant++;	
		$list=$list.$file.",";
		}
	else {	print "Voy a remover $file\n";
		`rm $file.input`;		
		`rm $file.input2`;
		`rm MINI/$file.faa`;
		}
	print "#################\n";
	}
chop $list;

open (FILE,"globalsFormat.pm") or die "Couldnt open file globals $!";
open (NEW,">globals2.pm") or die "Couldnt open file globals $!";
print "Modificando el modulo\n";
for my $line (<FILE>){
	chomp $line;

	if ($line=~/LIST/){
	$line=~s/\"\"/\"$list\"/;	
	}
	if ($line=~/NUM/){
	$line=~s/\"\"/\"$relevant\"/;	
	}
	print NEW "$line\n";
}

close FILE;
close NEW;
#close HITS;
#close FASTA;
print "El archivo globals2 fue reeescrito\n";
print "Se buscaran aminoácidos de hits principales encaso de No core\n";

###################333
#my @Content=readList();
#EscribiendoSalida(@Content);
#######################

#sub readList{
#
#	my $input="PrincipalHits";
#	my @LContent;
#	open (LISTA,"$input") or die "coudld not open file $input $!";
#	while (<LISTA>) {
#	chomp;
#	#print "#$_#\n";
#	push(@LContent,$_)
#	};
#	return @LContent;
#}

#sub EscribiendoSalida{  #######Necesita a @file lleno
########## finalmente imprimo archivo de salida
###### Creo un archivo salida
	
#	my (@Content)=@_;

#	foreach my $line (@Content){ ## Para cada clave de organismo
#		#print "$line";
#               my $g_file=&look_for_file($line);
#		my $gen=&look_for_gene($line,$g_file);
		
# 		print ">$line\n$gen\n";
	
#	}## todo en formato fasta

#}

#sub look_for_file{
#	my $id=shift;
#	$id=~s/fig\|//;
#	#print "ID $id";
#
#	chomp $id;
#	my @Grep=`grep -H '$id' GENOMES/*.faa`;
#
#	#print "grep -H $id GENOMES/* \n";
#	#print "GREP $Grep[0]";
#	my @name=split(":",$Grep[0]);
#	my $file=$name[0];
#	#print "FILE $file ##\n";	
#	return $file;
#}

#sub look_for_gene{
#	my $id=shift;
#	my $file=shift;	
#	#print "Id $id File $file\n ";
#	open(GENOME,$file);
#	#print "$file has benn opened\n";
#	my @genome=<GENOME>;
#	close GENOME;
##	my $text=join("",@genome);
##	my @pre_gen=split(">",$text);
#        
#	my %HASH;## Aqui ya sabe en que archivo esta el gen buscado gracias al grep
#	foreach my $line(@pre_gen){
#	#print "LINE $line\n";
#	my @gen=split("\n",$line);
#	my $secuence=$line;
#	$secuence=~s/fig\|[0-9]*.[0-9]*.peg.[0-9]*\n//;
#	$HASH{$gen[0]}=$secuence;
#	}
#	
#	foreach my $key (keys %HASH){
#	chomp $key;
#	my $test=$key;
#	#$test=">".$test;
#	#print "KEY $key TESt $test ID $id\n HASH $HASH{$key}";
#	if($id eq $test){
#	#print"LINE $key ID $id $HASH{$key}\n";
#	return $HASH{$key};
#	}
#	}
#}
