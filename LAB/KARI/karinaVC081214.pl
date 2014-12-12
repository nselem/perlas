#SCRIPT PARA CALCULAR LA MATRIZ DE DISTANCIAS DE TANIMOTO# 
#DESCRIPCIÓN DE LOS SUSTRATOS
$stringg="5C\t4W\t4O\t2D\t2I\t1X\t2H\t1T\t1S\t1R\t1Q\t2Z\t2LA\t"; #2H2M3KB
push(@sustratos, $stringg);
$stringg="5C\t4W\t4O\t2D\t2I\t1X\t2H\t1T\t1S\t1R\t1Q\t2Z\t3LA\t"; #3H3M2KB
push(@sustratos, $stringg);
$stringg="6C\t4W\t4O\t2D\t2I\t1X\t2H\t1T\t1S\t1R\t2Q\t1Z\t1E\t2LA\t"; #2H2E3KB
push(@sustratos, $stringg);
$stringg="6C\t4W\t4O\t2D\t2I\t1X\t2H\t1T\t1S\t1R\t2Q\t1Z\t1E\t3LA\t"; #3H3E2KB
push(@sustratos, $stringg);
$stringg="5C\t3W\t2O\t1N\t2D\t1A\t5Y\t1I\t1X\t1M\t"; #P5C
push(@sustratos, $stringg);
$stringg="5C\t3W\t3O\t2D\t2I\t1X\t1T\t2Q\t2Z\t"; #AA
push(@sustratos, $stringg);
$stringg="3C\t4W\t4O\t2D\t2I\t1X\t1H\t1T\t1P\t"; #2HP
push(@sustratos, $stringg);
$stringg="3C\t3W\t3O\t2D\t2I\t1X\t1T\t1Q\t1Z\t"; #P
push(@sustratos, $stringg);
$stringg="3C\t1W\t3O\t1D\t1I\t1H\t1P\t1Q\t1Z\t"; #2H2MP
push(@sustratos, $stringg);
$stringg="3C\t1W\t4O\t2D\t1I\t1H\t1X\t1S\t1JA\t";#3H3OP
push(@sustratos, $stringg);
$stringg="6C\t2W\t10O\t1DA\t2D\t1X\t4H\t4S\t"; #6PG
push(@sustratos, $stringg);
$stringg="6C\t1W\t6O\t6H\t4S\t2P\t"; #M
push(@sustratos, $stringg);
$stringg="13C\t3W\t3O\t2N\t2DA\t5D\t1J\t3A\t5Y\t6YY\t3BA\t6H\t5S\t1P\t"; #UDP-G
push(@sustratos, $stringg);
$stringg="15C\t3W\t16O\t5N\t2DA\t6D\t1J\t4A\t5Y\t6YY\t4AA\t1BA\t6H\t1P\t5S\t"; #GCD-M
push(@sustratos, $stringg);
$stringg="7C\t2W\t4O\t1N\t2D\t2X\t1AA\t2Q\t1Z\t1KA\t"; #CMAP
push(@sustratos, $stringg);
$stringg="3C\t2W\t6O\t1DA\t1D\t2H\t1P\t1S\t"; #G3P
push(@sustratos, $stringg);
$stringg="6C\t1W\t4O\t2D\t1I\t1X\t1H\t2Q\t2Z\t"; #2DHP
push(@sustratos, $stringg);
$stringg="10C\t1W\t6O\t2D\t2J\t1I\t2X\t1H\t1S\t1T\t1A\t6Y\t"; #Pre
push(@sustratos, $stringg);
$stringg="10C\t2W\t5O\t1N\t4D\t2J\t1A\t6Y\t2X\t1AA\t1H\t1S\t"; #Arogenate
push(@sustratos, $stringg);
$stringg="36C\t4W\t18O\t7N\t10D\t3A\t1L\t11F\t3I\t3H\t3T\t2S\t2Q\t2Z\t5Y\t6YY\t1B\t1J\t2K\t6U\t5AA\t2BA\t3DA\t1IA\t"; #lc3HACoA
push(@sustratos, $stringg);
$stringg="29C\t3W\t16O\t6N\t10D\t4A\t2X\t5H\t2M\t2P\t3S\t2Q\t2Z\t5Y\t6YY\t4J\t1K\t6U\t1DA\t6AA\t1BA\t"; #MTTHM
push(@sustratos, $stringg);




