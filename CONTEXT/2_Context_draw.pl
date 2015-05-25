##################################################################################
    use strict;
    use warnings;
     
    use SVG;
####################################################################
# Need to improve: Resize window for more gene
## Check genes are on the same contig
#
####################################################################3
############### set canvas 

my $nClust=17; #number of cluster (until now one per organism)
		#3 Used to draw lines

my $w=800;  ## Size of the window
my $h=100*($nClust+1); # 100 of heigth for draw each organisms
my %ColorNames=fillColors();


 
## Read context
# open all context files
my @CLUSTERS=qx/ls *.input/; ## Read all input

# Store %CONTEXT[$cluster_Id]=([start,end,direction,blast_id]   );
#           HAsh of arrays(genes) 
my %CONTEXTS=ReadContexts(@CLUSTERS);

#########################################################
######## Main 
    # create an SVG object with a size of 40x40 pixels
    my $svg = SVG->new(  width  => $w,height => $h,onload=>'Init(evt)',
   onmousemove=>' GetTrueCoords(evt); ShowTooltip(evt, true)',
   onmouseout=>'ShowTooltip(evt, false)');



my $tag = $svg->script(-type=>"text/ecmascript");
#or my $tag = $svg->script();
#note that type ecmascript is not Mozilla compliant
 
# populate the script tag with cdata
# be careful to manage the javascript line ends.
# Use qq{text} or q{text} as appropriate.
# make sure to use the CAPITAL CDATA to poulate the script.
$tag->CDATA(qq{
         var SVGDocument = null;
      var SVGRoot = null;
      var SVGViewBox = null;
      var svgns = 'http://www.w3.org/2000/svg';
      var xlinkns = 'http://www.w3.org/1999/xlink';
      var toolTip = null;
      var TrueCoords = null;
      var tipBox = null;
      var tipText = null;
      var tipTitle = null;
      var tipDesc = null;

      var lastElement = null;
      var titleText = '';
      var titleDesc = '';


      function Init(evt)
      {
         SVGDocument = evt.target.ownerDocument;
         SVGRoot = document.documentElement;
         TrueCoords = SVGRoot.createSVGPoint();

         toolTip = SVGDocument.getElementById('ToolTip');
         tipBox = SVGDocument.getElementById('tipbox');
         tipText = SVGDocument.getElementById('tipText');
         tipTitle = SVGDocument.getElementById('tipTitle');
         tipDesc = SVGDocument.getElementById('tipDesc');
      };


      function GetTrueCoords(evt)
      {
         // find the current zoom level and pan setting, and adjust the reported
         //    mouse position accordingly
         var newScale = SVGRoot.currentScale;
         var translation = SVGRoot.currentTranslate;
         TrueCoords.x = (evt.clientX - translation.x)/newScale;
         TrueCoords.y = (evt.clientY - translation.y)/newScale;
      };




      function ShowTooltip(evt, turnOn)
      {
         try
         {
            if (!evt || !turnOn)
            {
               toolTip.setAttributeNS(null, 'display', 'none');
            }
            else
            {
               var tipScale = 1/SVGRoot.currentScale;
               var textWidth = 0;
               var tspanWidth = 0;
               var boxHeight = 20;

               tipBox.setAttributeNS(null, 'transform', 'scale(' + tipScale + ',' + tipScale + ')' );
               tipText.setAttributeNS(null, 'transform', 'scale(' + tipScale + ',' + tipScale + ')' );

               var targetElement = evt.target;

               if ( lastElement != targetElement )
               {
                  var targetTitle = targetElement.getElementsByTagName('title').item(0);
                  if ( targetTitle )
                  {
                     titleText = targetTitle.firstChild.nodeValue;
                     tipTitle.firstChild.nodeValue = titleText;
                  }

                  var targetDesc = targetElement.getElementsByTagName('desc').item(0);
                  if ( targetDesc )
                  {
                     titleDesc = targetDesc.firstChild.nodeValue;
                     tipDesc.firstChild.nodeValue = titleDesc;
                  }
               }

               var xPos = TrueCoords.x + (10 * tipScale);
               var yPos = TrueCoords.y + (10 * tipScale);

               //return rectangle around object as SVGRect object
               var outline = tipText.getBBox();
               tipBox.setAttributeNS(null, 'width', Number(outline.width) + 10);
               tipBox.setAttributeNS(null, 'height', Number(outline.height) + 10);

               toolTip.setAttributeNS(null, 'transform', 'translate(' + xPos + ',' + yPos + ')');
               toolTip.setAttributeNS(null, 'display', 'inline');
            }
         }
         catch(er){}
       };
});









	##In one svg object I have accumulated all clusters
	##May be for the function visualization we may use more than one

    # add lines
	for (my $i=1;$i<=$nClust;$i++){
   		line($i,$w);    
 	}

