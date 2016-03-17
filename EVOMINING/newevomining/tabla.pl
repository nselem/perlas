use CGI::Carp qw(fatalsToBrowser);
use CGI;

my %Input;
my $query = new CGI;


#print $query->header,
      #$query->start_html(-style => {-src => '/newevomining/css/tabla2.css'} );
#my @pairs = $query->param;
#foreach my $pair(@pairs){
# #if($pair =~ /clave_\d+/){ 
#    $Input{$pair} = $query->param($pair);
# #}
#}
#@dat= recepcion_de_archivo();
print "Content-type:text/html\r\n\r\n";
print qq |
#<div class="encabezado">
#</div>
#<div class="expandedd">Aligning...</div>
|;



print qq| <table class="segtabla" BORDER="1" CELLSPACING="1" ALIGN="center"  WIDTH="60">|;
print qq |<div class="subtitulo"><td>Central</td></div>|;
print qq |<div class="subtitulo"><td>Natural Products</td></div>|;
 open(FF, "/var/www/newevomining/hash.log");
 while ($xef = <FF>){
     chomp($xef);
     @array =split("---",$xef);
     @array2 =split("===",$array[0]);
     #$array[1] =~ s/_\d+//g;
     $onlyD="/var/www/newevomining/blast/seqf/tree/distance.".$array2[0].".only";
     open(XT, "$onlyD") or ie $!;
     while($line=<XT>){
      chomp($line);
      $acum="$acum - $line";
     }
     close XT;
      print qq |<tr>|;
      #$clave="clave_$hashNUM{$array[0]}";
      #print qq| <input type="hidden" name="$clave" value="$clave">|;
      print qq |<div class="campo2"><td>$array2[1]</td></div>|;
      #pridnt qq |<div class="campo2"><td>$hashNUM{$array[0]}</td></div>|;
      print qq |<div class="campo2"><td>$array[1]</td></div>|;
      print qq |<div class="campo2"><td>$acum</td></div>|;
      print qq |<div class="campo2"><td>check tree</td></div>|;
      print qq |</tr>|;
 }
 close FF;
print qq |</table>|;
#print qq| <table BORDER="0" CELLSPACING="0" ALIGN="center"  WIDTH="15">|;
#print qq |

#print qq |</table>|;
#print "<h1>Done...</h1>";
#system "muscle -in FASTAINTER/$nomb -out ALIGNMENTSfasta/$_.muslce.pir -fasta -quiet -group";


#exit(1);