#---------------------------------------------
#$stringg="21C\t14W\t8O\t3N\t3B\t2G\t10D\t6J\t4A\t5Y\t6YY\t1K\t6U\t4I\t2X\t2T\t1V\t2AA\t2BA\t";
#push(@sustratos, $stringg);
#$stringg="12C\t8W\t4O\t3N\t1B\t4D\t1J\t2A\t5Y\t2I\t1X\t1H\t1T\t1AA\t1BA\t1M\t1S\t1Q\t1Z\t";
#push(@sustratos, $stringg);
#$stringg="12C\t12W\t8O\t3N\t1B\t5D\t5I\t2X\t3T\t3AA\t2BA\t1H\t1S\t1Q\t1Z\t";
#push(@sustratos, $stringg);
#$stringg="6C\t8W\t6O\t1N\t1DA\t2G\t4D\t3J\t1A\t6Y\t1K\t6U\t1V\t";
#push(@sustratos, $stringg);
#$stringg="12C\t10W\t7O\t2N\t1DA\t2G\t7D\t6J\t2A\t6Y\t2K\t6U\t2V\t";
#push(@sustratos, $stringg);
#$stringg="12C\t11W\t8O\t2N\t1DA\t1G\t7D\t6J\t2A\t6Y\t2K\t6U\t2V\t";
#push(@sustratos, $stringg);
#$stringg="6C\t8W\t6O\t1N\t1B\t5D\t3J\t1A\t6Y\t1K\t6U\t1V\t1CA\t";
#push(@sustratos, $stringg);
#$stringg="11C\t9W\t6O\t2N\t1DA\t2G\t4D\t3J\t1A\t6Y\t1K\t6U\t1V\t1AA\t3Q\t3Z\t";
#push(@sustratos, $stringg);
#$stringg="8C\t8W\t5O\t1N\t1B\t1DA\t4D\t1A\t6Y\t1K\t6U\t1V\t2Q\t2Z\t"; #999999999999999999
#push(@sustratos, $stringg);
#$stringg="10C\t7W\t6O\t1N\t1DA\t4D\t3J\t1A\t6Y\t1K\t6U\t1V\t2Q\t2E\t";
#push(@sustratos, $stringg);
#$stringg="12C\t5W\t4O\t1N\t3D\t1A\t5Y\t1L\t5F\t3I\t3T\t1BA\t1Q\t";
#push(@sustratos, $stringg);
#$stringg="8C\t6W\t2N\t4EA\t4FA\t3D\t3J\t2GA\t1A\t6Y\t1K\t6U\t";
#push(@sustratos, $stringg);
#$stringg="12C\t5W\t4O\t1B\t1G\t2D\t1L\t12F\t1CA\t";
#push(@sustratos, $stringg);

#print "-$#sustratos-";
#<STDIN>;
$numsustratos=$#sustratos+1;#numero de sutratos

$heteroatomo=0;
$carbono=0;
$oxigeno=0;
$nitrogeno=0;
$dobleEnlace=0;
$anillo=0;
$carbonilo=0;
$acidocarboxilico=0;
$alcohol=0;
$acetona=0;
$himino=0;
$alcoholPrimario=0;
$alcoholSecundario=0;
$alcoholTerciario=0;
$grupoalquilo=0;
$grupoetilo=0;
$grupometilo=0;
$Miembrosanillo=0;
$Miembrosanillo2=0;
#---------Karina-------------------#
$cadenaalifaticaConCarbono=0;
$cadenaalifatica=0;
$azufre=0;
$cargas=0;
$Dobleenlacecarbono=0;
$anillosaromaticos=0;
$Miembrosanilloaromatico=0;
$nitro=0;
$amino=0;
$amida=0;
$fosfato=0;
$halidas=0;
$cloro=0;
$Tripleenlace=0;
$sulfato=0;

