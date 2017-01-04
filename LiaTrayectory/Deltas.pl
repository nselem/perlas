  use strict;
  use warnings; 
  use SVG;
####################################################################
##  Creates an svg file
##  perl Deltas.pl RUTASFile
##  This file is an input file for the r ggplo2 to produce the graph
##  Wishes 
##  TA ->type of activity -> ProFAR/PRA
##  MNI-> Mutation name inicial->D89   
##  MNI-> Mutation number inicial ->3.4
##  MAI->mutation activity inicial ->.004
##  MANI->Mutation activity normalizaed inicial -> .3 between [0,1]  From this mutation on all rutes
##  MNF-> Mutation name final->A129   
##  MNF-> Mutation number Final ->4.4
##  MAF->mutation activity final ->.0001
##  MANF->Mutation activity normalized final -> .8 between [0,1]  From this mutation on all rutes
##  delta
##  deltaN Normalizada entre todas las deltas de la mutacion final.

##
##
##
########################
## Figura análisis por mutaciones
#En cada paso, sacar el delta, de las mutaciones, sacar promedio y desviación estandar 
#EN las x cada mutación, y en las y promedio mas desviación estándar.

my %VARIANT_NAMES;
$VARIANT_NAMES{'1'}="D20V";
$VARIANT_NAMES{'2'}="L48I";
$VARIANT_NAMES{'3'}="F50L";
$VARIANT_NAMES{'4'}="M66I";
$VARIANT_NAMES{'5'}="T80S";
$VARIANT_NAMES{'6'}="A97C";
$VARIANT_NAMES{'7'}="D127G";
$VARIANT_NAMES{'8'}="A129D";
$VARIANT_NAMES{'9'}="T139L";
$VARIANT_NAMES{'10'}="Y214L";
$VARIANT_NAMES{'11'}="E230A";

my $flagPRO=0;
my $flagPRA=1;

my $file=$ARGV[0];  ## Routes I guess
my $xscale="30"; ## px scale
my $yscale="50";
my $xnumber=20; ## Total of x divisions
my $w=$xscale*$xnumber; # X axis size
my $h=$yscale*12; ## Y axis
my $xt=10;
my $svg = SVG->new( width  => $w+25, height => $h, transform=>"translate(30,30)");
Axes($xscale,$yscale,$w,$h);

my %PROFAR=fillPROFAR(); #-1/log(N5,10)
my %PRA=fillPRA();#-1/log(N5,10)
my %STARTS=fillstart();
######## Rosa      PRA     Triptofano
######## Amarillo  PROFAR  Histidine
#PRIA ancestral
#$PRA{1.1}="1.15739617";
#$PROFAR{1.1}="0.6622894568";
#HisA Ancestral
#$PRA{10.3}="0";
#$PROFAR{10.3}="0.6210739467";

my @LINES=segmentos($file); ## Fills the array LINES with coordinates of all posible rutes
  ## Change names would move the figure

my @CenterCOORD;
CentCOORD(\@CenterCOORD);
my %DELTA;

foreach my $segment(@LINES){
my @Dots=split("_",$segment);
#my @P0=split("_",$CenterCOORD[$Dots[0], $Dots[1]";
Line($Dots[0],$Dots[1],$xscale,$yscale,\%PROFAR,\%PRA);
Delta($Dots[0],$Dots[1],\%PROFAR,\%PRA,\%STARTS,\%DELTA);
}

##  TipeAc ->type of activity -> ProFAR/PRA
##  MName-> Mutation name inicial->D89   
##  Fondo-> Mutante fondo genetico ->3.4
##  NewVariant ->4.101
##  ActFondo -> actividad del fondo genético .004
##  ActNew-> Actividad nueva ->>
##  ANF-> Actividad Normalizada fondo genético (Total de actividades)
##  ANV-> Actividad normalizada de la variante
##  delta
##  deltaN Normalizada entre todas las deltas de la mutacion final.

## Graficas delta vs Fondo
## ANF vs ANV

