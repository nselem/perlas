  use strict;
  use warnings;
     
  use SVG;
####################################################################
### Creates an svg file
########################3
# create an SVG object with a size of 40x40 pixels
#
# usage perl 2.3DrawFig2.pl RUTAS_110 
# author nelly Selem nselem84@gmail.com
#
#  input Routes tab separated file
## Output SVG SóloCírculos<parameters>
#
## Figura análisis por mutaciones
#En cada paso, sacar el delta, de las mutaciones, sacar promedio y desviación estandar 
#EN las x cada mutación, y en las y promedio mas desviación estándar.
###############################33 Inputs ########################
my $flagPRO=0;
my $flagPRA=0;

my $file=$ARGV[0]; ## File with routes
my $fileData=$ARGV[1]; ##file with data
my $xscale="45"; ## px scale
my $yscale="50";
my $ynum="10";##Number of mutation of the last mutation
my $xnumber=20; ## Total of x divisions
my $w=$xscale*$xnumber; # X axis size
my $h=$yscale*12; ## Y axis
my $xt=10;
my $svg = SVG->new( width  => $w+25, height => $h, transform=>"translate(30,30)");
Axes($xscale,$yscale,$w,$h);

my %PROFAR; 
my %PRA;
##### Reading Data
open (FILE, $fileData) or die "Couldnt open file $fileData\n";

my $header=<FILE>;
foreach my $line (<FILE>){
	chomp $line;
	my @st=split("\t",$line);
	$st[0]=~m/(\d*)\.(\d*)/;
	my $variant=$2;
	if($variant==10){
		$st[0]=~s/($1)\.(10)/$1\.101/;
#		my $pause=<STDIN>;
		}
#	print "$st[0]-> pro $st[3] , pra $st[6]\n";
	$PRA{$st[0]}=$st[6];
	$PROFAR{$st[0]}=$st[3];
	}
#exit;



###########################################################################################
################################################# Main ########################### 
my @LINES=segmentos($file);     ## Fills the array LINES with conextions between mutants of all posible rutes
				## Ejemplo 2.1_3.2 3.2_4.11 on the route 2.1 3.2 4.11
my $SemiDarwinian=IncreasingTrayectories($file,\%PROFAR,\%PRA); ##Calculates how many trayectories are strictly non decreasing
print "There are $SemiDarwinian semi-darwinian trayectories\n";

my %CenterCOORD;
CentCOORD(\%CenterCOORD,$xscale,$xnumber,$yscale);

my $count=0;
foreach my $segment(@LINES){
	my @Dots=split("_",$segment);
#	my @P0=split("_",$CenterCOORD[$Dots[0], $Dots[1]";
	$count=$count+Line($Dots[0],$Dots[1],$xscale,$yscale,\%PROFAR,\%PRA);
}
#print "TOTAL  $count\n";

my @CENTERS=whitecircles(\%CenterCOORD,$file,$xscale,$yscale,\%PROFAR,\%PRA);

#################### Render ###################################################3
# now render the SVG object, implicitly use svg namespace
my $outname="Solocirculos_$file";
if ($flagPRO==1 and $flagPRA==0){$outname="SolocirculosPRO_$file";}
if ($flagPRA==1 and $flagPRO==0){$outname="SolocirculosPRA_$file";}
if ($flagPRA==1 and $flagPRO==1){$outname="SolocirculosPRA_PRO_$file";}

	open(OUT,">$outname");
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
sub getX{
	my $point=shift;
	my $result;	
		#print "P0:$point\n";
		my @st0=split(/\./,$point);
	foreach my $member (@{$CenterCOORD{$st0[0]}}){
#		print "Members on Array of $st0[0] mutants:$member\n";
		if($member =~ "$st0[0]\.$st0[1]\_"){
		my @coor=split("_",$member);
#		print "Coordenada x de P0 $coor[1],YES\n";
		$result=$coor[1];
		next;
		}
	}
	return $result;
}

