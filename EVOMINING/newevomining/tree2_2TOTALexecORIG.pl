#!/usr/bin/perl
use CGI::Carp qw(fatalsToBrowser);
use CGI;
use Fcntl ; use DB_File ; $tipoDB = "DB_File" ; $RWC = O_CREAT|O_RDWR;
 #$tfm = "/var/www/newevomining/blast/BBH/hashMETCENTRAL22.db" ;
 my $apacheCGIpath="/home/evoMining/newevomining";
 my $newickPATH="/opt/newick-utils-1.6/src";
 my $apacheHTMLpath="/var/www/html/evoMining";
 
 
 $tfm = "$apacheCGIpath/blast/BBH/losDiez/hashMETCENTRALDIEZ.db" ;
 $hand = tie  %hashMETCENTRAL, $tipoDB , "$tfm" , 0 , 0644 ;

my %Input;
my $query = new CGI;
my @pairs = $query->param;

foreach my $pair(@pairs){
$Input{$pair} = $query->param($pair);
}

print $query->header,
      $query->start_html(-style => {-src => '/html/evoMining/css/tabla3.css'} );

$prenumFile=$ENV{'QUERY_STRING'};
@arraynumFile=split(/&&/,$prenumFile);
$numFile=$arraynumFile[0];
$outdir=$arraynumFile[1];
########################ANTISMASH###################################

@filesanti=`ls $apacheCGIpath/blast/seqf/tree/antismashPAblo/`;
foreach my $x( @filesanti){
  chomp($x);
  open(SMASH,"$apacheCGIpath/blast/seqf/tree/antismashPAblo/$x");
  #print "--$x--\n";
  while(<SMASH>){
    chomp;
    @asmash=split (/\t/,$_);
    @bsmash=split (/\|/,$asmash[1]);
    @csmash=split (/\_/,$bsmash[0]);
    $hashANTISMASHid{$csmash[1]}=$csmash[1];
    #print  "$csmash[1]\n";
    #<STDIN>;
   
  }
  close SMASH;
  
}
######################## END ANTISMASH###################################

#-----------------------indexado de NP-----------------------------------
open (NP,"$apacheCGIpath/NPDB/NATURAL_PRODUCTS_DB3.fasta");
while(<NP>){
 chomp;
 if($_ =~ />/){
  $_ =~ s/>//;
  $hashNP{$_}=$_;
 }

}
close NP;

#--------------------FIN de indexado de NP-------------------------------

#------------hash MEt central extraido del resultado blastp pscp.blast------
#system "/opt/ncbi-blast-2.2.28+/bin/makeblastdb -in /var/www/newevomining/PasosBioSin/GlycolysisnewHEADER.fasta  -dbtype prot  -out /var/www/newevomining/PasosBioSin/GlycolysisnewHEADER.db"; # funciona con archivos .fasta.new
#system "/opt/ncbi-blast-2.2.28+/bin/blastp -db /var/www/newevomining/PasosBioSin/GlycolysisnewHEADER.db -query /var/www/newevomining/DB/ALLv3.out -outfmt 6 -num_threads 4 -evalue 0.0001 -out /var/www/newevomining/blast/bscp.blast";

#open(HASHBLAST, "/var/www/newevomining/blast/pscp120315repared.blast");
open(HASHBLAST, "$apacheCGIpath/blast/pscplosdiez.blast");
while (<HASHBLAST>){
  chomp; 
  @resblast=split(/\t/,$_);
  @datosMEtCent=split(/\|/,$resblast[1]);
  $llaveHash="$datosMEtCent[1]|$datosMEtCent[5]";
  $hashCENTMET{$llaveHash}="$datosMEtCent[1]|$datosMEtCent[5]";
  
}

close HASHBLAST;
#------------END  hash MEt central extraido del resultado blastp pscp.blast------

#read (STDIN, $FormData, $ENV{'CONTENT_LENGHT'});
#@pairs=split (//, $FormData);

foreach my $x (keys %Input){
$acum=$acum."$x-->$ENV{$x}=====";


}

 print qq |
 <div class="encabezado">