print"TipeAc\tMName\tFondo\tNewVariant\tActFondo\tActNew\tdelta\tActFondoNorm\tActNuevaNorm\n";
foreach my $mutation (sort keys %DELTA){
#print "\n Mutation $mutation\n";
my $sumPRA=0;
my $sumPRO=0;
my $n=0;
foreach my $step (keys $DELTA{$mutation}){
my $Nmut=$step;
$Nmut=~s/(\d*\.\d*)\_(\d*\.\d*)/$2/;
my $before=$1;
my $after=$2;
#print "Backrground $Nmut\n";
#print  "PRO $DELTA{$mutation}{$step}[0]\tPRA $DELTA{$mutation}{$step}[1]\n";
#print  "Step\t$Nmut\tBEFORE\t$changes[1]\t$changes[0]\tAFTER\tPRO\t$DELTA{$mutation}{$step}[0]\tPRA\t$DELTA{$mutation}{$step}[1]\n";
print  "PROFAR\t$VARIANT_NAMES{$mutation}\t$before\t$after\t$PROFAR{$before}\t$PROFAR{$after}\t$DELTA{$mutation}{$step}[0]\n";
print  "PRA\t$VARIANT_NAMES{$mutation}\t$before\t$after\t$PRA{$before}\t$PRA{$after}\t$DELTA{$mutation}{$step}[1]\n";



$sumPRA=$sumPRA+$DELTA{$mutation}{$step}[1];
$sumPRO=$sumPRO+$DELTA{$mutation}{$step}[0];
$n++;
}
my $averageDeltaPRA=$sumPRA/$n;
my $averageDeltaPRO=$sumPRO/$n;

my $varPRA=0;
my $varPRO=0;

foreach my $step (keys $DELTA{$mutation}){
                $varPRA+=($averageDeltaPRA-$DELTA{$mutation}{$step}[1])**2;
                $varPRO+=($averageDeltaPRO-$DELTA{$mutation}{$step}[0])**2;
}
$varPRA=$varPRA/$n;
$varPRO=$varPRO/$n;
#print "Average PRO:$averageDeltaPRO PRA:$averageDeltaPRA\n";
#print "Var PRO:$varPRO Var PRA:$varPRA \n\n";

}

my @CENTERS=whitecircles($file,$xscale,$yscale,\%PROFAR,\%PRA);

# now render the SVG object, implicitly use svg namespace
my $outname="Solocirculos";
if ($flagPRO==1){$outname="SolocirculosPRO";}
if ($flagPRA==1){$outname="SolocirculosPRA";}

open (OUT,">$outname");
print OUT $svg->xmlify;
close OUT;
`perl -p -i -e 'if(/\<path/)\{ 
                              s/title=\"/\>\n\<title\>/g; 
                              if(m{\/\>\$})\{
    s{\" \/\>}{\<\/title\>\<\/path\>};\}\}
                else\{
                      if((!/^\t/) and m{\/\>})\{
                            s{\" \/>}{<\/title><\/path>};\}\}' $outname`;
########################################################################
###################################################################
######################## Subs ############################3
sub Delta{
my $inicio=shift;
my $final=shift;
my $refPRO=shift;
my $refPRA=shift;
my $refSTARTS=shift;
my $refDELTA=shift;

#print "\n$inicio -> $final\n";
my $s1="$refSTARTS->{$inicio}"; my $s2="$refSTARTS->{$final}";
#print "$s1 -> $s2\n";
my $diff = $s1 ^ $s2;

my @dpos;
push @dpos, [ $-[1]+1, $+[1] - $-[1] ]
    while $diff =~ m{ ([^\x00]+) }xmsg;


    foreach my $mut (@dpos){
#print "diff at offset $mut->[0], length $mut->[1] \n";
my $deltaPRO=$refPRO->{$final}-$refPRO->{$inicio};
my $deltaPRA=$refPRA->{$final}-$refPRA->{$inicio};
$refDELTA->{$mut->[0]}{"$inicio\_$final"}=[$deltaPRO,$deltaPRA];
#print"Mutante {$mut->[0]}{$inicio\_$final}->";
        #print qq| PRO $refDELTA->{$mut->[0]}{"$inicio\_$final"}[0],PRA $refDELTA->{$mut->[0]}{"$inicio\_$final"}[1]\n|;
}
}