# add context

	drawContexts(\%CONTEXTS,$w,\%ColorNames);

	
#_________________________________________________________________
#####################################################################
##Html output (Sending files to firefox
#####################################################################
open (OUT, ">black_circle.svg") or die $!;
    # now render the SVG object, implicitly use svg namespace
    print OUT $svg->xmlify;
close OUT;
     
#open (OUT, ">AUTprobe.html") or die $!;
#print OUT qq|<img src="black_circle.svg" alt="black circle"/> |;
#close OUT;
system "firefox black_circle.svg";

##################################################################
###    subs ######################################################

sub arrow{
  my $start=shift;
  my $end=shift;
  my $org=shift;
  my $dir=shift;
  my $color=shift;
  my $level=shift;
  my $DirCont=shift;
  my $w=shift;  
  my $e0=shift;
  my $func=shift;
  my $id_peg=shift;
  my $desc=$start." ".$end." ".$dir." ".$id_peg."\n".$func;

  my $color1;
  my $color2;
  my $color3;
	
  if ($color==0){ #gris
	$color1=144;
	$color2=130;
	$color3=130;
	}

  elsif($color==1){ #azul
	$color1=10;
	$color2=150;
	$color3=235;
	}
elsif($color==2){ #rosa mexicano
	$color1=235;
	$color2=10;
	$color3=150;
	}

  elsif($color==3){ #Rosa palido
	$color1=252;
	$color2=155;
	$color3=236;
	}
  
  elsif($color==4){ #Verde
	$color1=25;
	$color2=67;
	$color3=10;
	}
  elsif($color==5){ #Amarillo
	$color1=249;
	$color2=249;
	$color3=69;
	}
  elsif($color==6){ #lila claro
	$color1=249;
	$color2=207;
	$color3=280;
	}
  elsif($color==7){#durazno
	$color1=249;
	$color2=129;
	$color3=69;
	}
  elsif($color==8){ #azul claro
	$color1=69;
	$color2=249;
	$color3=234;
	}

  elsif($color==9){ #Amarillo huevo
	$color1=248;
	$color2=202;
	$color3=37;
	}
  elsif($color==11){ #Rojo
	$color1=235;
	$color2=10;
	$color3=74;
	}

 elsif ($color==10){ #Azul celeste
	$color1=30;
	$color2=134;
	$color3=136;
	}
  elsif($color==12){ #Morado
	$color1=235;
	$color2=10;
	$color3=231;
	}
  elsif($color==13){ #Azul
	$color1=10;
	$color2=10;
	$color3=235;
	}

  elsif($color==14){#cafe
	$color1=100;
	$color2=70;
	$color3=10;
	}
  elsif($color==15){ #verde fosforescente
	$color1=70;
	$color2=249;
	$color3=10;
	}
  elsif($color==16){ #azul-morado
	$color1=24;
	$color2=27;
	$color3=69;
	}
  elsif($color==17){ #NAranja
	$color1=249;
	$color2=129;
	$color3=0;
	}
  elsif($color==18){ #morado
	$color1=69;
	$color2=49;
	$color3=80;
	}
 elsif($color==19){ #amarillo
	$color1=231;
	$color2=221;
	$color3=20;
	}
 elsif($color==20){#gris-amarillo
	$color1=80;
	$color2=80;
	$color3=20;
	}



  #start arrow end arrow organism number direction
  my ($u1,$u2,$u3,$u4,$u5,$v1,$v2,$v3,$v4,$v5);
  ##up start
  $u1=$start; $v1=$org*100-10;
  ##down start
  $u2=$start; $v2=$org*100+10;
  
  if ($dir eq "+"){
      ##down rigth
      $u3=$end-10;  $v3=$org*100+10;
      ##pick
      $u4=$end;  $v4=$org*100;
     ##up rigth
     $u5=$end-10; $v5=$org*100-10;
  }  
  else{
      ##down left
      $u3=$end+10; $v3=$org*100+10;
      #pick
      $u4=$end;  $v4=$org*100;
      #up rigth
      $u5=$end+10; $v5= $org*100-10;
  }  
	# Treating genes supermiposed
	if ($level==2){$v1=$v1+30; $v2+=30;$v3+=30;$v4+=30;$v5+=30;}
	if ($level==3){$v1=$v1+60; $v2+=60;$v3+=60;$v4+=60;$v5+=60;}

	## Reversing when hit is in contra sense direction
	
	##if($DirCont==-1){$u1=-$u1+$w/2+$e0; $u2=-$u2+$w/2+$e0; $u3=-$u3+$w/2+$e0;$u4=-$u4+$w/2+$e0;$u5=-$u5+$w/2+$e0;} 
	if($DirCont==-1){$u1=-$u1+$w; $u2=-$u2+$w; $u3=-$u3+$w;$u4=-$u4+$w;$u5=-$u5+$w;} 

	my $path = $svg->get_path(x => [$u1, $u2, $u3,$u4,$u5],   y => [$v1, $v2, $v3,$v4,$v5],  -type => 'polygon');
 
	# Then we use that data structure to create a polygon
	$svg->polygon(  %$path,title=>"$desc",style => {'fill'=> "rgb($color1,$color2,$color3)",'stroke' => 'black',
			'stroke-width' =>1,'stroke-opacity' =>  1,'fill-opacity'=> 1,},);
	}

