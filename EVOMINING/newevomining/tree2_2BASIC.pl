#!/usr/bin/perl
use CGI::Carp qw(fatalsToBrowser);
use CGI;
use Fcntl ; use DB_File ; $tipoDB = "DB_File" ; $RWC = O_CREAT|O_RDWR;
 $tfm = "/var/www/newevomining/blast/BBH/hashMETCENTRAL22.db" ;
 $hand = tie  %hashMETCENTRAL, $tipoDB , "$tfm" , 0 , 0644 ;

my %Input;
my $query = new CGI;
my @pairs = $query->param;

foreach my $pair(@pairs){
$Input{$pair} = $query->param($pair);
}

print $query->header,
      $query->start_html(-style => {-src => '/newevomining/css/tabla3.css'} );


########################ANTISMASH###################################

@filesanti=`ls /var/www/newevomining/blast/seqf/tree/antismashPAblo/`;
foreach my $x( @filesanti){
  chomp($x);
  open(SMASH,"/var/www/newevomining/blast/seqf/tree/antismashPAblo/$x");
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
open (NP,"/var/www/newevomining/NPDB/NATURAL_PRODUCTS_DB3.fasta");
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

open(HASHBLAST, "/var/www/newevomining/blast/pscp120315repared.blast");
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
system "cp /var/www/newevomining/blast/seqf/tree/ornament.$numFile /var/www/newevomining/blast/seqf/tree/ornament.$numFile.edit";

chdir "/var/www/newevomining/blast/seqf/";
system "nw_labels -I tree/$numFile.tree > tree/$numFile.labels";
open (LABELS, "tree/$numFile.labels");
open (OUTLABELS, ">tree/$numFile.mapp");
$cuentaNum=0;
while (<LABELS>){
 chomp;
 $cuentaNum++;
 $nameG=$_;
 $nameG=~ s/\d+\|//;
 @giA=split(/\|/,$_);
 
 ########################### ANTISMASH ##############
 open (CK, ">tree/$numFile.mapp");
   if(exists $hashANTISMASHid{$giA[0]}){
     $antSMASHstring=$antSMASHstring.'"stroke-width:7; stroke:cyan" Individual '.$_."\n";
    $antSMASHcircle=$antSMASHcircle. qq|"<circle style='fill:cyan;stroke:black' r='9'/>" I $_\n|;
   }
   
 ###########################FIN  ANTISMASH ##############
 #-------------------NP--------------------------------
    if(exists $hashNP{$giA[0]}){
      $NPs=$NPs.'"stroke-width:7; stroke:blue" Individual '.$_."\n";
      $NPc=$NPc. qq|"<circle style='fill:blue;stroke:black' r='8'\/>" I $_\n|;
   }
    
 
 #------------------FIN NP-----------------------------
 
 if(exists $hashMETCENTRAL{$giA[0]}){
  ######################################## 
  #------****MEtabolismo central***-------
  ########################################
  
   #print OUTLABELS "$_	$giA[0]\n";
   #print OUTLABELS "$_	$nameG\n";
   if(exists $Input{GenomeName} and exists $Input{GI}){
      $METcentral=$_;
    }
    elsif(!exists $Input{GenomeName} and exists $Input{GI}){
     $METcentral=$giA[0];
    }
    elsif(!exists $Input{GenomeName} and !exists $Input{GI}){
     $METcentral='.';
    }
    elsif(exists $Input{GenomeName} and !exists $Input{GI}){
     $METcentral=$nameG;
    }
    else{ #default settings
     $METcentral=$giA[0];
    
    }
    
   print OUTLABELS "$_	$METcentral\n";
   push(@QC, $METcentral);
 
 }
 else{
   print OUTLABELS "$_	$_\n";

 }
}
close LABELS;
close OUTLABELS;
open (EDIT, ">>tree/ornament.$numFile") or die $!;
foreach my $cc (@QC){
 print EDIT "\n";
 if($cc =~/\./ or $cc eq '' or $cc eq ' '){
  next;
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
      @listClade = `nw_clade -c $numClades /var/www/newevomining/blast/seqf/tree/$numFile.tree $y|nw_labels -I -`; 
      foreach my $x (@listClade){
        chomp($x); 
	
	if($x !~ /\|/){
	  next  # si no es un gi|genoma # seria un NP KR
	}
	print OUTKRR "$y->$numClades->$x->$cadenaKR\n";
	@gi_genoma=split (/\|/,$x);
	$hashIDT{$gi_genoma[0]}=$x;
	
        if (!exists $hashMETCENTRAL{$gi_genoma[0]} and !exists $hashANTISMASHid{$gi_genoma[0]}){
	   $cadenaKR=$hashIDT{$gi_genoma[0]}." ".$cadenaKR;
	   $flagcadenaKR=1;#print OUTKRR "$gi_genoma[0]--$x--$hashMETCENTRAL{$gi_genoma[0]}--$hashANTISMASHid{$gi_genoma[0]}\n"; 
	}
	if(exists $hashMETCENTRAL{$gi_genoma[0]}){
	   $cadenaKR='';
	   delete $hashKR{$y};
	   $flagcadenaKR=0;
	   print OUTKRR "ES ROJOO:$gi_genoma[0]--$y->$numClades->$x->$cadenaKR\n";
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
system "nw_rename -l tree/$numFile.tree tree/$numFile.mapp |nw_display -w 10600 -$round  -S -v 100 -i 'font-size:xx-small' -b 'opacity:0' -i 'visibility:hidden' -c tree/$numFile.map2 -o tree/ornament2.$numFile ->tree/$numFile.p.svg";
open(OPT, ">/var/www/newevomining/blast/seqf/tree/$numFile.prueba2.svg");
open(OP, "/var/www/newevomining/blast/seqf/tree/$numFile.p.svg");
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

 print qq|
  <html>
 <head>
 <title></title>
 </head>
 <body>$string
 <div class="container"> <!-- CONTENEDOR PRINCIPAL 12col -->
 <div class="col-md-8">
 <table class="table table-bordered">
 <object type="image/svg+xml" name="viewport" data="tree/$numFile.p.svg" width="1730" height="1500"></object>
 <script type="text/javascript">
  $(document).ready(function() {
  $('svg#outer').svgPan('viewport');
   });
   </script>
   </table>
   </div>
  </div>  <!-- CONTENEDOR PRINCIPAL 12col -->
|;
 
print qq|

 </body>
 </html>|;
  exit; 