sub getX{
my $point=shift;
my $result;
#print "P0:$point\n";
my @st0=split(/\./,$point);
foreach my $member (@{$CenterCOORD[$st0[0]]}){
#print "Members on Array of $st0[0] mutants:$member\n";
if($member =~ "$st0[0]\.$st0[1]\_"){
my @coor=split("_",$member);
#print "Coordenada x de P0 $coor[1],YES\n";
$result=$coor[1];
next;
}
}
return $result;
}
#________________________________________________________________________________________-
sub CentCOORD{
  my $refCENTERS=shift;  ##Array of arrays
#$refCENTERS[4]=[4.1_xcord,4.2_xcord] 

 open (FILE, "$file") or die "Couldnt open route file $!";
        foreach my $line (<FILE>){
                chomp $line;
                my @Trayectory=split("\t",$line);
                for (my $i=0;$i<scalar @Trayectory;$i++){
                        my @sp=split(/\./,$Trayectory[$i]);
 #                      print "0:$sp[0],1:$sp[1],T:$Trayectory[$i]\n\n";
if(! -exists $refCENTERS->[$sp[0]]){$refCENTERS->[$sp[0]]=[];}
                        if ($Trayectory[$i]~~@{$refCENTERS->[$sp[0]]}){
                                }
                        else{
                                push(@{$refCENTERS->[$sp[0]]},$Trayectory[$i]);
                                }
                        }
                }
             #   push(@{$refCENTERS->[1]},'1.1');
              #  push(@{$refCENTERS->[10]},'10.3');
        close FILE; ##Fill the array with centers

 for (my $i=2;$i<10;$i++){
 #              print "MUTANTS $i\n";
                my $isize=scalar @{$refCENTERS->[$i]};
                my $jtranslate=1;
my @sortedi= sort { $a <=> $b } @{$refCENTERS->[$i]};
                foreach (my $j=0;$j<$isize;$j++ ){ ##Now drawing circles
my $center=$sortedi[$j];
 #                      print "Row $i RowSize $isize Element $j, Center $center\n";
                        my @sp=split(/\./,$center);
                        my $y=$yscale*$sp[0];
                        my $x=int($xscale*($jtranslate)*($xnumber)/(1+$isize))-20;
 #                       print "$center\_$x $y \n";
$refCENTERS->[$i][$j]=$center."_".$x;
#print "$i, $jtranslate, $refCENTERS->[$i][$jtranslate-1]\n";
                        $jtranslate++;
 #                       print"\n\n" ;
                        }

                }
}
#_________________________________________________________________________
sub segmentos{
my $file=shift;
open (FILE, "$file") or die "Couldnt open route file $!";
foreach my $line (<FILE>){
chomp $line;
#$line=~s/\t\t//;
#print "$line\n";
my @Trayectory=split("\t",$line);
my @Sorted=sort {$a <=> $b} @Trayectory;
for(my $i=1;$i<@Sorted;$i++){
my $route=$Sorted[$i-1]."_".$Sorted[$i];
if ($route~~@LINES){}
else{
push(@LINES,$route);
}
}
}
close FILE;
return @LINES;
}
#_________________________________________________________________________

sub Line{
my $inicio=shift;
my $final=shift;
my $xscale=shift;
my $yscale=shift;
my $refPRO=shift;
my $refPRA=shift;
my @sp2=split(/\./,$final);
my @sp1=split(/\./,$inicio);
my $y2=$yscale*$sp2[0];
my $x2=$xscale*$sp2[1];
my $y1=$yscale*$sp1[0];
my $x1=$xscale*$sp1[1];




 $x1=getX($inicio);
#print "x1 new $x1\n";
$x2=getX($final);
#print "x2 new $x2\n";

if ($flagPRO==1){
if ($refPRO->{$final}>$refPRO->{$inicio}){ ## Drawing trayectory lines
$svg->line(x1 => $x1, y1 => $y1, x2 => $x2, y2 => $y2, 
style => {'stroke' => "rgb(150,0,0)",'stroke-width' =>1,
'stroke-opacity' => 1,}); #PRO
}
else{
$svg->line(x1 => $x1, y1 => $y1, x2 => $x2, y2 => $y2, 
style => {'stroke' => "rgb(0,0,0)",'stroke-width' =>.5,
'stroke-opacity' => .5,}); #PRO
}
}
elsif($flagPRA==1){
if ($refPRA->{$final}>$refPRA->{$inicio}){ ## Drawing trayectory lines
$svg->line(x1 => $x1, y1 => $y1, x2 => $x2, y2 => $y2, 
style => {'stroke' => "rgb(150,0,0)",'stroke-width' =>1,
'stroke-opacity' => 1,}); #PRO
}
else{
$svg->line(x1 => $x1, y1 => $y1, x2 => $x2, y2 => $y2, 
style => {'stroke' => "rgb(0,0,0)",'stroke-width' =>.5,
'stroke-opacity' => .5,}); #PRO
}
}
else{
$svg->line(x1 => $x1, y1 => $y1, x2 => $x2, y2 => $y2, 
style => {'stroke' => "rgb(0,0,0)",'stroke-width' =>.5,
'stroke-opacity' => .5,}); #PRO
}
}

