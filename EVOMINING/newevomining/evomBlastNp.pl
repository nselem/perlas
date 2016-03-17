#!/usr/bin/perl -w
#####################################################
# CODIGO PARA hacer Blast Vs NP
#
#####################################################

##use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI;

my %Input;
my $query = new CGI;


print $query->header,
      $query->start_html(-style => {-src => '/newevomining/css/tabla2.css'} );
my @pairs = $query->param;
foreach my $pair(@pairs){
$Input{$pair} = $query->param($pair);
}
($eval,$score2)=recepcion_de_archivo(); #Iniciar la recepcion del archivo

$hashothernames{'enolase2'}="enolase";
$hashothernames{'enolase1'}="enolase";
$hashothernames{'enolase4'}="enolase";
$hashothernames{'enolase3'}="enolase";
$hashothernames{'phosphoglyceratemutase1'}="phosphoglycerate mutase";
$hashothernames{'phosphoglyceratemutase2'}="phosphoglycerate mutase";
$hashothernames{'phosphoglyceratemutase3'}="phosphoglycerate mutase";
$hashothernames{'phosphoglyceratemutase4'}="phosphoglycerate mutase";
$hashothernames{'phosphoglyceratekinase1'}="phosphoglycerate kinase";
$hashothernames{'phosphoglyceratekinase2'}="phosphoglycerate kinase";
$hashothernames{'phosphoglyceratekinase3'}="phosphoglycerate kinase";
$hashothernames{'phosphoglyceratekinase4'}="phosphoglycerate kinase";
$hashothernames{'Triosephosphateisomerase1'}="Triosephosphate isomerase";
$hashothernames{'Triosephosphateisomerase2'}="Triosephosphate isomerase";
$hashothernames{'Triosephosphateisomerase3'}="Triosephosphate isomerase";
$hashothernames{'Triosephosphateisomerase4'}="Triosephosphate isomerase";
$hashothernames{'Fructosebiphosphatealdolase1'}="Fructose biphosphate aldolase";
$hashothernames{'Fructosebiphosphatealdolase2'}="Fructose biphosphate aldolase";
$hashothernames{'Fructosebiphosphatealdolase3'}="Fructose biphosphate aldolase";
$hashothernames{'Fructosebiphosphatealdolase4'}="Fructose biphosphate aldolase";
$hashothernames{'Phosphofructokinase1'}="Phosphofructokinase";
$hashothernames{'Phosphofructokinase2'}="Phosphofructokinase";
$hashothernames{'Phosphofructokinase3'}="Phosphofructokinase";
$hashothernames{'Phosphofructokinase4'}="Phosphofructokinase";
$hashothernames{'Phosphofructokinase5'}="Phosphofructokinase";
$hashothernames{'Phosphofructokinase6'}="Phosphofructokinase";
$hashothernames{'Phosphofructokinase7'}="Phosphofructokinase";
$hashothernames{'Glucose6phosphateisomerase1'}="Glucose 6 phosphate isomerase";
$hashothernames{'Glucose6phosphateisomerase2'}="Glucose 6 phosphate isomerase";
$hashothernames{'Glucose6phosphateisomerase3'}="Glucose 6 phosphate isomerase";
$hashothernames{'Glucose6phosphateisomerase4'}="Glucose 6 phosphate isomerase";
$hashothernames{'Glucosekinase1'}="Glucose kinase";
$hashothernames{'Glucosekinase2'}="Glucose kinase";
$hashothernames{'Glucosekinase3'}="Glucose kinase";
$hashothernames{'Glucosekinase4'}="Glucose kinase";
$hashothernames{'Glucosekinase5'}="Glucose kinase";
$hashothernames{'Glucosekinase6'}="Glucose kinase";
$hashothernames{'Glucosekinase7'}="Glucose kinase";
$hashothernames{'Pyruvatekinase1'}="Pyruvate kinase";
$hashothernames{'Pyruvatekinase2'}="Pyruvate kinase";
$hashothernames{'Pyruvatekinase3'}="Pyruvate kinase";
$hashothernames{'Pyruvatekinase4'}="Pyruvate kinase";

