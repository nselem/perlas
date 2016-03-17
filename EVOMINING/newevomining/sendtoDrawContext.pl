#!/usr/bin/perl
############ Este es el formuario 
use CGI::Carp qw(fatalsToBrowser);
use CGI;
my %Input;
my $cad;
my $query = new CGI;
print $query->header,
      $query->start_html(-style => {-src => '/newevomining/css/tabla.css'} );
my @pairs = $query->param;

foreach my $pair(@pairs){
 	$Input{$pair} = $query->param($pair);
         $cad="$cad./$pair/|$Input{$pair}|";
        
	}	
$Input{'keywords'}=~ s/ /_/g;


my @datas=split(/\|/,$Input{'keywords'});
my @folder=split(/\//,$datas[2]);
my $datos=$datas[0]."|".$folder[$#folder];
$conc=$conc.' '.$datos;
print qq |
<html>
 <head>
  <title>Conteeeeextos evoMining</title>
 </head>
 
 <body>
  <form action='/cgi-bin/newevomining/drawContext.pl?$datos' method='post' target=''>
  <center><p>Select genomic context $ENV{'QUERY_STRING'}:<br>Enter the genes that you wish to see separated by spaces.</p> 
  <textarea name='message' rows='2' cols='70'>$conc
    </textarea>
  <input type='submit' name='Back' value='Go!'>
  </form>
  </body>
</html>
|;