#######################################################################
sub whitecircles{
my $file=shift;
        my $xscale=shift;
my $yscale=shift;
my $refPROFAR=shift;
my $refPRA=shift;

my @CENTERS;
        $CENTERS[1]=[];
        $CENTERS[2]=[];
        $CENTERS[3]=[];
        $CENTERS[4]=[];
        $CENTERS[5]=[];
        $CENTERS[6]=[];
        $CENTERS[7]=[];
        $CENTERS[8]=[];
        $CENTERS[9]=[];
        $CENTERS[10]=[];
        $CENTERS[11]=[];

open (FILE, "$file") or die "Couldnt open route file $!";
foreach my $line (<FILE>){
chomp $line;
my @Trayectory=split("\t",$line);
for (my $i=0;$i<scalar @Trayectory;$i++){
my @sp=split(/\./,$Trayectory[$i]);
#print "0:$sp[0],1:$sp[1],T:$Trayectory[$i]\n\n";
if ($Trayectory[$i]~~@CENTERS[$sp[0]]){
}
else{
push(@CENTERS[$sp[0]],$Trayectory[$i]);
}
}
}
#push(@{$CENTERS[1]},'1.1');
#push(@{$CENTERS[10]},'10.3');
close FILE; ##Fill the array with centers

for (my $i=1;$i<11;$i++){
#print "MUTANTS $i\n";
my $isize=scalar @{$CENTERS[$i]};
my $jtranslate=1;
foreach my $center (sort @{$CENTERS[$i]}){ ##Now drawing circles
#print "Size $isize Element $jtranslate, Row $i Center $center\n";
my @sp=split(/\./,$center);
my $y=$yscale*$sp[0];
my $x=$xscale*$sp[1];
my $radioPRO=$refPROFAR->{$center};
my $radioPRA=$refPRA->{$center};
#print "$x $y :$radioPRO : $radioPRA\n";
$x=int($xscale*($jtranslate)*($xnumber)/(1+$isize))-20;
#print "$x $y :$radioPRO : $radioPRA\n";
$jtranslate++;
#print"\n\n" ;
circulo($x,$y,$radioPRO,$radioPRA,$sp[0],$sp[1]);
}

}

return @CENTERS;
}


#_________________________________________________________________________
sub circulo{
# add a circle
my $x=shift;
my $y=shift;
my $radioPRO=shift;
my $radioPRA=shift;
my $mut=shift;
my $variant=shift;
if ($variant=='101'){$variant="10";}
my $radioPROs=4*$radioPRO;
my $radioPRAs=4*$radioPRA;
#print "$x:$y:$radioPRO:$radioPRA\n";
my $radioPRA_s=$radioPRA;

$svg->circle(  cx => $x,    cy => $y,    r  => 20, style => {'stroke'=> 'black','fill' => 'white','stroke-width' =>1,
'stroke-opacity' => 1,'fill-opacity'=> 1},); #orilla circulo

if ($variant>9){
$svg->text( x  => $x-10, y  => $y+5, 'font-size'=>"10")->cdata("$mut.$variant"); 
}
else{ ## if only ne digit for variant I move a little to center on x coordinate
$svg->text( x  => $x-7, y  => $y+5, 'font-size'=>"10")->cdata("$mut.$variant"); 
}
####### activity circles

#$svg->circle(  cx => $x,    cy => $y,    r  => $radioPRO, style =>{'fill'=> "rgb(150,0,250)",'stroke' => 'black','stroke-width' =>0,'stroke-opacity' => 1,'fill-opacity'=> 0.5,}); #PRO

# Then we use that data structure to create a polygon
## M move to
my $xi=$x-$radioPROs;
my $xf=$x+$radioPROs;
##                 xi yi   cx           cy      rx ry dir
#$svg->path(  d=>"M$xi $y A $radioPROs $radioPROs, 0, 0, 1, $xf $y L $xf $y Z",title=>"$mut.$variant ProFAR $radioPRO",style => {'fill'=> "rgb(150,0,250)",'stroke' => 'black','stroke-width' =>0,'stroke-opacity' => 1,'fill-opacity'=> .3,},);

#$svg->circle(  cx => $x,    cy => $y,    r  => $radioPRA, style => {'fill'=> "rgb(250,0,0)",'stroke' => 'white','stroke-width' =>0,'stroke-opacity' => 1,'fill-opacity'=> 0.5,},); #PRA

$xi=$x-$radioPRAs;
$xf=$x+$radioPRAs;
##                 xi yi   cx           cy      rx ry dir
#$svg->path(  d=>"M$xi $y A $radioPRAs $radioPRAs, 0, 0, 0, $xf $y L $xf $y Z",title=>"$mut.$variant PRA$radioPRA",style => {'fill'=> "rgb(250,0,0)",'stroke' => 'white','stroke-width' =>0,'stroke-opacity' => 1,'fill-opacity'=> .5,},);

 }

