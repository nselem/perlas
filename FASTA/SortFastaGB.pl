#!/usr/bin/perl
  use strict;
  use warnings;
###############################################################
# Para Karina:
################################################################
## Lector de fasta y recortador de encabezado
## Ademas guarda en el Archivo Directorio
## la relacion entre el encabezado corto, el GI, 
# y el genero y la especie
#  Nelly Selem nselem84@gmail.com
################################################################

##### Global variables

######### User variables  ###########################
my $nombre=$ARGV[0];
my $tabla=$nombre."tabla";
my $Cortado=$nombre."fasta";

## Aqui le das el nombre del fasta que quieras leer


########################################################3
## Script variables
my %Sequences;
my %SortKeys;

##### Functions ########
sub readFile;
sub Keys;
sub WriteSalida;

#$longname=">gi|451943142|ref|YP_007463778.1|:4-267 pyrroline-5-carboxylate reductase [Corynebacterium halotolerans YIM 70093 = DSM 44683]";


#########################################################
######### MAin program
readFile($nombre,\%Sequences);
Keys(\%Sequences,\%SortKeys);

foreach my $name (sort keys %SortKeys){
	print ("$SortKeys{$name}\n");
	print ("$Sequences{$SortKeys{$name}}\n");
}
#WriteSalida($Cortado,$tabla,\%Sequences);

######################################################################################
######### Subs Implementation
sub readFile{
	my $nombre=shift;
	my $Ref=shift;	
        #print ("$Ref\n");

        open(FILE,$nombre)or die $!;
        print("Se abrio el archivo $nombre\n");
	my @content=<FILE>;

	my $header;
        foreach my $line (@content){
		chomp $line;
                if($line =~ />/){
                                $header=$line;
                                $Ref->{$header}="";
				print $Ref->{$header};
	
                        }
                        else{
                                $Ref->{$header}=$Ref->{$header}.$line;

                        }


        }
	close FILE;
}
#___________________________________________________________________________________

sub WriteSalida{
	my $nombre=shift;
	my $tabla=shift;
	my $Sequences=shift;
        print ("$Sequences\n");

        open(SALIDA,">",$nombre)or die $!;
        open(TABLA,">",$tabla)or die $!;

	for my $key(keys %{$Sequences}){
		print ($key);
		my ($genus, $specie,$short, $id) = &Keys($key);		
		print SALIDA (">$short\n");
		print SALIDA ("$Sequences->{$key}\n");
		print TABLA ("$short\t$id\t$genus\t$specie\t$key\n");
		#print  (">$short\n");
		#print  ("$Sequences->{$key}\n");
		#print  ("$short\t$id\t$genus\t$specie\t$key\n");
		}
	close SALIDA;

}
#####################################################################################

sub Keys{
my $RefSeq=shift;
my $RefSort=shift;

	for my $key(keys %{$RefSeq}){
		chomp $key;
		my $number=substr($key,1,9);

		my $short=$key;
		$short=~s/\>[0-9]*\_//;		
		my $sort=">".$short."_".$number;
        	$RefSort->{$sort}="$key";		
		#print "key:$key\n";
		#print "short: $short\n";
		#print "sort: $sort\n";		
	}

}

