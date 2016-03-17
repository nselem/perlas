#!/usr/bin/perl -w
#####################################################
# CODIGO PARA hacer Blast Vs NP
#
#####################################################

##use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI;
############################## def-DBM #################################
use Fcntl ; use DB_File ; $tipoDB = "DB_File" ; $RWC = O_CREAT|O_RDWR
;
############################## def-SUB  ################################
my $tfm = "mi_hashNombrePorNum.db" ;
my %Input;
my $query = new CGI;


$hand = tie my %NombresPorNum, $tipoDB , "$tfm" , $RWC , 0644 ;
print "$! \nerror tie para $tfm \n" if ($hand eq "");
my $tfm2 = "mi_hashNUMVia.db" ;
$hand2 = tie my %hashNUMVia, $tipoDB , "$tfm2" , 0 , 0644 ;
print "$! \nerror tie para $tfm2 \n" if ($hand2 eq "");

 
print $query->header,
      $query->start_html(-style => {-src => '/newevomining/css/tabla2.css'} );
my @pairs = $query->param;
foreach my $pair(@pairs){
$Input{$pair} = $query->param($pair);
}
($eval,$score2)=recepcion_de_archivo(); #Iniciar la recepcion del archivo

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


#print "<h1>Done...ultimo</h1>"; 
#print "Content-type: text/html\n\n";
print qq| <form method="post" action="/cgi-bin/newevomining/alignGcontext.pl" name="forma"> |;
print qq| <table class="segtabla" BORDER="1" CELLSPACING="1" ALIGN="center"  WIDTH="60%">|;
print qq |<td></td>|;
print qq |<div class="subtitulo"><td>Central</td></div>|;
print qq |<div class="subtitulo"><td>Natural Products</td></div>|;
foreach my $x (@mostrar){
@PREarray =split("===",$x);
@array =split("---",$PREarray[1]);
$array[1] =~ s/_\d+//g;
print qq |<tr>|;
$clave="clave_$hashNUM{$array[0]}";
#print qq| <input type="hidden" name="$clave" value="$clave">|;
print qq |<td><input type="checkbox" name="$clave" value="$clave" checked> </td>|;
print qq |<div class="campo2"><td>$hashNUMVia{$PREarray[0]}-$PREarray[0]</td></div>|;
#print qq |<div class="campo2"><td>$clave</td></div>|;

print qq |<div class="campo2"><td width="40%">***$array[1]</td></div>|;
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
untie %NombresPorNum;
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