#____________________________________________________________________________________________
sub Axes{
my $xscale=shift;
my $yscale=shift;
my $w=shift;
my $h=shift;
#Axes
my $x=0;
my $y=0;
while ($x<=$w-$xscale){
$svg->line(x1 => $x, y1 => $h-$yscale, x2 => $x, y2 => $h-$yscale-10, 'stroke' => 'blue');
 ## X axis
my $text = $svg->text('x' => $x+7, 'y' => $h-$yscale+15, 'text-anchor' => 'end',
'font-variant' => 'small-caps');
my $coord=$x/$xscale;
$text->cdata("$coord");
$x=$x+$xscale;
}

while ($y<=$h-$yscale){
$svg->line(x1 => $w-$xscale-10, y1 => $y, x2 => $w-$xscale, y2 =>$y, 'stroke' => 'red'); ## Y axis
my $text = $svg->text('x' => $w-$xscale+15, 'y' => $y+7, 'text-anchor' => 'end',
'font-variant' => 'small-caps');
my $coord=$y/$yscale;
if ($coord<10 and $coord != 0){$text->cdata("$coord");}
$y=$y+$yscale;
}

$svg->line(x1 => 0, y1 => $h-$yscale, x2 => $w-$xscale, y2 => $h-$yscale, 'stroke' => 'blue'); ## X axis
$svg->line(x1 => $w-$xscale, y1 => 0, x2 => $w-$xscale, y2 =>$h-$yscale, 'stroke' => 'red'); ## Y axis
}

#____________________________________________________________________________________________
sub drawRute1{
my $xscale=shift;
my $yscale=shift;
my $route=shift;
#my $route="8.27.136.155.154.83.22.2";
my @Trayectory=split("\t",$route);
my @Sorted=sort {$b <=> $a} @Trayectory;
drawLine($xscale,$yscale,@Sorted);
####### Draw lines
}
#_________________________________________________________________________
sub drawLine{
my $xscale=shift;
my $yscale=shift;
my @Sorted=@_;
for (my $i=1;$i<scalar @Sorted;$i++){
my @sp2=split(/\./,$Sorted[$i]);
my @sp1=split(/\./,$Sorted[$i-1]);
my $y2=$yscale*$sp2[0];
my $x2=$xscale*$sp2[1];
my $y1=$yscale*$sp1[0];
my $x1=$xscale*$sp1[1];
$svg->line(x1 => $x1, y1 => $y1, x2 => $x2, y2 => $y2, style => {'stroke' => "rgb(0,0,0)",'stroke-width' =>.5,'stroke-opacity' => .1,});
}

}