$tiol=0;
$aldehido=0;
$propilo=0;
$PosAlquilo=0;
#------------------------------

#$sustratos[1]="2W 1A 2X";

$fila=0;
#for(my $i=0;$i<2;$i++) {
#   for(my $j=0;$j<21;$j++) {
#      $total->[$i]->[$j] = 0; #assign some value
#   }
#}


foreach $cadena (@sustratos){
#print "$cadena---"; 
#<STDIN>;
#--------------------------------------------

#--------------------------------------------
if($cadena =~ m/(\d+)W\t.*/){ #heteroatomo
 $heteroatomo=$1;
}
if($cadena =~ m/(\d+)C\t.*/){ #carbono 
$carbono=$1;
}
if($cadena =~ m/(\d+)O\t.*/){#oxigeno
$oxigeno=$1;
}
if($cadena =~ m/(\d+)N\t.*/){#nitrogeno
$nitrogeno=$1;
}
if($cadena =~ m/(\d+)D\t.*/){#doble enlace
$dobleEnlace=$1;
}
if($cadena =~ m/(\d+)A\t.*/){#anillo
$anillo=$1;
}

if($cadena =~ m/(\d+)L\t.*/){#cadena alifatica
  $cadenaalifatica=$1;
}
if($cadena =~  m/(\d+)F\t.*/){# NUMERO DE CARBONOS DE LA cadena alifatica
$cadenaalifaticaConCarbono=$1;
}
if($cadena =~  m/(\d+)I\t.*/){#carbonilo
$carbonilo=$1;
}
if($cadena =~ m/(\d+)X\t.*/){#carboxilo
$acidocarboxilico=$1;
}
if($cadena =~ m/(\d+)H\t.*/){#alcohol
$alcohol=$1;
}
if($cadena =~ m/(\d+)T\t.*/){#cetona
$acetona=$1;
}
if($cadena =~ m/(\d+)M\t.*/){#imino
$himino=$1;
}
if($cadena =~ m/(\d+)P\t.*/){#alcohol primario
$alcoholPrimario=$1;
}
if($cadena =~ m/(\d+)S\t.*/){#alcohol secundario
$alcoholSecundario=$1;
}
if($cadena =~ m/(\d+)R\t.*/){#alcohol terciario
$alcoholTerciario=$1;
}
if($cadena =~ m/(\d+)Q\t.*/){ #grupo alquilo
$grupoalquilo=$1;
}
if($cadena =~ m/(\d+)E\t.*/){#grupo Etilo
$grupoetilo=$1;
}
if($cadena =~ m/(\d+)Z\t.*/){#grupo metilo
$grupometilo=$1;
}
if($cadena =~ m/(\d+)Y\t.*/){#numero de miembors de anillo
 
 
  $Miembrosanillo=$1;

}
if($cadena =~ m/(\d+)YY\t.*/){#numero de miembors de anillo
 
 
  $Miembrosanillo2=$1;

}
 if($cadena =~ m/(\d+)B\t.*/){#AZUFRE
$azufre=$1;
}
 if($cadena =~ m/(\d+)G\t.*/){#NUMERO DE CARGAS
$cargas=$1;
} 
if($cadena =~ m/(\d+)J\t.*/){#DOBLE ENLACE CARBONO CARBONO
$Dobleenlacecarbono=$1;
}
if($cadena =~ m/(\d+)K\t.*/){#TIENE ANILLOS AROMÁTICOS
$anillosaromaticos=$1;
}
if($cadena =~ m/(\d+)U\t.*/){#NUMERO DE MIEMBROS DEL ANILLO AROMÁTICO
$Miembrosanilloaromatico=$1;
}
if($cadena =~ m/(\d+)V\t.*/){#GRUPO NITRO
$nitro=$1;
}
if($cadena =~ m/(\d+)AA\t.*/){#GRUPO AMINO EMPIEZAN LAS DOBLE LETRAS
$amino=$1;

}
if($cadena =~ m/(\d+)BA\t.*/){#GRUPO AMIDA
$amida=$1;
#print "si econtre BA  $1 cadena:$cadena";
#<STDIN>;
}
if($cadena =~ m/(\d+)DA\t.*/){#FOSFATO
$fosfato=$1;

}
if($cadena =~ m/(\d+)EA\t.*/){#HALIDAS
$halidas=$1;

}
if($cadena =~ m/(\d+)FA\t.*/){#CLORO
$cloro=$1;

}
if($cadena =~ m/(\d+)GA\t.*/){#TRIPLES ENLACES
$Tripleenlace=$1;

}
if($cadena =~ m/(\d+)CA\t.*/){#SULFATO
#print "si econtre CA $1  cadena:$cadena";
#<STDIN>;
$sulfato=$1;
}

#----------CONDICIONES------------
#NUEVAS

if($cadena =~ m/(\d+)IA\t.*/){#tiol
$tiol=$1;
}
if($cadena =~ m/(\d+)JA\t.*/){#aldehido
$aldehido=$1;

}
if($cadena =~ m/(\d+)KA\t.*/){#propilo
$propilo=$1;
}
if($cadena =~ m/(\d+)LA\t.*/){#PosAlquilo
$PosAlquilo=$1;
}
#---------------------------------
 #if($fila ==0){
  #  print "fila:$fila amida:$amida";
  #  <STDIN>;
  #}
  
 if($carbono >0){
 $valor[0][$fila]=1;
  
 }
 else{
 $valor[0][$fila]=0;
 
 }
 if($heteroatomo >0){#todos !$carnono !$hidrogerno
 $valor[1][$fila]=1;
 }
 else{
 $valor[1][$fila]=0;
 }
 if($oxigeno >0){
 $valor[2][$fila]=1;
 }
  else{
 $valor[2][$fila]=0;
 }
 if($nitrogeno >0){
 $valor[3][$fila]=1;
 }
  else{
 $valor[3][$fila]=0;
 }
 if($dobleEnlace >0){
 $valor[4][$fila]=1;
 }
 else{
 $valor[4][$fila]=0;
 }
 if($anillo >0){
 $valor[5][$fila]=1;
 }
  else{
$valor[5][$fila]=0; 
 }
 if($Miembrosanillo == 5 or $Miembrosanillo2 == 5){ #Miembros de anillos
 $valor[6][$fila]=1;
 }
  else{
 $valor[6][$fila]=0;
 } 
 if($cadenaalifatica > 0){
 #print "SIIIII HAY: $cadenalinfatica";
 #<STDIN>;
 $valor[7][$fila]=1;   
 }
  else{
 $valor[7][$fila]=0;
 }
 if($cadenaalifaticaConCarbono >2){
    $valor[8][$fila]=1;
  }
   else{
 $valor[8][$fila]=0;
 }
  if($carbonilo >0){
 $valor[9][$fila]=1;
 }
  else{
 $valor[9][$fila]=0;
 }
 if($carbonilo >1){
 $valor[10][$fila]=1;
 }
  else{
 $valor[10][$fila]=0;
 }
 if($acidocarboxilico > 0){
 $valor[11][$fila]=1;
 
 }
  else{
 $valor[11][$fila]=0;
 }
 if($alcohol >0){
 $valor[12][$fila]=1;
 }
  else{
 $valor[12][$fila]=0;
 }
 if($acetona >0){ #cetona
 $valor[13][$fila]=1;
 }
  else{
 $valor[13][$fila]=0;
 }
 if($himino >0){
 $valor[14][$fila]=1;
 }
  else{
 $valor[14][$fila]=0;
 }
 if($alcoholPrimario>0){
 $valor[15][$fila]=1;
 }
  else{
 $valor[15][$fila]=0;
 }
 if($alcoholTerciario >0){

 $valor[17][$fila]=1;
 }
  else{
 $valor[17][$fila]=0;
 }
 if($alcoholSecundario >0){
 $valor[16][$fila]=1;
 }
  else{
 $valor[16][$fila]=0;
 }
 if($grupoalquilo >0){
  $valor[18][$fila]=1;
 }
  else{
 $valor[18][$fila]=0;
 }
 if($grupometilo >0){
  $valor[19][$fila]=1; 
 # print "$cadena=$grupometilo";
 #<STDIN>;
 }
  else{
 $valor[19][$fila]=0;
 }
 if($grupoetilo >0){
  $valor[20][$fila]=1;
 }
  else{
 $valor[20][$fila]=0;
 }
 #--------------------
 if($azufre >0){
  $valor[21][$fila]=1;
 
 }
  else{
 $valor[21][$fila]=0;
 }
 if($cargas >0){
  $valor[22][$fila]=1;
 
 }
  else{
 $valor[22][$fila]=0;
 } 
  if($Dobleenlacecarbono >0){
  $valor[23][$fila]=1;
 
 }
  else{
 $valor[23][$fila]=0;
 }
   if($anillosaromaticos >0){
  $valor[24][$fila]=1;
 
 }
  else{
 $valor[24][$fila]=0;
 }
   if($anillo >1){
  $valor[25][$fila]=1;
 
 }
  else{
 $valor[25][$fila]=0;
 }
   if($anillo >2){
  $valor[26][$fila]=1;
 
 }
  else{
 $valor[26][$fila]=0;
 }
  if($Miembrosanillo == 6 or $Miembrosanillo2 == 6){
  $valor[27][$fila]=1;
 
 
 }
  else{
 $valor[27][$fila]=0;
 }
  if($anillosaromaticos >1){
  $valor[28][$fila]=1;
 
 }
  else{
 $valor[28][$fila]=0;
 }
  if($Miembrosanilloaromatico == 6){
  $valor[29][$fila]=1;
 
 }
  else{
 $valor[29][$fila]=0;
 } 
  if($cloro >0){
 $valor[30][$fila]=1;
 }
  else{
 $valor[30][$fila]=0;
 }

  if($cadenaalifaticaConCarbono >4){
    $valor[31][$fila]=1;
  }
   else{
 $valor[31][$fila]=0;
 }
 
   if($cadenaalifaticaConCarbono >6){
    $valor[32][$fila]=1;
  }
   else{
 $valor[32][$fila]=0;
 }
   if($cadenaalifaticaConCarbono >10){
    $valor[33][$fila]=1;
  }
   else{
 $valor[33][$fila]=0;
 }
 
 if($acetona >1){ #cetona
 $valor[34][$fila]=1;
 }
  else{
 $valor[34][$fila]=0;
 }
 if($nitro >0){
  $valor[35][$fila]=1;
 
 }  
 else{
 $valor[35][$fila]=0;
 } 
 
  if($nitro >1){
  $valor[36][$fila]=1;
 
 }
 else{
 $valor[36][$fila]=0;
 }  
   if($amino >0){
  $valor[37][$fila]=1;
 
 }
 else{
 $valor[37][$fila]=0;
 }  
 if($amino >1){
  $valor[38][$fila]=1;
 
 } 
 else{
 $valor[38][$fila]=0;
 } 
 if($amida >0){
  $valor[39][$fila]=1;
 
 }
 else{
 $valor[39][$fila]=0;
 }  
 
 if($amida >1){
  $valor[40][$fila]=1;
 
 }
 else{
 $valor[40][$fila]=0;
 }   
 if($sulfato >0){
  $valor[41][$fila]=1;
 
 }
 else{
 $valor[41][$fila]=0;
 }  
 
 if($grupoalquilo >1){
  $valor[42][$fila]=1;
 }
 else{
 $valor[42][$fila]=0;
 } 
  if($heteroatomo >2){#todos !$carnono !$hidrogerno
 $valor[43][$fila]=1;
 }
  else{
 $valor[43][$fila]=0;
 }
  if($heteroatomo >4){#todos !$carnono !$hidrogerno
 $valor[44][$fila]=1;
 }
  else{
 $valor[44][$fila]=0;
 }
  
  if($heteroatomo >7){#todos !$carnono !$hidrogerno
 $valor[45][$fila]=1;
 }
 else{
 $valor[45][$fila]=0;
 } 
 
 if($halidas >0){
 $valor[46][$fila]=1;
 }
 else{
 $valor[46][$fila]=0;
 } 
  
  
  if($fosfato >0){
 $valor[47][$fila]=1;
 }
 else{
 $valor[47][$fila]=0;
 } 
 
 if($Tripleenlace >0){
 $valor[48][$fila]=1;
 }
 else{
 $valor[48][$fila]=0;
 } 
 if($acidocarboxilico > 1){
 $valor[49][$fila]=1;
 }
 else{
 $valor[49][$fila]=0;
 }
 if($tiol>0){
 $valor[50][$fila]=1;
 }
 else{
 $valor[50][$fila]=0;
 }
  if($aldehido>0){
 $valor[51][$fila]=1;
 }
 else{
 $valor[51][$fila]=0;
 }
 if($propilo >0){
 $valor[52][$fila]=1;
 }
 else{
 $valor[52][$fila]=0;
 }
# print "*$alcohol*";
# <STDIN>;
if($alcohol >1){
$valor[53][$fila]=1;
}
else{
$valor[53][$fila]=0;
}
if($PosAlquilo >1){
$valor[54][$fila]=1;
}
else{
$valor[54][$fila]=0;
}
if($PosAlquilo >2){
$valor[55][$fila]=1;
}
else{
$valor[55][$fila]=0;
}
# print "*$alcohol*=$valor[53][$fila]";
# <STDIN>;
#----------end CONDICIONES----



  #push(@total,@valor);
 
$heteroatomo=0;
$carbono=0;
$oxigeno=0;
$nitrogeno=0;
$dobleEnlace=0;
$anillo=0;
$carbonilo=0;
$acidocarboxilico=0;
$alcohol=0;
$acetona=0;
$himino=0;
$alcoholPrimario=0;
$alcoholSecundario=0;
$alcoholTerciario=0;
$grupoalquilo=0;
$grupoetilo=0;
$grupometilo=0;
$Miembrosanillo=0;
$Miembrosanillo2=0;

#---------Karina-------------------#
$cadenaalifaticaConCarbono=0;
$cadenaalifatica=0;
$azufre=0;
$cargas=0;
$Dobleenlacecarbono=0;
$anillosaromaticos=0;
$Miembrosanilloaromatico=0;
$nitro=0;
$amino=0;
$amida=0;
$fosfato=0;
$halidas=0;
$cloro=0;
$Tripleenlace=0;
$sulfato=0;

$tiol=0;
$aldehido=0;
$propilo=0;
$PosAlquilo=0;



$fila++;
#print "numero $ccc\n";
$ccc++;
#------------------------------
}#end foreach

