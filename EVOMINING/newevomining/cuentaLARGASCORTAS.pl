use Statistics::Basic qw(:all);
# se genero este hash con programa>/var/www/newevomining/9178_WedMar182015/hash.pl
$hash{1}='Phosphoglyceratedehydrogenase1';
$hash{12}='glycinehydroxymethyltransferase1';
$hash{15}='glycinehydroxymethyltransferase4';
$hash{17}='glycinehydroxymethyltransferase6';
$hash{18}='serineOacetyltransferase1';
$hash{19}='serineOacetyltransferase2';
$hash{27}='Glucosekinase5';
$hash{29}='Glucosekinase7';
$hash{30}='Glucose6phosphateisomerase1';
$hash{31}='Glucose6phosphateisomerase2';
$hash{33}='Glucose6phosphateisomerase4';
$hash{35}='Phosphofructokinase2';
$hash{4}='Phosphoglyceratedehydrogenase4';
$hash{41}='Fructosebiphosphatealdolase1';
$hash{50}='phosphoglyceratekinase1';
$hash{51}='phosphoglyceratekinase2';
$hash{53}='phosphoglyceratemutase1';
$hash{54}='phosphoglyceratemutase2';
$hash{56}='phosphoglyceratemutase4';
$hash{6}='Phosphoserineaminotransferase2';
$hash{64}='Pyruvatekinase4';
$hash{65}='Aspartatetransaminase2';
$hash{66}='Asparaginesynthase1';
$hash{68}='Asparaginesynthase3';
$hash{69}='Aspartatekinase1';
$hash{70}='Aspartatekinase3';
$hash{71}='Aspartatesemialdehydedehydrogenase1';
$hash{72}='Aspartatesemialdehydedehydrogenase2';
$hash{74}='Aspartatesemialdehydedehydrogenase4';
$hash{76}='Homoserinedehydrogenase3';
$hash{78}='Homoserinekinase1';
$hash{79}='Homoserinekinase2';
$hash{81}='Threoninesynthase1';
$hash{84}='Threoninesynthase4';
$hash{85}='dihydropicolinatesynthase1';
$hash{86}='dihydropicolinatesynthase2';
$hash{89}='dihydropicolinatesynthase5';
$hash{91}='dihydropicolinatereductase2';

open (BNP, "/var/www/newevomining/9178_WedMar182015/ls.FASTANP") or die $!;
while (<BNP>){
chomp;
$la=$_;
$la =~ s/\.fasta//;
if(!exists $hash{$la}){
 next;

}
 ##########cuenta y saca secuencias corts y largas####################
 open(TAM, "/var/www/newevomining/9178_WedMar182015/FASTASparaNP/$_") or die $!;
 open(OUTTAM, ">/var/www/newevomining/graficas/$hash{$la}.xls") or die $!;
  $contDentro=0;
  $contfuera=0;
  $contfueraabajo=0;
  undef %hashLARGASCORTAS;
 while($lineaa=<TAM>){
 chomp($lineaa);
  if($lineaa =~ />/){
     $headerr=$lineaa;
  }
  else{
      $hashLARGASCORTAS{$headerr}=$hashLARGASCORTAS{$headerr}.$lineaa; 
  }
 }#end while interno
 
 #------------------------- 
 #separa las bases y cuenta
 #------------------------- 
 ##print "Separando bases...\n"; 
 $cuentaSEQ=0;
 undef @arrpasos2;
 foreach my $x (keys %hashLARGASCORTAS){
   @baseees=split(//,$hashLARGASCORTAS{$x});
   $tamSEQ=$#baseees+1;
   $hashID_size{$x}=$tamSEQ;
   $cuentaSEQ++;
   $sumaTAM=$sumaTAM+$tamSEQ;
   $idtam=$x."&&&".$tamSEQ;
   push (@arrpasos2,$idtam);
   push (@arrpasos,$tamSEQ);
 }
 
  $promedioTamSEQ=$sumaTAM/$cuentaSEQ;
  
 #------------------------- 
 #promedio y DEVstd
 #------------------------- 
 ##print " Calculando devstd...\n";  
 #<STDIN>;
 ####################################################
 ##    CALCULO DE DESVIACION ESTANDAR
 ###################################################
   $contstd=1;
   my @v1  = vector(@arrpasos);
   my $std = stddev(@v1);
   $prommasDEV=$promedioTamSEQ+$std;
   $promminusDEV=$promedioTamSEQ-$std;
   $promminusDEV=$promminusDEV-$std;
   $temp=$_;
   $temp=~s/\.fasta//;
   #print "$hash{$temp} ->prom:$promedioTamSEQ-->DEVstd:$std \n";
   #<STDIN>;#
   
   print OUTTAM "$hash{$temp}--prom:$promedioTamSEQ-->DEVstd:$std\tmedia\tMed+STD\tMedminus2STDdev\n";
   $acumm[0]=$acumm[0].$acumula;
  #weekend# print "$acumm[0]\n";
   #weekend#
   #<STDIN>;
   $cuentaSEQ=0;
   $sumaTAM=0;
   $fila=1;
   foreach my $xids ( @arrpasos2 ){
     @idssize=split(/&&&/,$xids);
     if($idssize[1] > $prommasDEV){
       ##print "$idssize[0] $idssize[1] > $prommasDEV";
       ##<STDIN>;
       $contfuera++;
       #print "$idssize[0]\n$hashLARGASCORTAS{$idssize[0]}";
     }
     elsif($idssize[1] < $promminusDEV){
     
        $contfueraabajo++;
     }
     else{
      #print "$idssize[0]\n$hashLARGASCORTAS{$idssize[0]}";
      #<STDIN>;
        $contDentro++;
     }


       #print "$idssize[1]--$fila\n";
       $acumula2="$idssize[1]";
       $fila++;
       #$acumm[$fila]=$acumm[$fila].$acumula2."\t".$promedioTamSEQ."\t".$prommasDEV."\t".$promminusDEV."\t\t";
       $acumm[$fila]=$acumm[$fila].$acumula2."\t\t";
     
       #weekend#
       #
       print OUTTAM "$idssize[1]"."\t".$promedioTamSEQ."\t".$prommasDEV."\t".$promminusDEV."\n";
       #<STDIN>;
  }
  $totalfuera=$contfuera+$contfueraabajo;
  #weekend#
  #print "Dentro :$contDentro  Fueraarriba: $contfuera  fueraabajo:$contfueraabajo totalfuera:$totalfuera";
  
  ##weekend#
  #<STDIN>;

 ##
 ##$prommasDEV

 undef @arrpasos;
  #print "$_ ->prom:$promedioTamSEQ-->DEVstd:$std\n";
  #<STDIN>;
######################################################
 #foreach my $y (keys %hashID){
 #  print "$y-->$hashID{$y}-->prom:$promedioTamSEQ-->DEVstd:$std";
 #  <STDIN>;
 #}
  close OUTTAM;
  undef %hashID_size;
  undef %hashID;
}#end while externo


#foreach my $x (@acumm){
#print "$x\n";

#}




##########FIN cuenta y saca secuencias corts y largas####################