#_________________________________________________________________________
sub fillPROFAR{
my %PROFAR;
$PROFAR{2.1}="0.25";
$PROFAR{2.2}="0.001";
$PROFAR{2.3}="0.01";
$PROFAR{2.4}="0.31";
$PROFAR{2.5}="0.21";
$PROFAR{3.1}="0.5";
$PROFAR{3.2}="0";
$PROFAR{3.3}="0.05";
$PROFAR{3.4}="0.07";
$PROFAR{3.5}="0.15";
$PROFAR{3.6}="0.064";
$PROFAR{4.1}="0.02";
$PROFAR{4.2}="0.0079";
$PROFAR{4.3}="0.0014";
$PROFAR{4.4}="0.0074";
$PROFAR{4.5}="0.02";
$PROFAR{4.6}="0.08";
$PROFAR{4.7}="0.02";
$PROFAR{4.8}="0.01";
$PROFAR{4.9}="0.07";
$PROFAR{4.101}="0.00012";
$PROFAR{4.11}="0.0013";
$PROFAR{4.12}="0.0046";
$PROFAR{4.13}="0.0174";
$PROFAR{5.1}="0.25";
$PROFAR{5.2}="0.18";
$PROFAR{5.3}="0.018";
$PROFAR{5.4}="0.0075";
$PROFAR{5.5}="0.014";
$PROFAR{5.6}="0.0047";
$PROFAR{5.7}="0.038";
$PROFAR{5.8}="0.0066";
$PROFAR{5.9}="0.031";
$PROFAR{5.101}="0.05";
$PROFAR{5.11}="0.036";
$PROFAR{5.12}="0.052";
$PROFAR{5.13}="0.007";
$PROFAR{5.14}="0.041";
$PROFAR{5.15}="0.00038";
$PROFAR{5.16}="0.00061";
$PROFAR{5.17}="0";
$PROFAR{5.18}="0.015";
$PROFAR{6.1}="0.038";
$PROFAR{6.2}="0.036";
$PROFAR{6.3}="0.04";
$PROFAR{6.4}="0.08";
$PROFAR{6.5}="0.0064";
$PROFAR{6.6}="1.36";
$PROFAR{6.7}="0.0049";
$PROFAR{6.8}="0.02";
$PROFAR{6.9}="0.02";
$PROFAR{6.101}="0.064";
$PROFAR{6.11}="0.0044";
$PROFAR{6.12}="0.043";
$PROFAR{6.13}="0.00034";
$PROFAR{6.14}="0.00017";
$PROFAR{6.15}="0.00023";
$PROFAR{6.16}="0.00017";
$PROFAR{6.17}="0.023";
$PROFAR{6.18}="0";
$PROFAR{7.1}="0.035";
$PROFAR{7.2}="0.026";
$PROFAR{7.3}="0.066";
$PROFAR{7.4}="0.033";
$PROFAR{7.5}="0.056";
$PROFAR{7.6}="0.00036";
$PROFAR{7.14}="0.0057";
$PROFAR{7.7}="0.00062";
$PROFAR{7.8}="0.011";
$PROFAR{7.9}="0.000034";
$PROFAR{7.101}="0.015";
$PROFAR{7.11}="0.013";
$PROFAR{7.12}="0.0017";
$PROFAR{7.13}="0.00038";
$PROFAR{8.1}="0.00086";
$PROFAR{8.2}="0.0049";
$PROFAR{8.3}="0.00061";
$PROFAR{8.4}="0.00065";
$PROFAR{8.5}="0.004";
$PROFAR{8.6}="0.000052";
$PROFAR{8.7}="0.000178";
$PROFAR{8.8}="0.0068";
$PROFAR{9.1}="0.0156";
$PROFAR{9.2}="0.000025";
$PROFAR{9.3}="0.013";
$PROFAR{9.4}="0.0018";
$PROFAR{10.1}="0.0044";
$PROFAR{10.2}="0";
$PROFAR{11.1}="0.00042";
return %PROFAR;
}

sub fillPRA{
$PRA{2.1}="0.0002319";
$PRA{2.2}="0.0001485";
$PRA{2.3}="0";
$PRA{2.4}="0";
$PRA{2.5}="0.000138";
$PRA{3.1}="0.00026";
$PRA{3.2}="0.00069";
$PRA{3.3}="0.00046";
$PRA{3.4}="0.00025";
$PRA{3.5}="0.00051";
$PRA{3.6}="0.00027";
$PRA{4.1}="0.00062";
$PRA{4.2}="0.0005";
$PRA{4.3}="0.00053";
$PRA{4.4}="0.00055";
$PRA{4.5}="0.00053";
$PRA{4.6}="0.00047";
$PRA{4.7}="0.00049";
$PRA{4.8}="0.00084";
$PRA{4.9}="0.00067";
$PRA{4.101}="0.00036";
$PRA{4.11}="0.00033";
$PRA{4.12}="0.00047";
$PRA{4.13}="0.00063";
$PRA{5.1}="0.00017";
$PRA{5.2}="0.00025";
$PRA{5.3}="0.00025";
$PRA{5.4}="0.0001";
$PRA{5.5}="0.00042";
$PRA{5.6}="0.00029";
$PRA{5.7}="0.00044";
$PRA{5.8}="0.00026";
$PRA{5.9}="0.00032";
$PRA{5.101}="0.00028";
$PRA{5.11}="0.00008";
$PRA{5.12}="0.00012";
$PRA{5.13}="0.003";
$PRA{5.14}="0.0002";
$PRA{5.15}="0.0016";
$PRA{5.16}="0";
$PRA{5.17}="0.0004";
$PRA{5.18}="0.000095";
$PRA{6.1}="0.0003";
$PRA{6.2}="0.0005";
$PRA{6.3}="0.0003";
$PRA{6.4}="0.0005";
$PRA{6.5}="0.0004";
$PRA{6.6}="0.0003";
$PRA{6.7}="0.00013";
$PRA{6.8}="0.000078";
$PRA{6.9}="0.0001";
$PRA{6.101}="0.0002";
$PRA{6.11}="0";
$PRA{6.12}="0.00012";
$PRA{6.13}="0.00046";
$PRA{6.14}="0.0013";
$PRA{6.15}="0.00071";
$PRA{6.16}="0.00088";
$PRA{6.17}="0";
$PRA{6.18}="0.000075";
$PRA{7.1}="0.00021";
$PRA{7.2}="0.00025";
$PRA{7.3}="0.00027";
$PRA{7.4}="0.00015";
$PRA{7.5}="0.00019";
$PRA{7.6}="0.00036";
$PRA{7.14}="0.00027";
$PRA{7.7}="0.00022";
$PRA{7.8}="0.0000692";
$PRA{7.9}="0.00037";
$PRA{7.101}="0.00013";
$PRA{7.11}="0.000063";
$PRA{7.12}="0.000051";
$PRA{7.13}="0.00057";
$PRA{8.1}="0.000315";
$PRA{8.2}="0.00092";
$PRA{8.3}="0.00057";
$PRA{8.4}="0.00086";
$PRA{8.5}="0.00067";
$PRA{8.6}="0.00065";
$PRA{8.7}="0.00046";
$PRA{8.8}="0.0003";
$PRA{9.1}="0.0047";
$PRA{9.2}="0.0016";
$PRA{9.3}="0.012";
$PRA{9.4}="0.00088";
$PRA{10.1}="0.0023";
$PRA{10.2}="0.0046";
$PRA{11.1}="0.0001537";
return %PRA;
}