$numCondiciones=$#valor+1;

#for(my $y=0; $y<12; $y++){

#  for(my $x=0; $x<$#valor; $x++){
#    print " $#valor---$#{$valor[$x]}\n";
#    print "[0][$y]=$valor[0][$y]\n";
#    if ($valor[0][$y] ==0){
#     print "CEROOOOOOOOOO [0][$y]=$valor[0][$y]\n";
#      <STDIN>;
#    }
#  }
#}  


####################################
### calcula A B C
####################################
for(my $sup=0;$sup<$numsustratos;$sup++) {#
 for(my $i=0;$i<$numsustratos;$i++) { #sustratos, incrementa columnas
   for(my $j=0;$j<$numCondiciones;$j++) { #condiciones, incrementa filas de tabal 1-0
     # print ": [$j][$sup]=>$valor[$j][$sup]-- [$j][$i]=$valor[$j][$i]\n";
     # <STDIN>;
       if ($sup==0){    
          
        # if ($valor[$j][$i] != 1){
	#   $valor[$j][$i]=0;
	# }
	 #print "$j ==$valor[$j][$i]\t";
	 #<STDIN>;
       $K{$j}="$K{$j}\t$valor[$j][$i]\t"; #guarda los elementos para calcular despues K
       }
       #$L{$j}="$L{$j}\t$valor[$j][$i]\t";
      if ($valor[$j][$sup] == 1 and $valor[$j][$i] != 1){
        $a++;
	
         #print "SI A $j $sup = $valor[$j][$sup]  --- $j $i =$valor[$j][$i]\n";
	 #<STDIN>;
      }
      elsif ($valor[$j][$sup] != 1 and $valor[$j][$i]== 1){
        $b++;
	#print "SIIIIII B $j $sup  $valor[$j][$sup]  --- $j $i =$valor[$j][$i]\n";
	# <STDIN>;
      }
      elsif ($valor[$j][$sup] == 1 and $valor[$j][$i]== 1){
        $c++;
	#print "SI C [$j, $sup]  $valor[$j][$sup]  --- [$j, $i] =$valor[$j][$i]\n";
#	 <STDIN>;
      }
      else {
       #print "Error OTRO CASO... $valor[$j][$sup] ///// $valor[$j][$i]";
       #<STDIN>;

      }
      if ($c==0){
       #print "c vale cero $c---$valor[$j][$sup] == 1 and $valor[$j][$i]== 1";
       #<STDIN>;
      }
      #print "sustrato:[$i $j]=$valor[$j][$i] [$sup $j]=$valor[$j][$sup]  (a$a+b$b)/(a$a+b$b+c$c)\n";
     # <STDIN>;
       $deltaAB=($a+$b)/($a+$b+$c);
      #if($i == $sup){
      #  print "[$i][$sup] =  $deltaAB  a:$a b:$b c:$c   ($a+$b)  / ($a+$b+$c)";
      #	<STDIN>;
      #}
      $matrizIDENT[$i][$sup]=$deltaAB;
      #print "cetona $valor[12][0]  $valor[13][0]\n";
      #print "Termina condicion";
      #<STDIN>;
   }#end for interno
   
      # $K{$j}="$K{$j}\t$valor[$j][$i]\t";
   #print "[$j][$sup]-- [$j][$i]";
   #print "Termino sutrato a: $a\n";
   #print "Termino sutrato b: $b\n";
   #print "Termino sutrato c: $c\n";
   #print "deltaAB: $deltaAB";
   #<STDIN>;
   $a=0;
   $b=0;
   $c=0;
   if ($sup==0){
   # print "\n";
    #  <STDIN>;
   } 
  }#end for Externo
}#end for sup