#________________________________________________________________________________________-
sub whitecircles{
	my $refCentCOORD=shift;
	my $file=shift;
        my $xscale=shift;
	my $yscale=shift;
	my $refPROFAR=shift;
	my $refPRA=shift;

         ################# end sorting 
	foreach my $i ( sort {$a<=>$b} keys $refCentCOORD){
		my $isize=scalar @{$refCentCOORD->{$i}};
		my $jtranslate=1;
		foreach my $center (@{$refCentCOORD->{$i}}){ ##Now drawing circles
		#print "Size $isize Element $jtranslate, Row $i Center $center\n";
		#print "MUTANTS $i isizee $isize \n";
			my @sp=split(/_|\./,$center);
			#print "$sp[0] , $sp[1],$sp[2]\n";
			my $y=$yscale*$sp[0];
			my $x=$xscale*$sp[1];
			my $centro=$sp[0].".".$sp[1];
			my $radioPRO=$refPROFAR->{$centro};
			my $radioPRA=$refPRA->{$centro};
			#print "$x $y :$radioPRO : $radioPRA\n";
			$x=int($xscale*($jtranslate)*($xnumber)/(1+$isize))-20;
			#print "0:$sp[0],1:$sp[1],2:$sp[2],x:$x y:$y\n";
			#my $pause=<STDIN>;
			$jtranslate++;
		#	print"\n\n" ;
			circulo($x,$y,$radioPRO,$radioPRA,$sp[0],$sp[1]);
			}

		}

	return @CENTERS;
	}

#-------------------------------------------------------------------------------------------
sub CentCOORD{
  	my $refCENTERS=shift;  ##Array of arrays
  	my $xscale=shift;  ##Array of arrays
  	my $xnumber=shift;  ##Array of arrays
  	my $yscale=shift;  ##Array of arrays
	#$refCENTERS[4]=[4.1_xcord,4.2_xcord] 

 	open (FILE, "$file") or die "Couldnt open route file $!";
        foreach my $line (<FILE>){
                chomp $line;
                my @Trayectory=split("\t",$line);
                for (my $i=0;$i<scalar @Trayectory;$i++){
                        my @sp=split(/\./,$Trayectory[$i]);
 			# print "0:$sp[0],1:$sp[1],T:$Trayectory[$i]\n\n";
			if(! -exists $refCENTERS->{$sp[0]}){$refCENTERS->{$sp[0]}=[];}
                        if ($Trayectory[$i]~~@{$refCENTERS->{$sp[0]}}){
                                }
                        else{
                                push(@{$refCENTERS->{$sp[0]}},$Trayectory[$i]);
                                }
                        }
                }
             	# push(@{$refCENTERS->[1]},'1.1');
              	# push(@{$refCENTERS->[10]},'10.3');
        close FILE; ##Fill the array with centers

 for (my $i=2;$i<=$ynum;$i++){
 #              print "MUTANTS $i\n";
                my $isize=scalar @{$refCENTERS->{$i}};
                my $jtranslate=1;
		my @sorted_i;

		foreach my $centro (@{$refCENTERS->{$i}}){ ## Sorting acordin to m on a.m
			 $centro=~m/(\d*)\.(\d*)/;
			 my $second=$2;
			if($second=='101'){$second=10;}
			 push (@sorted_i,$second);
			}
	
		my @sortedi= sort { $a <=> $b } @sorted_i;
		foreach my $centro (@sortedi){ ## Sorting acordin to m on a.m
			if($centro=='10'){$centro=101;}
			 $centro="$i".".".$centro;
			 #print "$centro\n";
			}

		

                foreach (my $j=0;$j<$isize;$j++ ){ ##Now drawing circles
			my $center=$sortedi[$j];
                       	#print "Row $i RowSize $isize Element $j, Center $center\n";
                        my @sp=split(/\./,$center);
                        my $y=$yscale*$sp[0];
                        my $x=int($xscale*($jtranslate)*($xnumber)/(1+$isize))-20;
 			#  print "$center\_$x $y \n";
			$refCENTERS->{$i}[$j]=$center."_".$x;
		#	print "$i, $jtranslate, $refCENTERS->{$i}[$jtranslate-1]\n";
                        $jtranslate++;
 #                       print"\n\n" ;
                        }

                }
}
#----------------------------------------------------------------------------------------------
sub IncreasingTrayectories{
        my $file=shift;
	my $refPRO=shift;
        my $refPRA=shift;

	my $count=1;
	my@Trayectories;
        open (FILE, "$file") or die "Couldnt open route file $!";
        foreach my $line (<FILE>){
		$Trayectories[$count]=1;
                chomp $line;
                $line=~s/\t\t//;
                #print "$line\n";
                my @Trayectory=split("\t",$line);
                my @Sorted=sort {$a <=> $b} @Trayectory;
                for(my $i=1;$i<@Sorted;$i++){
                        #my $route=$Sorted[$i-1]."_".$Sorted[$i];
				#if ($route~~@LINES){}
			if($refPRO->{$Sorted[$i-1]}<$refPRO->{$Sorted[$i]} or $refPRA->{$Sorted[$i]}>$refPRA->{$Sorted[$i-1]}){
#				print "Sorted $i $Sorted[$i] PRO $refPRO->{$Sorted[$i]} PRA $refPRA->{$Sorted[$i]}\n";
#				print "Sorted $i-1 $Sorted[$i-1] PRO $refPRO->{$Sorted[$i-1]} PRA $refPRA->{$Sorted[$i-1]}\n";
#				print "pause"; my $pause= <STDIN>;
				$Trayectories[$count]=$Trayectories[$count]*1;}
			else{
				$Trayectories[$count]=$Trayectories[$count]*0;
				}
                        }
#		print"This is Darwiniansemi $Trayectories[$count]\n";
		$count++;
                }
        close FILE;
	
	my $sum=0;
        for(my $i=1;$i<@Trayectories;$i++){
	#nn	print "$i ->Trayectorie $Trayectories[$i]\n";
		$sum=$sum+$Trayectories[$i];}
        return $sum;
        }