sub fillstart{
my %STARTS;
my %Rutas;
$Rutas{2.1}="00101000000";$STARTS{2.1}="00101000000";
$Rutas{2.2}="10000010000";$STARTS{2.2}="10000010000";
$Rutas{2.3}="00100000100";$STARTS{2.3}="00100000100";
$Rutas{2.4}="01100000000";$STARTS{2.4}="01100000000";
$Rutas{2.5}="10100000000";$STARTS{2.5}="10100000000";
$Rutas{3.1}="00101000100";$STARTS{3.1}="00101000100";
$Rutas{3.2}="10100010000";$STARTS{3.2}="10100010000";
$Rutas{3.3}="10001010000";$STARTS{3.3}="10001010000";
$Rutas{3.4}="10100000100";$STARTS{3.4}="10100000100";
$Rutas{3.5}="01101000000";$STARTS{3.5}="01101000000";
$Rutas{3.6}="01100000100";$STARTS{3.6}="01100000100";
$Rutas{4.1}="10101000100";$STARTS{4.1}="10101000100";
$Rutas{4.2}="00101100100";$STARTS{4.2}="00101100100";
$Rutas{4.3}="00101000101";$STARTS{4.3}="00101000101";
$Rutas{4.4}="01101000100";$STARTS{4.4}="01101000100";
$Rutas{4.5}="10101010000";$STARTS{4.5}="10101010000";
$Rutas{4.6}="00101000110";$STARTS{4.6}="00101000110";
$Rutas{4.7}="00111000100";$STARTS{4.7}="00111000100";
$Rutas{4.8}="10100110000";$STARTS{4.8}="10100110000";
$Rutas{4.9}="01101100000";$STARTS{4.9}="01101100000";
$Rutas{4.101}="10001010100";$STARTS{4.101}="10001010100";
$Rutas{4.11}="10001110000";$STARTS{4.11}="10001110000";
$Rutas{4.12}="01100000110";$STARTS{4.12}="01100000110";
$Rutas{4.13}="11100000100";$STARTS{4.13}="11100000100";
$Rutas{5.1}="10101100100";$STARTS{5.1}="10101100100";
$Rutas{5.2}="11101000100";$STARTS{5.2}="11101000100";
$Rutas{5.3}="10101000101";$STARTS{5.3}="10101000101";
$Rutas{5.4}="01101000101";$STARTS{5.4}="01101000101";
$Rutas{5.5}="01101100100";$STARTS{5.5}="01101100100";
$Rutas{5.6}="00101100101";$STARTS{5.6}="00101100101";
$Rutas{5.7}="10101000110";$STARTS{5.7}="10101000110";
$Rutas{5.8}="00101000111";$STARTS{5.8}="00101000111";
$Rutas{5.9}="01101000110";$STARTS{5.9}="01101000110";
$Rutas{5.101}="10111000100";$STARTS{5.101}="10111000100";
$Rutas{5.11}="11100100100";$STARTS{5.11}="11100100100";
$Rutas{5.12}="00101100110";$STARTS{5.12}="00101100110";
$Rutas{5.13}="10101010100";$STARTS{5.13}="10101010100";
$Rutas{5.14}="11100000110";$STARTS{5.14}="11100000110";
$Rutas{5.15}="11100110000";$STARTS{5.15}="11100110000";
$Rutas{5.16}="00111000101";$STARTS{5.16}="00111000101";
$Rutas{5.17}="10101110000";$STARTS{5.17}="10101110000";
$Rutas{5.18}="11110000100";$STARTS{5.18}="11110000100";
$Rutas{6.1}="11101100100";$STARTS{6.1}="11101100100";
$Rutas{6.2}="11101000101";$STARTS{6.2}="11101000101";
$Rutas{6.3}="10111100100";$STARTS{6.3}="10111100100";
$Rutas{6.4}="11101000110";$STARTS{6.4}="11101000110";
$Rutas{6.5}="01101100101";$STARTS{6.5}="01101100101";
$Rutas{6.6}="10101100110";$STARTS{6.6}="10101100110";
$Rutas{6.7}="01101000111";$STARTS{6.7}="01101000111";
$Rutas{6.8}="10101000111";$STARTS{6.8}="10101000111";
$Rutas{6.9}="10101100101";$STARTS{6.9}="10101100101";
$Rutas{6.101}="11111000100";$STARTS{6.101}="11111000100";
$Rutas{6.11}="00101100111";$STARTS{6.11}="00101100111";
$Rutas{6.12}="01101100110";$STARTS{6.12}="01101100110";
$Rutas{6.13}="10101010110";$STARTS{6.13}="10101010110";
$Rutas{6.14}="11101010100";$STARTS{6.14}="11101010100";
$Rutas{6.15}="11101110000";$STARTS{6.15}="11101110000";
$Rutas{6.16}="10101110100";$STARTS{6.16}="10101110100";
$Rutas{6.17}="10111000101";$STARTS{6.17}="10111000101";
$Rutas{6.18}="11101001100";$STARTS{6.18}="11101001100";
$Rutas{7.1}="11101000111";$STARTS{7.1}="11101000111";
$Rutas{7.2}="11101100101";$STARTS{7.2}="11101100101";
$Rutas{7.3}="11101100110";$STARTS{7.3}="11101100110";
$Rutas{7.4}="10101100111";$STARTS{7.4}="10101100111";
$Rutas{7.5}="11111100100";$STARTS{7.5}="11111100100";
$Rutas{7.6}="10101110110";$STARTS{7.6}="10101110110";
$Rutas{7.14}="10101111100";$STARTS{7.14}="10101111100";
$Rutas{7.7}="11101010110";$STARTS{7.7}="11101010110";
$Rutas{7.8}="01101100111";$STARTS{7.8}="01101100111";
$Rutas{7.9}="11101110100";$STARTS{7.9}="11101110100";
$Rutas{7.101}="11101011100";$STARTS{7.101}="11101011100";
$Rutas{7.11}="10111100101";$STARTS{7.11}="10111100101";
$Rutas{7.12}="01111100101";$STARTS{7.12}="01111100101";
$Rutas{7.13}="11101110010";$STARTS{7.13}="11101110010";
$Rutas{8.1}="11101100111";$STARTS{8.1}="11101100111";
$Rutas{8.2}="11101110110";$STARTS{8.2}="11101110110";
$Rutas{8.3}="11111000111";$STARTS{8.3}="11111000111";
$Rutas{8.4}="11111100101";$STARTS{8.4}="11111100101";
$Rutas{8.5}="11101111100";$STARTS{8.5}="11101111100";
$Rutas{8.6}="11101011101";$STARTS{8.6}="11101011101";
$Rutas{8.7}="11101110011";$STARTS{8.7}="11101110011";
$Rutas{8.8}="10101111110";$STARTS{8.8}="10101111110";
$Rutas{9.1}="11111100111";$STARTS{9.1}="11111100111";
$Rutas{9.2}="11101110111";$STARTS{9.2}="11101110111";
$Rutas{9.3}="11101111110";$STARTS{9.3}="11101111110";
$Rutas{9.4}="11101011111";$STARTS{9.4}="11101011111";
$Rutas{10.1}="11101111111";$STARTS{10.1}="11101111111";
$Rutas{10.2}="11111110111";$STARTS{10.2}="11111110111";
$Rutas{11.1}="11111111111";$STARTS{11.1}="11111111111";
return %STARTS;
}
