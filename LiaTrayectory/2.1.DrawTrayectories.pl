   use strict;
    use warnings;
     
    use SVG;
####################################################################

# create an SVG object with a size of 40x40 pixels

my $file=$ARGV[0];
my $xscale="30";
my $yscale="50";
my $w=$xscale*20; # X axis size
my $h=$yscale*12; ## Y axis
my $xt=10;
my $svg = SVG->new( width  => $w+25, height => $h, transform=>"translate(30,30)");
Axes($xscale,$yscale,$w,$h);

my %PROFAR=fillPROFAR();
my %PRA=fillPRA();
######## Rosa      PRA     Triptofano
######## Amarillo  PROFAR  Histidine
#PRIA ancestral
$PRA{1.1}="1.15739617";
$PROFAR{1.1}="0.6622894568";
#HisA Ancestral
$PRA{10.3}="0";
$PROFAR{10.3}="0.6210739467";

my @LINES=segmentos($file);
foreach my $segment(@LINES){
	my @Dots=split("_",$segment);
	Line($Dots[0],$Dots[1],$xscale,$yscale,\%PROFAR,\%PRA);
}

my @CENTERS=whitecircles($file,$xscale,$yscale,\%PROFAR,\%PRA);

# now render the SVG object, implicitly use svg namespace
print $svg->xmlify;