#______________________________________________________________________________________________

sub line{
	my $nClust=shift;
	my $w=shift;

	my $xv = [0, $w];
	my $yv = [$nClust*100, $nClust*100];
	my $points = $svg->get_path(x=> $xv,y => $yv,-type => 'polyline',);
	$svg->polyline ( %$points,style => {'fill-opacity' => 0,'stroke'=> 'rgb(250,123,23)'});
	}
#______________________________________________________________________________________________
sub ReadContexts{  ###Here we read all the .input files
	my @CLUSTERS=@_;
	my %CONTEXTS;

	foreach my $context(@CLUSTERS){
		chomp $context;
		my $key=$context;
		$key=~s/\.input//;
		print "Key $key Context: $context \n";

		open(FILE,$context) or die "Could not open file $context $!";	
		##For each genome a Hash of array HAsh keys:functions Array Contents: gene with that function
		#my $count=0;
		$CONTEXTS{$key}=[];
	
		while ( my $line = <FILE> ) {
			my @st=split("\t",$line); 
			
			my $start=$st[0]; #print "Start $start\n";
			push (@{$CONTEXTS{$key}}, $start);

			my $stop=$st[1]; #print "Stop $stop\n";
			push (@{$CONTEXTS{$key}}, $stop);
			
			my $dir=$st[2];	 #print "dir $dir\n";		
			push (@{$CONTEXTS{$key}}, "$dir");

			my $color=$st[3]; 
			push (@{$CONTEXTS{$key}}, $color);

			my $org=$st[4]; 
			push (@{$CONTEXTS{$key}}, $org);

			my $func=$st[5]; 
			push (@{$CONTEXTS{$key}}, $func);

			my $id_peg=$st[6]; chomp $org; #print "color $color#\n";
			push (@{$CONTEXTS{$key}}, $id_peg);


			}	
		close FILE;			
		}

	return %CONTEXTS;
	}
#________________________________________________________________________________________________________________

