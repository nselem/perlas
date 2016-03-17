#!/usr/bin/perl
use CGI::Carp qw(fatalsToBrowser);
use CGI;

my %Input;
my $query = new CGI;


print $query->header,
      $query->start_html(-style => {-src => '/newevomining/css/tabla2.css'} );

 print qq |
<div class="encabezado">
</div>
<div class="expandedd">TREE</div>
|;
$numFile=$ENV{'QUERY_STRING'};
open(OP, "/var/www/newevomining/blast/seqf/tree/$numFile.p.svg");
 while(<OP>){
  $string=$string.$_;
 }

 print qq|
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
</head>

<body>
<form id="form1" name="form1" method="post" action="">
  <table width="1275" height="471" border="1">
    <tr>
      <td height="41" align="center"><table width="831" border="1">
        <tr>
          <td width="145"><label>
            <input name="round" type="checkbox" id="round" accesskey="1" checked="checked" />
            Round Tree</label></td>
          <td width="154"><label>
            <input name="labels" type="checkbox" id="labels" accesskey="1" />
            Erease Labels</label></td>
          <td width="168"><label>
            <input name="central" type="checkbox" id="central" checked="checked" />
            Central Met.</label></td>
          <td width="166"><label>
            <input name="Hits" type="checkbox" id="Hits" checked="checked" />
            Hits</label></td>
          <td width="164">Aply changes
            <input type="submit" name="aply" id="aply" value="Submit" /></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td height="288"><table width="1265" height="192" border="1" align="left" cellpadding="0" cellspacing="0">
        <tr>
          <td width="1002" height="356" valign="top" scrolling="auto"><iframe src="http://www.google.com/"
width="1000" height="400" scrolling="auto">
Texto alternativo para navegadores que no aceptan iframes
</iframe>&nbsp;</td>
          <td width="257" valign="top"><table width="255" border="1">
            <tr>
              <td width="16"><label>
                <input type="checkbox" name="genome1" id="genome1" />
              </label></td>
              <td width="161">Genome 1</td>
              <td width="56">&nbsp;</td>
            </tr>
          </table></td>
        </tr>
      </table></td>
    </tr>
  </table>
  <p>&nbsp;</p>
</form>
</body>
</html>
|;
 


