#!/usr/bin/perl
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI;
my %Input;
my $cad;
my $query = new CGI;
print $query->header,
      $query->start_html(-style => {-src => '/newevomining/css/tabla.css'} );
my @pairs = $query->param;
my $apacheHTMLpath="/html/evoMining";
foreach my $pair(@pairs){
 	$Input{$pair} = $query->param($pair);
         #$cad="$cad./$pair/|$Input{$pair}|";
	}	

my @div=split (/\|/,$Input{'message'});
my $path=$div[1];
$path=~ s/\r|\s//g;
chomp($path);
open (ERROR, ">error3") or die $!;
print ERROR "|$path|";
#my $gen1=23;
#my $gen2=45;
my $out= `perl RAST/1.WriteInputsFromList.pl $div[0] $div[1]`;
my $out2= `perl RAST/2.Draw.pl $div[1]`;

# Llamar el generador de texto de contexto
# Llamar al dibujador y el dibujador cambiara el cuadrito azul por el contexto

print qq |
<html>
 <head>
  <title>Contextos evoMining</title>
 </head>
 $out
 <body>
  <form action='/cgi-bin/newevomining/tree2_2TOTALexec.pl?1&&9178_WedMar182015' method='post' target=''>Array $div[0] - $div[1]
  <center><p>Contextos evomining</p>
 
  <input type='submit' name='Back' value='back!'></form>
  <img src='$apacheHTMLpath/$path/Contextos.svg' onerror='this.src='/newevomining/test.png''> 
  </body>
</html>
|;


## Pendiente borrar todas las noches }.input }svg