########################################################################
###################################################################
######################## Subs ############################3
#_________________________________________________________________________
sub segmentos{
	my $file=shift;
	open (FILE, "$file") or die "Couldnt open route file $!";
	foreach my $line (<FILE>){
		chomp $line;
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

	if ($refPRO->{$final}>$refPRO->{$inicio}){
		$svg->line(x1 => $x1-5, y1 => $y1, x2 => $x2-5, y2 => $y2, 
		style => {'stroke' => "rgb(150,0,250)",'stroke-width' =>1,
		'stroke-opacity' => 1,}); #PRO
		}
	else{
		$svg->line(x1 => $x1-5, y1 => $y1, x2 => $x2-3, y2 => $y2, 
		style => {'stroke' => "rgb(150,0,250)",'stroke-width' =>.5,
		'stroke-opacity' => .5,}); #PRO
		}
	if ($refPRA->{$final}>$refPRA->{$inicio}){
		$svg->line(x1 => $x1+5, y1 => $y1, x2 => $x2+5, y2 => $y2, 
		style => {'stroke' => "rgb(250,0,0)",'stroke-width' =>1,
		'stroke-opacity' => 1,});
		}
	else{
		$svg->line(x1 => $x1+3, y1 => $y1, x2 => $x2+3, y2 => $y2,
		style => {'stroke' => "rgb(250,0,0)",'stroke-width' =>.5,
		'stroke-opacity' => .5,});
		}	
	}


sub whitecircles{
	my $file=shift;
        my $xscale=shift;
	my $yscale=shift;
	my $refPROFAR=shift;
	my $refPRA=shift;

	my @CENTERS;
	open (FILE, "$file") or die "Couldnt open route file $!";
	foreach my $line (<FILE>){
		chomp $line;
		my @Trayectory=split("\t",$line);
		for (my $i=0;$i<scalar @Trayectory;$i++){
			if ($Trayectory[$i]~~@CENTERS){
				}
			else{
				push(@CENTERS,$Trayectory[$i]);		
				}	
			}
		}
		push(@CENTERS,'1.1');		
		push(@CENTERS,'10.3');		

	close FILE; ##Fill the array with centers

	foreach my $center (sort @CENTERS){ ##Now drawing circles
		#print "$center\n"
		my @sp=split(/\./,$center);
		my $y=$yscale*$sp[0];
		my $x=$xscale*$sp[1];
		my $radioPRO=$refPROFAR->{$center};
		my $radioPRA=$refPRA->{$center};
		#print "$x $y :$radioPRO : $radioPRA\n";
		circulo($x,$y,$radioPRO,$radioPRA);
	

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
	$radioPRO=4*$radioPRO;
	$radioPRA=4*$radioPRA;
#print "$x:$y:$radioPRO:$radioPRA\n";
	my $radioPRA_s=$radioPRA;

$svg->circle(  cx => $x,    cy => $y,    r  => 20, style => {'stroke'=> 				'black','fill' => 'white','stroke-width' =>1,
				'stroke-opacity' => 1,'fill-opacity'=> 1},); #orilla circulo

$svg->circle(  cx => $x,    cy => $y,    r  => $radioPRO, style =>{'fill'=> "rgb(150,0,250)",'stroke' => 'black','stroke-width' =>0,'stroke-opacity' => 1,'fill-opacity'=> 0.5,}); #PRO

$svg->circle(  cx => $x,    cy => $y,    r  => $radioPRA, style => {'fill'=> "rgb(250,0,0)",'stroke' => 'white','stroke-width' =>0,'stroke-opacity' => 1,'fill-opacity'=> 0.5,},); #PRA

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
sub fillPROFAR{
my %PROFAR;
$PROFAR{2.1}="1.660964047";
$PROFAR{2.2}="0.3333333333";
$PROFAR{2.3}="0.5";
$PROFAR{2.4}="1.9660336";
$PROFAR{2.5}="1.475403463";
$PROFAR{3.1}="3.321928095";
$PROFAR{3.2}="0";
$PROFAR{3.3}="0.7686217868";
$PROFAR{3.4}="0.8658743639";
$PROFAR{3.5}="1.213726655";
$PROFAR{3.6}="0.8376471982";
$PROFAR{4.1}="0.5885919101";
$PROFAR{4.2}="0.475653009";
$PROFAR{4.3}="0.3504011436";
$PROFAR{4.4}="0.4693142888";
$PROFAR{4.5}="0.5885919101";
$PROFAR{4.6}="0.9116518111";
$PROFAR{4.7}="0.5885919101";
$PROFAR{4.8}="0.5";
$PROFAR{4.9}="0.8658743639";
$PROFAR{4.1}="0.2550487698";
$PROFAR{4.11}="0.3464935454";
$PROFAR{4.12}="0.42785468";
$PROFAR{4.13}="0.5683591877";
$PROFAR{5.1}="1.660964047";
$PROFAR{5.2}="1.342773037";
$PROFAR{5.3}="0.5731554085";
$PROFAR{5.4}="0.4706018027";
$PROFAR{5.5}="0.5394115771";
$PROFAR{5.6}="0.4295713217";
$PROFAR{5.7}="0.7041180468";
$PROFAR{5.8}="0.4586196513";
$PROFAR{5.9}="0.6628494026";
$PROFAR{5.1}="0.7686217868";
$PROFAR{5.11}="0.6926658809";
$PROFAR{5.12}="0.7788182275";
$PROFAR{5.13}="0.4640582349";
$PROFAR{5.14}="0.720868197";
$PROFAR{5.15}="0.2923791603";
$PROFAR{5.16}="0.3110739045";
$PROFAR{5.17}="0";
$PROFAR{5.18}="0.5482730454";
$PROFAR{6.1}="0.7041180468";
$PROFAR{6.2}="0.6926658809";
$PROFAR{6.3}="0.715338279";
$PROFAR{6.4}="0.9116518111";
$PROFAR{6.5}="0.4558259056";
$PROFAR{6.6}="8";
$PROFAR{6.7}="0.432937182";
$PROFAR{6.8}="0.5885919101";
$PROFAR{6.9}="0.5885919101";
$PROFAR{6.1}="0.8376471982";
$PROFAR{6.11}="0.4243496364";
$PROFAR{6.12}="0.7317796681";
$PROFAR{6.13}="0.2883073149";
$PROFAR{6.14}="0.2652835786";
$PROFAR{6.15}="0.2748557433";
$PROFAR{6.16}="0.2652835786";
$PROFAR{6.17}="0.6103991888";
$PROFAR{6.18}="0";
$PROFAR{7.1}="0.6868452857";
$PROFAR{7.2}="0.6309042177";
$PROFAR{7.3}="0.8471302153";
$PROFAR{7.4}="0.6749979139";
$PROFAR{7.5}="0.7988420159";
$PROFAR{7.6}="0.2903855522";
$PROFAR{7.14}="0.4456079477";
$PROFAR{7.7}="0.3117587633";
$PROFAR{7.8}="0.5105668668";
$PROFAR{7.9}="0.2237876876";
$PROFAR{7.1}="0.5482730454";
$PROFAR{7.11}="0.5302067683";
$PROFAR{7.12}="0.3610693472";
$PROFAR{7.13}="0.2923791603";
$PROFAR{8.1}="0.3262108937";
$PROFAR{8.2}="0.432937182";
$PROFAR{8.3}="0.3110739045";
$PROFAR{8.4}="0.3137661796";
$PROFAR{8.5}="0.4170246113";
$PROFAR{8.6}="0.2334268862";
$PROFAR{8.7}="0.2666965368";
$PROFAR{8.8}="0.4613629121";
$PROFAR{9.1}="0.5534415926";
$PROFAR{9.2}="0.2172939948";
$PROFAR{9.3}="0.5302067683";
$PROFAR{9.4}="0.3643348937";
$PROFAR{10.1}="0.4243496364";
$PROFAR{10.2}="0";
$PROFAR{11.1}="0.2961426786";
return %PROFAR;
}

sub fillPRA{
$PRA{2.1}="0";
$PRA{2.1}="0.2751259268";
$PRA{2.2}="0.2612143536";
$PRA{2.3}="0";
$PRA{2.4}="0";
$PRA{2.5}="0.2590592425";
$PRA{3.1}="0.2789379542";
$PRA{3.2}="0.3163404813";
$PRA{3.3}="0.2996486169";
$PRA{3.4}="0.2776189187";
$PRA{3.5}="0.3037270507";
$PRA{3.6}="0.2802190904";
$PRA{4.1}="0.3117587633";
$PRA{4.2}="0.3029357508";
$PRA{4.3}="0.3052760123";
$PRA{4.4}="0.3067825972";
$PRA{4.5}="0.3052760123";
$PRA{4.6}="0.300489605";
$PRA{4.7}="0.3021327016";
$PRA{4.8}="0.3251270492";
$PRA{4.9}="0.3150672867";
$PRA{4.1}="0.2903855522";
$PRA{4.11}="0.2872336648";
$PRA{4.12}="0.300489605";
$PRA{4.13}="0.3124356138";
$PRA{5.1}="0.2652835786";
$PRA{5.2}="0.2776189187";
$PRA{5.3}="0.2776189187";
$PRA{5.4}="0.25";
$PRA{5.5}="0.2961426786";
$PRA{5.6}="0.2826773615";
$PRA{5.7}="0.2979251903";
$PRA{5.8}="0.2789379542";
$PRA{5.9}="0.2861353116";
$PRA{5.1}="0.2814648129";
$PRA{5.11}="0.244086396";
$PRA{5.12}="0.2550487698";
$PRA{5.13}="0.3963725969";
$PRA{5.14}="0.2703455283";
$PRA{5.15}="0.3576691395";
$PRA{5.16}="0";
$PRA{5.17}="0.294295955";
$PRA{5.18}="0.2486154361";
$PRA{6.1}="0.2838587622";
$PRA{6.2}="0.3029357508";
$PRA{6.3}="0.2838587622";
$PRA{6.4}="0.3029357508";
$PRA{6.5}="0.294295955";
$PRA{6.6}="0.2838587622";
$PRA{6.7}="0.2573302684";
$PRA{6.8}="0.2434330646";
$PRA{6.9}="0.25";
$PRA{6.1}="0.2703455283";
$PRA{6.11}="0";
$PRA{6.12}="0.2550487698";
$PRA{6.13}="0.2996486169";
$PRA{6.14}="0.3464935454";
$PRA{6.15}="0.3175871859";
$PRA{6.16}="0.3272768218";
$PRA{6.17}="0";
$PRA{6.18}="0.2424278429";
$PRA{7.1}="0.2719031068";
$PRA{7.2}="0.2776189187";
$PRA{7.3}="0.2802190904";
$PRA{7.4}="0.2615125171";
$PRA{7.5}="0.2687271663";
$PRA{7.6}="0.2903855522";
$PRA{7.14}="0.2802190904";
$PRA{7.7}="0.27340502";
$PRA{7.8}="0.2403907462";
$PRA{7.9}="0.2913924187";
$PRA{7.1}="0.2573302684";
$PRA{7.11}="0.2380578601";
$PRA{7.12}="0.2329682816";
$PRA{7.13}="0.3082495143";
$PRA{8.1}="0.2855764383";
$PRA{8.2}="0.3293577468";
$PRA{8.3}="0.3082495143";
$PRA{8.4}="0.3262108937";
$PRA{8.5}="0.3150672867";
$PRA{8.6}="0.3137661796";
$PRA{8.7}="0.2996486169";
$PRA{8.8}="0.2838587622";
$PRA{9.1}="0.4295713217";
$PRA{9.2}="0.3576691395";
$PRA{9.3}="0.5206113268";
$PRA{9.4}="0.3272768218";
$PRA{10.1}="0.3790359515";
$PRA{10.2}="0.42785468";
$PRA{11.1}="0.2622382574";
return %PRA;
}