</div>
<div class="expandedd">$aacum</div>
|;
$prenumFile=$ENV{'QUERY_STRING'};
@arraynumFile=split(/&&/,$prenumFile);
$numFile=$arraynumFile[0];
$outdir=$arraynumFile[1];



if(exists $Input{round}){
  $round='sr';
}
else{
  $round='sr';
}

#open(INPUT, ">/var/www/newevomining/blast/seqf/tree/$numFile.inputWEB");
#foreach my $c (keys %Input){
  #print INPUT "llave: $c  valor:$Input{$c}\n";
 # print "llave: $c  valor:$Input{$c}\n";
#}
#close INPUT;
system "cp $apacheCGIpath/$outdir/blast/seqf/tree/ornament.$numFile $apacheCGIpa21730_ThuFeb112016th/$outdir/blast/seqf/tree/ornament.$numFile.edit";

chdir "$apacheCGIpath/$outdir/blast/seqf/";
system "$newickPATH/nw_labels -I tree/$numFile.tree > tree/$numFile.labels";
open (LABELS, "tree/$numFile.labels");
open (OUTLABELS, ">tree/$numFile.mapp");
$cuentaNum=0;
while (<LABELS>){
 chomp;
 $cuentaNum++;
 $nameG=$_;
 #$nameG=~ s/\d+\|//;
 @giA=split(/\|/,$_);
 $nameG=$giA[$#gia];
 
 ########################### ANTISMASH ##############
 open (CK, ">tree/$numFile.mapp");
   if(exists $hashANTISMASHid{$giA[1]}){
     $antSMASHstring=$antSMASHstring.'"stroke-width:7; stroke:cyan" Individual '.$_."\n";
    $antSMASHcircle=$antSMASHcircle. qq|"<circle style='fill:cyan;stroke:black' r='9'/>" I $_\n|;
   }
   
 ###########################FIN  ANTISMASH ##############
 #-------------------NP--------------------------------
    if(exists $hashNP{$giA[1]}){
      $NPs=$NPs.'"stroke-width:7; stroke:blue" Individual '.$_."\n";
      $NPc=$NPc. qq|"<circle style='fill:blue;stroke:black' r='8'\/>" I $_\n|;
   }
    
 
 #------------------FIN NP-----------------------------
 #print "lalalalalalala$giA[1]\n";
 if(exists $hashMETCENTRAL{$giA[1]}){
 
  ######################################## 
  #------****MEtabolismo central***-------
  ########################################
  
   #print OUTLABELS "$_	$giA[0]\n";
   #print OUTLABELS "$_	$nameG\n";
   if(exists $Input{GenomeName} and exists $Input{GI}){
      $METcentral=$_;
    }
    elsif(!exists $Input{GenomeName} and exists $Input{GI}){
     $METcentral=$giA[1];
    }
    elsif(!exists $Input{GenomeName} and !exists $Input{GI}){
     $METcentral='.';
     
    }
    elsif(exists $Input{GenomeName} and !exists $Input{GI}){
     $METcentral=$nameG;
    }
    else{ #default settings
     $METcentral=$giA[1];
    
    }
    $METcentral=$giA[1].'|'.$giA[$#giA];
   print OUTLABELS "$_	$METcentral\n";
   push(@QC, $METcentral);
 
 }
 else{
  # print OUTLABELS "$_	$_\n";

 }
}
close LABELS;
close OUTLABELS;
open (EDIT, ">>tree/ornament.$numFile") or die $!;
foreach my $cc (@QC){
##print "siiiiii/$METcentral\n";
 print EDIT "\n";
 if($cc =~/\./ or $cc eq '' or $cc eq ' '){
  #next;
 }
 print EDIT $NPc;
 print EDIT qq|"<circle style='fill:red;stroke:black' r='6'/>" I $cc|;
 print EDIT "\n";
}
print EDIT $antSMASHcircle;
close EDIT;

open (MAP, "tree/ornament.$numFile") or die $!;
open (OUTMAP, ">tree/$numFile.map") or die $!;

while(<MAP>){
 chomp;
 #=================== extrae known recruitments para tener la lista y procesar evoMining predictions=========
 if($_ =~ /"<circle style='fill:blue;stroke:black' r='8'\/>" I /){
   $stringKR=$_;
#   print KR "-----$_\n";
   $stringKR=~ s/"<circle style='fill:blue;stroke:black' r='8'\/>" I //;
   @knownRecruitments=split(/ /,$stringKR);
   foreach my $x (@knownRecruitments){
     $hashKR{$x}=$x;
     #print KR "$x\n";
   }

 }
 #===================  FIN extrae known recruitments para tener la lista y procesar evoMining predictions=========
 $_ =~ s/"<circle style='fill:blue;stroke:black' r='8'\/>" I/"stroke-width:7; stroke:blue" Individual/;
 $_ =~ s/"<circle style='fill:red;stroke:black' r='6'\/>" I/"stroke-width:6; stroke:red" C/;
 print OUTMAP "$_\n";
}
print OUTMAP $antSMASHstring;
close OUTMAP;
close MAP;
#----------------------- analiza KR con nw_clade-------
open (KR, ">tree/$numFile.kn") or die $!;
open (KRR, ">tree/$numFile.krr") or die $!;
open (OUTKRR, ">tree/$numFile.pruebaKR") or die $!;
 $numClades=-1;
 while($numClades<30){
 $numClades++;
  foreach my $y (keys %hashKR){
      @listClade = `$newickPATH/nw_clade -c $numClades $apacheCGIpath/$outdir/blast/seqf/tree/$numFile.tree $y|$newickPATH/nw_labels -I -`; 
      foreach my $x (@listClade){
        chomp($x); 
	
	if($x !~ /\|/){
	  next  # si no es un gi|genoma # seria un NP KR
	}
	#print OUTKRR "$y->$numClades->$x->$cadenaKR\n";
	
	@gi_genoma=split (/\|/,$x);
	print OUTKRR "$gi_genoma[1]\n";
	$hashIDT{$gi_genoma[1]}=$x;
	
        if (!exists $hashMETCENTRAL{$gi_genoma[1]} and !exists $hashANTISMASHid{$gi_genoma[0]}){
	   $cadenaKR=$hashIDT{$gi_genoma[1]}." ".$cadenaKR;
	   $flagcadenaKR=1;#print OUTKRR "$gi_genoma[0]--$x--$hashMETCENTRAL{$gi_genoma[0]}--$hashANTISMASHid{$gi_genoma[0]}\n"; 
	}
	if(exists $hashMETCENTRAL{$gi_genoma[1]}){
	   $cadenaKR='';
	   delete $hashKR{$y};
	   $flagcadenaKR=0;
	   print OUTKRR "ES ROJOO:$gi_genoma[1]--$hashMETCENTRAL{$gi_genoma[1]}\n";
	  last;
	}
	
	
      }#end clade
      
      if($flagcadenaKR==1){#print OUTKRR "lalalalal$flagcadenaK--$cadenaKR\n";
         print KRR qq|"<circle style='fill:#a5bb47;stroke:black' r='8'\/>" I $cadenaKR\n\n|;
         print KR qq|"stroke-width:8; stroke:#a5bb47" Individual $cadenaKR\n|;
        # print KR "-------$y\n";
      } 
       $cadenaKR='';
       $flagcadenaKR=0;
      #$cadenaKR=$y." ".$cadenaKR;
   }#end foreach @listClade 
    
 }#end while
 
  # print KR "$cadenaKR\n";
close KR; 
close KRR;
close OUTKRR;
system "cat tree/$numFile.krr tree/ornament.$numFile >tree/ornament2.$numFile";  
system "cat tree/$numFile.map tree/$numFile.kn>tree/$numFile.map2";  
#----------------------- END  analiza KR con nw_clade-------

#system "nw_rename -l tree/$numFile.tree tree/$numFile.map";
system "$newickPATH/nw_rename -l tree/$numFile.tree tree/$numFile.mapp |$newickPATH/nw_display -w 10600 -$round  -S -v 100 -i 'font-size:xx-small' -b 'opacity:0' -i 'visibility:hidden' -c tree/$numFile.map2 -o tree/ornament2.$numFile ->tree/$numFile.pp.svg";
#################### Nelly agregado prueba Feb 16 ######################
##########################################################################
 system "mkdir $apacheHTMLpath/$outdir";
 `perl -p -i -e 's/>/>\n/g' $apacheCGIpath/$outdir/blast/seqf/tree/$numFile.pp.svg`;
 `perl /home/evoMining/newevomining/blast/seqf/tree/zoom/ScaleSvg.pl $apacheCGIpath/$outdir/blast/seqf/tree/$numFile.pp.svg `;

system "cp $apacheCGIpath/$outdir/blast/seqf/tree/$numFile.pp.svg.new $apacheHTMLpath/$outdir/$numFile.pp.svg.new";

########################################33 Fin Nelly ##########################3


open(OPT, ">$apacheCGIpath/$outdir/blast/seqf/tree/$numFile.prueba2.svg")or die $!;
open(OP, "$apacheCGIpath/$outdir/blast/seqf/tree/$numFile.pp.svg.new");
 $cuentasust=0;
 while(<OP>){
  #$_ =~ s/<defs>/<script xlink:href="SVGPan\.js"/>/;
  $string=$string.$_; 
  $tempo=$string;
  if($cuentasust==0){
   $tempo =~ s/<defs>/<defs><script xlink\:href\=\"SVGPan\.js\"\/>/;
  
  }
  $cuentasust++;
  print OPT "$tempo";
 }


print qq¬
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Evolution - inspired Genome Mining Tool</title>
    <link rel="shortcut icon" href="images2/favicon.ico" type="image/x-icon">
    <link rel="icon" href="images2/favicon.ico" type="image/x-icon">
    <!-- Bootstrap -->
    <link href="/html/evoMining/css2/bootstrap.min.css" rel="stylesheet">
    <link href="/html/evoMining/css2/estilo.css" rel="stylesheet" type="text/css">
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-63898104-1', 'auto');
  ga('send', 'pageview');

</script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
 
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript">
    function target_popup(form) {
    window.open('', 'formpopup', 'width=400,height=200,resizeable,scrollbars');
    form.target = 'formpopup';
   }
   </script>
  </head>
  <body>

  <!-- header -->
  <div class="container-fluid" id="banner"><img src="/html/evoMining/images2/banner.png" width="940" height="140"></div>
  <!-- header -->
  <div class="container"> <!-- CONTENEDOR PRINCIPAL 12col -->

    <div class="col-md-9">
      <table class="table table-bordered">
        <tr>
          <td>
            <object type="image/svg+xml" name="viewport" data="/html/evoMining/$outdir/$numFile.pp.svg.new" width="100%" height="500"></object>
            <script type="text/javascript">
            $(document).ready(function() {
            $('svg#outer').svgPan('viewport');
            });
            </script>
          </td>
        </tr>
      </table>
    </div>
      <div class="col-md-3">
        <table class="table table-bordered">
          <tr>
            <td>
              <h4 id="verde">Color Code</h4>
                <form action="commentlog.pl" onsubmit="target_popup(this)" target="_blank" method="post">
                <div class="ratio">
                      <body>
    <canvas id="myCanvas" width="11" height="18"></canvas>
    <script>
      var canvas = document.getElementById('myCanvas');
      var context = canvas.getContext('2d');
      var centerX = canvas.width / 2;
      var centerY = canvas.height / 2;
      var radius = 3;

      context.beginPath();
      context.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);
      context.fillStyle = 'red';
      context.fill();
      context.lineWidth = 5;
      context.strokeStyle = 'red';
      context.stroke();
    </script> Orthologs from Central Metabolism
                    </br>
                    <canvas id="myCanvas2" width="12" height="18"></canvas>
    <script>
      var canvas = document.getElementById('myCanvas2');
      var context = canvas.getContext('2d');
      var centerX = canvas.width / 2;
      var centerY = canvas.height / 2;
      var radius = 3;

      context.beginPath();
      context.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);
      context.fillStyle = 'blue';
      context.fill();
      context.lineWidth = 5;
      context.strokeStyle = 'blue';
      context.stroke();
    </script> Known recruitments
                    </br>
                    <canvas id="myCanvas3" width="11" height="18"></canvas>
    <script>
      var canvas = document.getElementById('myCanvas3');
      var context = canvas.getContext('2d');
      var centerX = canvas.width / 2;
      var centerY = canvas.height / 2;
      var radius = 3;

      context.beginPath();
      context.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);
      context.fillStyle = 'cyan';
      context.fill();
      context.lineWidth = 5;
      context.strokeStyle = 'cyan';
      context.stroke();
    </script> EvoMining Hits (Detected by antiSMASH/Clusterfinder)
     </br>
                    <canvas id="myCanvas4" width="11" height="18"></canvas>
    <script>
      var canvas = document.getElementById('myCanvas4');
      var context = canvas.getContext('2d');
      var centerX = canvas.width / 2;
      var centerY = canvas.height / 2;
      var radius = 3;

      context.beginPath();
      context.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);
      context.fillStyle = '#a5bb47';
      context.fill();
      context.lineWidth = 5;
      context.strokeStyle = '#a5bb47';
      context.stroke();
    </script> EvoMining Predictions
                    </br>
                     <br>
                  
		  
                </div>
               <hr>
