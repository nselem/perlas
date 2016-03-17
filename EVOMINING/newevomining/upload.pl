#!/usr/bin/perl -w
########################################################
#
# Código de ejemplo del tutorial: "Upload de archivos"
#
# Creado por: Uriel Lizama
# Todos los derechos reservado.
#
# http://perlenespanol.com/
#
#########################################################

use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI;

my %Input;

my $query = new CGI;
my @pairs = $query->param;

foreach my $pair(@pairs){
$Input{$pair} = $query->param($pair);
}


#Directorio donde queremos estacionar los archivos
my $dir = "/ruta/al/directorio";

#Array con extensiones de archivos que podemos recibir
my @extensiones = ('gif','jpg','jpeg','bmp','png','fasta');


recepcion_de_archivo(); #Iniciar la recepcion del archivo

#TODO SALIO BIEN
print "Content-type: text/html\n\n";
print "<h1>El archivo fue recibido correctamente</h1>\n";

exit(1);


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
open (OUTFILE, ">$dir/$nombre_en_servidor") || die "No se puedo crear el archivo";
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


} #sub recepcion_de_archivo