# Draw an arrow for each gen for each cluster
sub drawContexts{
my $refCONTEXTS=shift;
my $w=shift;
my $refColorNames=shift;
my $traslation=0;
my $Rescale=19000;

	foreach my $key(keys %{$refCONTEXTS}){  ###For each cluster

		my %ARROWS;

		#### Read the main hit ###############################################
		my $X0=$refCONTEXTS->{$key}[0];		
		my $E0=$refCONTEXTS->{$key}[1];
		my $e0=abs(int((($w/$Rescale)*($E0-$X0)+$w/2)));
		
		
		my $D0=$refCONTEXTS->{$key}[2]; #Direction fo the hit
		print "X0 $X0 D0 $D0\n"; ##Acomodar el hit deseado al principio en input file
		my $DirCont;
		if ($D0 eq '+'){ $DirCont=1;}else{$DirCont=-1;} 
		
		####### Get the orgnism NAme	
		my $orgName=$refCONTEXTS->{$key}[4]; 
		print "####################\n$orgName\n###########################\n";
		$svg->text( x  => 10, y  => $key*100-20)->cdata("$orgName"); 
		####################################################################

		for (my $i=0;$i<@{$refCONTEXTS->{$key}}/7;$i++){
			my $start=$refCONTEXTS->{$key}[7*$i];
			my $stop=$refCONTEXTS->{$key}[7*$i+1];
			my $s1=int((($w/$Rescale)*($start-$X0)+$w/2)); 
			my $e1=int((($w/$Rescale)*($stop-$X0)+$w/2));
			my $dir=$refCONTEXTS->{$key}[7*$i+2];
			my $color=$refCONTEXTS->{$key}[7*$i+3];
			my $func=$refCONTEXTS->{$key}[7*$i+5];
			my $id_peg=$refCONTEXTS->{$key}[7*$i+6];

			print "Key Start $start->$s1, stop $stop->$e1, dir $dir, color $refColorNames->{$color} \n";
			if($dir eq '+'){
			$ARROWS{$s1}=[$s1,$e1,$key,$dir,$color,$DirCont,$w,$e0,$func,$id_peg];
					}
			else{
			$ARROWS{$e1}=[$s1,$e1,$key,$dir,$color,$DirCont,$w,$e0,$func,$id_peg];
					}
		}
		### Once I have all arrows on a cluster I sorted them and I set the levels, need to change levels to real coordinates not translated ones
		my $level=1; my $count=0; my $lastStop=0;	
                for my $arrow(sort keys %ARROWS){
			my $s1=$ARROWS{$arrow}[0];
			my $e1=$ARROWS{$arrow}[1];
			my $key=$ARROWS{$arrow}[2];
			my $dir=$ARROWS{$arrow}[3];
			my $color=$ARROWS{$arrow}[4];
			my $dirCont=$ARROWS{$arrow}[5];
			my $w=$ARROWS{$arrow}[6];
			my $e0=$ARROWS{$arrow}[7];
			my $func=$ARROWS{$arrow}[8];
			my $id_peg=$ARROWS{$arrow}[9];

			if ($count>=1){ ##From level 1 we can go level 2 or stay 1
				my $lastlevel=$level;
			
				if($lastlevel==2){$level=1; print "Chang from 2 to 1";}

				if($arrow<=$lastStop and $lastlevel==1){
					$level=2; print("Change form 1 to level=2\n");
					}
				elsif($arrow<=$lastStop and $lastlevel==2){
					$level=3; print("Change from 2 to level=3\n");
					}
				else{
					$level=1;
					}				
				} 	

			if ($dir eq '+'){$lastStop=$e1;}
			else{$lastStop=$s1;} $count++;
			$level=1; ##Uncomment to set everything to the same level
			arrow($s1,$e1,$key,$dir,$color,$level,$DirCont,$w,$e0,$func,$id_peg);
			print ("$s1,$e1,$key,$dir,$color,$level,$DirCont,$w,$e0,$func,$id_peg\n");		
			}


		}
	}
#_____________________________________________________________________________________


sub fillColors(){
	my %ColorNames=(
		"0"=>"gris",
		"1"=>"Rojo",
		"2"=>"Morado",
		"3"=>"Azul",
		"4"=>"Verde",
		"5"=>"Amarillo",
		"6"=>"LilaClaro",
		"7"=>"Durazno",
		"8"=>"AzulClaro",
		"9"=>"Cafe",
		"10"=>"AzulCeleste",
		"11"=>"RosaMexicano",
		"12"=>"RosaPalido",
		"13"=>"Azul",
		"14"=>"Cafe",
		"15"=>"VerdeFosforescente",
		"16"=>"AzulMorado",
		"17"=>"Naranja",
		"18"=>"Morado",
		"19"=>"Amarillo",
		"20"=>"GrisAmarillo",
		);
	return %ColorNames;
	}