#-----------------------JAVA SCRIPT------------------
print qq |
<script language="javascript">
function checkAll(formname, checktoggle)
{
  var checkboxes = new Array(); 
  checkboxes = document[formname].getElementsByTagName('input');
 
  for (var i=0; i<checkboxes.length; i++)  {
    if (checkboxes[i].type == 'checkbox')   {
      checkboxes[i].checked = checktoggle;
    }
  }
}
</script>

|;
#------------END JAVA SCRIPT-------------------------
print qq |

<div class="encabezado">
</div>
<div class="expandedd">Results</div>
|;
#------------ guarda hash----------------------
#print "Content-type: text/html\n\n";
open (VIAS, "/var/www/newevomining/PasosBioSin/GlycolysisnewHEADER.fasta");
while (<VIAS>){
chomp;
  if($_ =~ />/){
     @nomb =split (/\|/, $_);
     $hashnombreVIA{$nomb[1]}=$nomb[2];

  }
}

#----------------prepara blast Vs NP---------------------------
system "ls /var/www/newevomining/FASTASparaNP > /var/www/newevomining/ls.FASTANP";

#print "<h1>Blast  Central Met./NP VS Genome DB...</h1>";
open (BNP, "/var/www/newevomining/ls.FASTANP") or die $!;
while (<BNP>){
chomp;

system "/opt/ncbi-blast-2.2.28+/bin/blastp -db /var/www/newevomining/NPDB/Natural_products_DB.db -query /var/www/newevomining/FASTASparaNP/$_ -outfmt 6 -num_threads 4 -evalue $eval -out /var/www/newevomining/blast/$_\_ExpandedVsNp.blast";

#blast vs NP


}
close BNP;
#print "<h1>Done...</h1>"; ]

#----------------------------- filtra por score------------------------
system "ls /var/www/newevomining/blast/*_ExpandedVsNp.blast > /var/www/newevomining/ls.ExpandedVsNp.blast";

open (EXPPP, "/var/www/newevomining/ls.ExpandedVsNp.blast") or die $!;
while(<EXPPP>){
chomp;
  open(CUUOUT, ">$_.2");
  open(CUU, "$_");
  while($linea=<CUU>){
  chomp($linea);
   @arreg=split("\t",$linea);
    if ($arreg[11] >= $score2){
      print CUUOUT "$linea\n";
    
    }
  
  }
  close CUU;
  close CUUOUT;
}
close EXPPP;
#----------------------end filtra por score--------------------------

system "ls /var/www/newevomining/blast/*_ExpandedVsNp.blast.2 > /var/www/newevomining/ls.ExpandedVsNp.blast2";
open (EXP, "/var/www/newevomining/ls.ExpandedVsNp.blast2") or die $!;
while(<EXP>){
chomp;
#print "<h1>cat $_ |cut -f2 |sort -u >$_.recruitedUniq</h1>";
   system "cat $_ |cut -f2 |sort -u >$_.recruitedUniq";
}
close EXP;
system "ls /var/www/newevomining/blast/*.recruitedUniq > /var/www/newevomining/ls.recruitedUniq ";

open (REC, "/var/www/newevomining/ls.recruitedUniq") or die $!;
open (RECPR, ">/var/www/newevomining/hash.log") or die $!;

while(<REC>){
chomp;
 open(OU,"$_");
 $sin=$_;
 $sin =~ s/\/var\/www\/newevomining\/blast\///g;
 $sin =~ s/\.fasta_ExpandedVsNp\.blast\.2\.recruitedUniq//g;
   while($line=<OU>){
   chomp($line);
      #print RECPR "$line\n";
      $hashUniq{$line}=$line;
      $cad=$cad.",".$line;
       #print RECPR "$cad\n";      
   }
   $cad =~ s/^\,+//;     
   $reg=$hashnombreVIA{$sin}."---".$cad;
   $hashNUM{$hashnombreVIA{$sin}}=$sin;
   if($cad){
    print RECPR "$sin===$reg\n";
   
    push(@mostrar, $reg);
   }
   
   $cad='';
 close OU;
 

 $sizeFIle= -s $_;
 if($sizeFIle > 0){
  open(OUTFASTA,">$_.fasta") or die $!;
  $nam=$_;
  $nam =~ s/\.fasta_ExpandedVsNp\.blast\.2\.recruitedUniq//;
  #system "touch $nam.nanana";
  push(@nom, $nam);
 }
 else {
  next;
 }
 open(NPDB, "/var/www/newevomining/NPDB/Natural_products_DB.prot_fasta")or die $!;
 $si=0;  
 while($line2=<NPDB>){
  chomp($line2);
    if ($line2 =~ />/){
     #$header=$line2;
     $line2 =~ s/>//;
     
       if(exists $hashUniq{$line2}){
           print OUTFASTA ">$line2\n";
	   $si=1;        
       }
       else{
         $si=0;
       }
    }
    else{
       if($si ==1){
         print OUTFASTA "$line2\n";
       }
  
    }#

  }#end while NPDF
close NPDB;
close OUTFASTA;
%hashUniq ='';
}
close REC;

