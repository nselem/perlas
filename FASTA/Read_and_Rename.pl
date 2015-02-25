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
my $Dir="/home/fbg/lab/nselem/CLAVIBACTER/Filogenia/";
my $file="tomA_Protein";
my $nombre=$Dir.$file;
my $tabla=$nombre."tabla";
my $Cortado=$nombre."fasta";

## Aqui le das el nombre del fasta que quieras leer


########################################################3
## Script variables
my %Sequences;


##### Functions ########
sub readFile;
sub Rename;
sub WriteSalida;

#$longname=">gi|451943142|ref|YP_007463778.1|:4-267 pyrroline-5-carboxylate reductase [Corynebacterium halotolerans YIM 70093 = DSM 44683]";


#########################################################
######### MAin program
readFile($nombre,\%Sequences);
	#for my $key(keys %Sequences){
	#	print ("$key\n");}

WriteSalida($Cortado,$tabla,\%Sequences);

#my ($short, $id) = &Rename($longname);
#print("\nSHORT $short\nID $id\n");

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
                if($line =~ />/){
                                chomp;
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
		my ($genus, $specie,$short, $id) = &Rename($key);		
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

sub Rename{
	my $longname=$_[0];
	chomp $longname;
	#print "\nLONG $longname";
	#print "\n\n";

	my $short=$longname=~/\[(\w*)\s*(\w*).*?\]/;
	my $genus=$1;
	my $specie=$2;
	my $shortname=substr($genus,0,3)."_".substr($specie,0,6);

	my $gi=$longname=~/^>\w*\|(\d*)/;
	#print "\n\n";
	my $ID="gi".$1;
	#print "GI $ID";
	#print "\n\n";
	#print "SHORT $genus..$specie\n";
        #print "SHORT $shortname\n";

	return $genus,$specie, $shortname,$ID;
}