#_________________________________________________________________________
sub segmentos{
	my $file=shift;
	open (FILE, "$file") or die "Couldnt open route file $!";
	foreach my $line (<FILE>){
		chomp $line;
		$line=~s/\t\t//;
		#print "$line\n";
		my @Trayectory=split("\t",$line);
		my @Sorted=sort {$a <=> $b} @Trayectory;
		for(my $i=1;$i<@Sorted;$i++){
			my $route=$Sorted[$i-1]."_".$Sorted[$i];
		#	print "$route\n";
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
	my $count=0;
	$x1=getX($inicio);
	#print "x1 new $x1\n";
	$x2=getX($final);
	#print "x2 new $x2\n";
        if($flagPRA==0 and $flagPRO==0){
                        $svg->line(x1 => $x1, y1 => $y1, x2 => $x2, y2 => $y2,
                        style => {'stroke' => "rgb(0,0,0)",'stroke-width' =>1.5,
                        'stroke-opacity' => .5,}); #PRO         
                        }

	#	}
	return $count;
	}

#######################################################################


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

$svg->circle(  cx => $x, cy => $y,  r  => 20, style => {'stroke'=> 'gray','fill'=>"white",'stroke-width' =>1,
				'stroke-opacity' => 1,'fill-opacity'=> 1},); #orilla circulo

if ($variant>9){
$svg->text( x  => $x-15, y  => $y+5, 'font-size'=>"14",'font-family'=>'Arial')->cdata("$mut\_$variant"); 
}
else{ ## if only ne digit for variant I move a little to center on x coordinate
$svg->text( x  => $x-12, y  => $y+5, 'font-size'=>"14",'font-family'=>'Arial')->cdata("$mut\_$variant"); 
}
# Then we use that data structure to create a polygon
## M move to
my $xi=$x-$radioPROs;
my $xf=$x+$radioPROs;

$xi=$x-$radioPRAs;
$xf=$x+$radioPRAs;

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

	while ($y<=$h-$yscale){
		$svg->line(x1 => 10-$xscale, y1 => $y, x2 => 15-$xscale, y2 =>$y, 'stroke' => 'black'); ## Y axis
#		$svg->line(x1 => $w-$xscale-10, y1 => $y, x2 => $w-$xscale, y2 =>$y, 'stroke' => 'red'); ## Y axis
		my $text = $svg->text('x' => 30-$xscale, 'y' => $y+7, 'text-anchor' => 'end','font-family'=>'Arial',
		'font-variant' => 'small-caps');
		my $coord=$y/$yscale;
		if ($coord<=$ynum and $coord != 0){$text->cdata("$coord");}
		$y=$y+$yscale;
	}

	#$svg->line(x1 => 0, y1 => $h-$yscale, x2 => $w-$xscale, y2 => $h-$yscale, 'stroke' => 'blue'); ## X axis
	$svg->line(x1 =>10-$xscale, y1 => 0, x2 =>10-$xscale, y2 =>$h-$yscale, 'stroke' => 'black'); ## Y axis
}

#____________________________________________________________________________________________
sub drawRute1{
	my $xscale=shift;
	my $yscale=shift;
	my $route=shift;
	#my $route="8.2	7.13	6.15	5.15	4.8	3.2	2.2";
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
