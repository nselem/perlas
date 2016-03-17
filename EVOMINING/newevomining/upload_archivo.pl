#!/usr/bin/perl -w
#####################################################
# CODIGO PARA UPLOAD-FILE
#
#####################################################

#use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI;

my %Input;

my $query = new CGI;
my @pairs = $query->param;

foreach my $pair(@pairs){
$Input{$pair} = $query->param($pair);
}


#Directorio donde queremos estacionar los archivos
my $dir = "/var/www/newevomining/querys";
my $dirDB = "/var/www/newevomining/DB";
my $dirPB = "/var/www/newevomining/PasosBioSin";
my $blastdir = "/opt/ncbi-blast-2.2.28+/bin/";
my $OUTblast = "/var/www/newevomining/blast";
#Array con extensiones de archivos que podemos recibir
my @extensiones = ('gif','jpg','jpeg','bmp','prot_fasta.2', 'fasta');


my $file_name=recepcion_de_archivo(); #Iniciar la recepcion del archivo

#TODO SALIO BIEN
print "Content-type: text/html\n\n";
print "<h1>El archivo fue recibido correctamente $file_name </h1>\n";

################  END UPLOAD-FILE######################
#------------------------------------------------------------
#######################################################
# CODIGO INSERTA DATOS EN bd
#######################################################
#------valida longitud de seq > 50 y seq!= nucleotidos---
#open (NEW, "/var/www/evomining/newevomining/querys/$file_name") or die "<h1>*$file_name*$!</h1>";
#open (ERROR, ">/var/www/evomining/newevomining/error/$file_name.ERRORLOG") or die "<h1>$!</h1>";
#$file_name =~ s/\s|\W//g; #elimina espacio y caracteres noletras/digitos del nombre

$cont=0;
$valida=1;
#while (<NEW>){
# chomp;
# 
#   if ($_ =~ />/){
#      $header=$_;
#      @longSeq=split("",$seq);
#      if($cont >0 and $#longSeq < 50){
#         #secuencia corta meno a 50 aminoacidos
#	 print "<h1>$header</h1> <h1>$seq</h1><h1>ERROR secuencia muy corta</h1>";
#	 $valida=0;
#      }
#   }
#   else{
#   
#      if( $_ !~ /G|A|T|C/){
#         #solo nucleotidos
#	 print  "<h1>ERROR secuencia de nucleotidos:</h1><h1>$_</h1>,<h1> se requiere secuencia de aminoaciods</h1>";
#	 $valida=0;
#      }
#      $seq=$seq.$_;
#   }
#   
#  $cont++; 
#}#end while
#close NEW;
#-----------------termina validacion----------------------

#--------- concatena archivo en bd------------------------
if ($valida ==1){
  print  "<h1>Concatenando...</h1>";
	
  #system "cat $dir/$file_name $dirDB/ALLv3SINAA4.out  > $dirDB/ALL_$file_name.out ";
  print  "<h1>aRCHIVO Concatenado:ALL_$file_name.out</h1>";
}
#--------- Indexa bd para blast --------------------------
print "<h1>Indexando base de datos GenomeDB...</h1>";
#system "$blastdir/makeblastdb -dbtype prot -in $dirDB/ALL_$file_name.out -out $dirDB/ALL_$file_name.db";
print "<h1>Done...</h1>";
print "<h1>Blast  Central Met./NP VS Genome DB...</h1>";
#system "$blastdir/blastp -db $dirDB/ALL_$file_name.db -query $dirPB/Glycolysis.fasta -outfmt 6 -num_threads 4 -evalue 0.001 -out $OUTblast/centralMetVSgenome.blast";
print "<h1>Done...</h1>";
open (BLA, "/var/www/newevomining/blast/centralMetVSgenome.blast");
while (<BLA>){
chomp;
@datblast=split("\t", $_);


}
close BLA;

