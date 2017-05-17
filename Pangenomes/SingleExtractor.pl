use strict;
no warnings 'experimental::smartmatch';


# Singletons are part of the pangenome, so they must be considered to create a rarefaction curve. This script extract the singletons from the genomes that were left out by FastOrtho.

# For this script to work, it needs to be placed in a directory with all the genomes used by FastOrtho, it also needs the .end output file from FastOrtho and RAST IDs file.  


my $name="CmmOnly_Ortho.end";
my $R_Ids="RASTCmmOnly";
`grep '>' *faa > AllGene`;
my $nom="AllGene";
my @genomes=GenoList($R_Ids);

my %diccionarioORTHO=dicORTHO($name);
my %diccionarioRAST=dicRAST($nom);
my %SINGLETON;
	
## Recorre ORTHO cada clave, imprimirla
foreach my $key (keys %diccionarioORTHO){
	if(!exists $SINGLETON{$key}) {$SINGLETON{$key}=();}
			
	#print("\n");	
	#print "$key\t";
	foreach my $gen (@{$diccionarioRAST{$key}}){
		if (!($gen~~@{$diccionarioORTHO{$key}})){
			push (@{$SINGLETON{$key}},$gen);
			}  	
		}
	
}
## (~~) REcorrer preguntar quienes RAST(esa clave) estan en ORTHO
## imprimir los que estan
foreach my $key (keys %SINGLETON){
	#print("SINGLETON \n");	
	#print "$key\n";
	#print ("@{$SINGLETON{$key}}\n");
	my $counter=1;
	foreach my $element (@{$SINGLETON{$key}}){
	my $line="SINGLE".$key.".".$counter.": ".$element."\(".$key."\)\n";
	print($line);
	$counter++;	
	}
}
#ORTHOMCL4765 (2 genes,2 taxa):	 fig|6666666.237812.peg.2077|434531(434531) fig|6666666.26261.peg.627|69140(69140)

######################################################################################
sub dicRAST{
	my $nom= shift;
	my %diccionario;
	open(FILE,$nom)or die $!;
	foreach my $line (<FILE>) {
		chomp $line;	
		#print("$line\n");	
		my @st= split(/\|/,$line);
		#print("$st[1]\n");
		#print("$st[2]\n");
		if(!exists $diccionario{$st[2]}) {$diccionario{$st[2]}=();}
		push (@{$diccionario{$st[2]}},"fig"."\|".$st[1]);  
	}
	close FILE;
	return %diccionario;
}
######################################################################################
sub dicORTHO{

	my $name=shift;
	my %diccionario;
	open(FILE,$name)or die $!;

	foreach my $line (<FILE>) {
		chomp $line;
		my @st = split (/:/,$line);
		#print ("$st[1]\n");
		my @st2= split (/\s/,$st[1]);
		foreach my $line2 (@st2){
			my @st3 = split (/\(/,$line2);
			$st3[1]=~s/\)//;
			$st3[0]=~s/\|$st3[1]//;
			#print ("$st3[1] $st3[0] \n");
			if(!exists $diccionario{$st3[1]}) {$diccionario{$st3[1]}=();}
			push (@{$diccionario{$st3[1]}},$st3[0]);	
		}
	}
	close FILE;
	return %diccionario;
}


####################################################################
sub GenoList{
	my $file = shift;
	my $list = `cut -f 1 $file`;
	my @array= split('\n',$list);
	return @array;
}
####################################################################




