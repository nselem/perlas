#!/usr/bin/perl
use CGI::Carp qw(fatalsToBrowser);
use CGI;

my %Input;
my $query = new CGI;


print $query->header,
      $query->start_html(-style => {-src => '/newevomining/css/tabla3.css'} );

 print qq |
<div class="encabezado">
</div>
<div class="expandedd"></div>
|;
$prenumFile=$ENV{'QUERY_STRING'};
@arraynumFile=split(/&&/,$prenumFile);
$numFile=$arraynumFile[0];
$outdir=$arraynumFile[1];

open(OP, "/var/www/newevomining/$outdir/blast/seqf/tree/$numFile.p.svg");
 while(<OP>){
  $string=$string.$_;
 }

 print qq|
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Documento sin título</title>
</head>
<body>
<form id="form1" name="form1" method="post"
action="http://10.10.100.24/cgi-bin/newevomining/tree2_2.pl?$numFile&&$outdir"
target="iframeA">
<table border="1" height="671" width="1275">
<tbody>
<tr>
<td align="center" height="41">
<table style="width: 831px; height: 72px;" border="1">
<tbody>
<tr>
<td width="145"><label> <input name="round" id="round"
accesskey="1" checked="checked" type="checkbox"> Round Tree</label></td>
<td style="width: 218px;"><label> Central Met. <br><input name="GenomeName"
id="GenomeName" type="checkbox"> Genome Name</label><label>
 ___ <input name="GI" id="GI" checked="checked"
type="checkbox"> GI number</label></td>
<td width="164">Apply changes <input name="aply" id="aply"
value="Submit" type="submit"></td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr>
<td height="288">
<table align="left" border="1" cellpadding="0" cellspacing="0"
height="192" width="1265">
<tbody>
<tr>
<td scrolling="auto" height="356" valign="top"
width="1002"><iframe name="iframeA"
src="http://10.10.100.24/cgi-bin/newevomining/tree2_2.pl?$numFile&&$outdir"
height="600" scrolling="auto" width="1000">Texto alternativo para
navegadores que no aceptan iframes
</iframe>&nbsp;</td>
<td valign="top" width="257">
<table border="1" width="255">
<tbody>
<tr>
<td width="16"><label> <input name="genome1"
id="genome1" type="checkbox"> </label></td>
<td width="161">Genome 1</td>
<td width="56">&nbsp;</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<p>&nbsp;</p>
</form>
</body>
</html>
|;
 