#---------------------pinta tabla--------------
open (BLA, "/var/www/newevomining/blast/centralMetVSgenome.blast");
open (LOG, ">log.blast") or die $!;
while (<BLA>){
chomp;
  @datblast=split("\t", $_);
  @datpasosBIO=split(/\|/, $datblast[0]);
  @datGenomas=split(/\|/, $datblast[1]);
 # print "$datblast[0]***$datblast[1]\n";
 # print "$datpasosBIO[1]_$datGenomas[5]\n";
  if(!exists $hashUniqGI{$datGenomas[1]}){
    $llave="$datpasosBIO[1]_$datGenomas[5]";
    $hashGenomas{$llave}++;
    $hashUniqGI{$datGenomas[1]}=1;
    print LOG "$_\n";
  }
}#end while
$contador=0;
foreach my $x (sort {$a<=>$b} keys %hashGenomas){
 #print "-----------------\n";
 @datllave=split("_", $x );
 #print "$x -> $hashGenomas{$x} --- $datllave[0]\n";
 #@datllave=split("_", $x );
 if(!exists $numGenoma{$datllave[1]}){
   $contador++;
   $numGenoma{$datllave[1]}=$contador;
   $numGenoma2{$contador}=$datllave[1];
 }
 $tabla[$numGenoma{$datllave[1]}][$datllave[0]]=$hashGenomas{$x};
#print "$numGenoma{$datllave[1]}, $datllave[0]] =$hashGenomas{$x}\n ";
#<STDIN>;
}
close LOG;

#print scalar keys %hashGenomas;
close BLA;
#print "filas $#tabla comunas $#{$tabla[1]}\n";

print qq|<table BORDER="1" CELLSPACING="1" ALIGN="center" CELLPADDING="0" WIDTH="15">|;
#print "<tr>";
for (my $x=0; $x<=$#tabla; $x++){#***filas****
print "<tr>";
#if($x ==0){
     print "<td>$numGenoma2{$x}</td>";
 #   }
  for(my $y=0; $y<=$#{$tabla[1]}; $y++){ #columnas******
    
    print "<td>$tabla[$x][$y]</td>";
    
  }#end for filas
  print "</tr>";
}#end for columnas



#--------------------------
#<table>
#<tr>
#<td>Celda 1</td>
#<td>Celda 2</td>
#<td>Celda 3</td>
#</tr>
#<tr>
#<td>Celda 4</td>
#<td>Celda 5</td>
#<td>Celda 6</td>
#</tr>
#</table>

#---------------------------


#0---------------------end pinta tabla---------

#1.- calcular numero de hits (homologos) por genoma por pasos biosinteticos
#2.- calcular media y desviacion estandar para cada paso biosintetico 
  #2.1.- la media + la deviacion estandar es el punto de corte para seleccionar los que se analizan en el siguente paso
#3.- visualizar en tabla 
#4.- mouse over de GI de cada hit porgenoma y paso biosintetico


exit(1);






#######################################################
# funciones para upload
#######################################################
sub recepcion_de_archivo{

my $nombre_en_servidor = $Input{'archivo'};
$nombre_en_servidor =~ s/ /_/gi;
$nombre_en_servidor =~ s!^.*(\\|\/)!!;


my $extension_correcta = 0;

foreach (@extensiones){
if($nombre_en_servidor =~ /\.$_$/i){
$extension_correcta = 1;
last;
}
}


if($extension_correcta){

#Abrimos el nuevo archivo
open (OUTFILE, ">$dir/$nombre_en_servidor") || die "$! $dir No se puedo crear el archivo";
binmode(OUTFILE); #Para no tener problemas en Windows

#Transferimos byte por byte el archivo
while (my $bytesread = read($Input{'archivo'}, my $buffer, 1024)) {
print OUTFILE $buffer;
}

#Cerramos el archivo creado
close (OUTFILE);

}else{
print "Content-type: text/html\n\n";
print "<h1>Extension incorrecta</h1>";
print "Sólo se reciben archivo con extension:";
print join(",", @extensiones);
exit(0);
}
return $nombre_en_servidor;

} #sub recepcion_de_archivo