foreach my $x (@nom){
#system "touch $x.nananaaaaaa";
$tempor= $x;
$tempor =~ s/\/var\/www\/newevomining\/blast\///;
#system "cat /var/www/newevomining/FASTASparaNP/$tempor.fasta $x.fasta_ExpandedVsNp.blast.2.recruitedUniq.fasta> $x.concat.fasta";
system "cat /var/www/newevomining/FASTASparaNP/$tempor.fasta $x.fasta_ExpandedVsNp.blast.2.recruitedUniq.fasta> $x.preconcat.fasta";
open (CONCAT, "$x.preconcat.fasta");
open (CONCATOUT, ">$x.concat.fasta");
 
  while (<CONCAT>){
   chomp;
   #$_ =~ s/\(|\)//g;
   #$_ =~ s/\(//g;
     if($_ =~ />/){
    # $_ =~ s/\-|\.//g;
       if($_ !~ /\|/){
         print CONCATOUT "$_|****\n";
       }
       else{
          @datines=split(/\|/, $_);
          print CONCATOUT ">$datines[1]|$datines[5]***\n";
       }
     }
     else{
       print CONCATOUT "$_\n";
    
    }
 }
}#end foreach
close CONCAT;
close CONCATOUT;

#print "<h1>Done...ultimo</h1>"; 
#print "Content-type: text/html\n\n";
print qq| <form method="post" action="/cgi-bin/newevomining/alignGcontext.pl" name="forma"> |;
print qq| <table class="segtabla" BORDER="1" CELLSPACING="1" ALIGN="center"  WIDTH="60">|;
print qq |<td></td>|;
print qq |<div class="subtitulo"><td>Central</td></div>|;
print qq |<div class="subtitulo"><td>Natural Products</td></div>|;
foreach my $x (@mostrar){
@array =split("---",$x);
$array[1] =~ s/_\d+//g;
print qq |<tr>|;
$clave="clave_$hashNUM{$array[0]}";
#print qq| <input type="hidden" name="$clave" value="$clave">|;
print qq |<td><input type="checkbox" name="$clave" value="$clave" checked> </td>|;
print qq |<div class="campo2"><td>$hashothernames{$array[0]}</td></div>|;
#print qq |<div class="campo2"><td>$hashNUM{$array[0]}</td></div>|;

print qq |<div class="campo2"><td>$array[1]</td></div>|;
print qq |</tr>|;
}
print qq |</table>|;
print qq| <table BORDER="0" CELLSPACING="0" ALIGN="center"  WIDTH="15">|;
print qq |
<td><div class="campo2"><a href="javascript:void();" onclick="javascript:checkAll('forma', true);">check all</a></div></td>
<td><div class="campo2"><a href="javascript:void();" onclick="javascript:checkAll('forma', false);">uncheck all</a></div></td>

|;
print qq |<td><div class="boton"><button  value="Submit" name="Submit">SUBMIT</button></div></td>|;
print qq |</table>|;
#print "<h1>Done...</h1>";
#system "muscle -in FASTAINTER/$nomb -out ALIGNMENTSfasta/$_.muslce.pir -fasta -quiet -group";
print qq| </form> |;
exit(1);

######################################################
# funciones para upload
#######################################################
sub recepcion_de_archivo{

my $evalue = $Input{'evalue'};
my $score1 = $Input{'score'};
#my $nombre_en_servidor = $Input{'archivo'};

$evalue =~ s/ /_/gi;
$evalue =~ s!^.*(\\|\/)!!;
$score1=~ s/ /_/gi;
$score1 =~ s!^.*(\\|\/)!!;

my $extension_correcta = 1;

return $evalue,$score1;

} #sub recepcion_de_archivo
