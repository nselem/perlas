system "ls /var/www/evomining/newevomining/blast/ >ls.blast";
open (LS, "ls.blast");
while(<LS>){
chomp;

 open(FILE, "/var/www/evomining/newevomining/blast/$_");
 while($line=<FILE>){
 chomp($line);
 @datos=split("\t", $line);
 @pasos=split("\|", $datos[0]); #obtiene datos de pasos biosinteticos 
 @gis=split("\|", $datos[1]);#obtiene datos de la base de datos como GI
 
 
  print "$line";
  <STDIN>;
 
 }
close FILE;


}
close LS;