#######################################################
#despliega matriz identidad
#######################################################
print "Matriz identidad\n";
open (OUT, ">matrizIdentidad.xls");

for(my $i=0;$i<$numsustratos;$i++) { #sustratos
   for(my $j=0;$j<$numsustratos;$j++) { #condiciones
    
    #if($i == $j){
    #  print "[$i] [$j] = $matrizIDENT[$i][$j]\n";
    #  <STDIN>;
    #}
      print OUT "$matrizIDENT[$i][$j]\t";
     $llav= "$i";
     $suma=$suma+$matrizIDENT[$i][$j];
   }
   $sum{$i}=$suma;
   $suma=0;
   print OUT "\n";
   #<STDIN>;
 }  

 #<STDIN>;

#########################################################
#### calcula K y L
#########################################################
$L=0;
foreach  $keys (keys %K){
  @numCARACT=split("\t",$K{$keys});
   #print "llve: $keys\n";
   #<STDIN>;
  foreach $cadauno (@numCARACT){
    #print "$cadauno\t";
    #<STDIN>;
    if ($cadauno ==1){
      $hashcaract{$keys}=$hashcaract{$keys}+1;
       
     }
    
  }#end foreach interno
  
  #print "ultimo $#numCARACT - $numCARACT[$#numCARACT]\n";
}

foreach $llave (keys %hashcaract ){
 
   if($hashcaract{$llave} >0 and $hashcaract{$llave} <$numsustratos){# K caracteristicas que estan en almenos un sutrato pero no en todos
       $k++;
   }
   
   if($hashcaract{$llave} == $numsustratos){ # L caracteristicas que estan en todos los sustratos
    #print "L :$hashcaract{$llave}\n";
    $l++
   }
}

print "L :$l\n";
print "K :$k\n";

$deltaSET=$k/($k+$l);

print "DeltaSet :$deltaSET\n";

foreach $de (sort {$a<=>$b} keys %sum){
$deltaIJ=$sum{$de}/$#sustratos;
#print "sutrato:$de deltaij:$deltaIJ\n";
$deltafinal=$deltaIJ/$deltaSET;
print "$de\t$deltafinal\n";
}