Send us your comments:
<p><label>E-mail: <input name="email" type="text" size="20" maxlength="254" /></label></p>
<p><label>Comment:<br /><textarea name="Comment" rows="3" cols="20"></textarea></label></p>
<p><input type="submit" value="Send Comment"  /></p>
</fieldset>

<input type='hidden' name="required" value="email,Comment" />
<input type="hidden" name="env_report" value="REMOTE_HOST,HTTP_USER_AGENT" />
<input type="hidden" name="hidden" value="Referring_Page_Link,Referring_Page_Title" />
<input type="hidden" name="Referring_Page_Link" value="http://www.google.com.mx/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=0CB0QFjAAahUKEwjHnbS5y4jGAhVODZIKHfzYANE&url=http%3A%2F%2Frevcom.us%2Fcommentform-en.php&ei=Nf55VYevI86ayAT8sYOIDQ&usg=AFQjCNFStLEMrNFcowXzUW7P3ZxteK5duA&bvm=bv.95277229,d.aWw">

<input type='hidden' name="redirect" value="http://revcom.us/commentsthanks.php" />
<input type="hidden" name="Referring_Page_Title" value="" />
<input type="hidden" name="subject" value="Comments Re: " />

                </form>
            </td>
          </tr>
        </table>
      </div>
 

      <div class="container-fluid" id="centrado">
        <tr>
          <td>
<p>

<IFRAME SRC="/cgi-bin/newevomining/sendtoDrawContext.pl?$outdir" name="iframe_abajo" WIDTH=810 HEIGHT=150 FRAMEBORDER=0 >  </IFRAME>





  </div>  <!-- CONTENEDOR PRINCIPAL 12col -->

  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
¬;
 


# print qq|
#  <html>
# <head>
# <title></title>
# </head>
# <body>/$string/
# <div class="container"> <!-- CONTENEDOR PRINCIPAL 12col -->
# <div class="col-md-8">
# <table class="table table-bordered">
# <object type="image/svg+xml" name="viewport" data="tree/$numFile.pp.svg" width="1730" height="1500"></object>
# <script type="text/javascript">
#  $(document).ready(function() {
#  $('svg#outer').svgPan('viewport');
#   });
#   </script>
#   </table>
#   </div>
#  </div>  <!-- CONTENEDOR PRINCIPAL 12col -->
#|;
 
#print qq|

# </body>
# </html>|;
  exit; 

