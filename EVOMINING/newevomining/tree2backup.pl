#!/usr/bin/perl
use CGI::Carp qw(fatalsToBrowser);
use CGI;
use Fcntl ; use DB_File ; $tipoDB = "DB_File" ; $RWC = O_CREAT|O_RDWR;
 $tfm = "/var/www/newevomining/blast/BBH/hashMETCENTRAL.db" ;
 $hand = tie  %hashMETCENTRAL, $tipoDB , "$tfm" , 0 , 0644 ;

my %Input;
my $query = new CGI;
my @pairs = $query->param;

foreach my $pair(@pairs){
$Input{$pair} = $query->param($pair);
}

print $query->header,
      $query->start_html(-style => {-src => '/newevomining/css/tabla3.css'} );


#------------hash MEt central extraido del resultado blastp pscp.blast------
#system "/opt/ncbi-blast-2.2.28+/bin/makeblastdb -in /var/www/newevomining/PasosBioSin/GlycolysisnewHEADER.fasta  -dbtype prot  -out /var/www/newevomining/PasosBioSin/GlycolysisnewHEADER.db"; # funciona con archivos .fasta.new
#system "/opt/ncbi-blast-2.2.28+/bin/blastp -db /var/www/newevomining/PasosBioSin/GlycolysisnewHEADER.db -query /var/www/newevomining/DB/ALLv3.out -outfmt 6 -num_threads 4 -evalue 0.0001 -out /var/www/newevomining/blast/bscp.blast";

open(HASHBLAST, "/var/www/newevomining/blast/pscp.blast");
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
$numFile=$ENV{'QUERY_STRING'};
if(exists $Input{round}){
  $round='sr';
}
else{
  $round='s';
}

#open(INPUT, ">/var/www/newevomining/blast/seqf/tree/$numFile.inputWEB");
#foreach my $c (keys %Input){
  #print INPUT "llave: $c  valor:$Input{$c}\n";
 # print "llave: $c  valor:$Input{$c}\n";
#}
#close INPUT;
system "cp tree/ornament.$numFile tree/ornament.$numFile.edit";

chdir "/var/www/newevomining/blast/seqf/";
system "nw_labels -I tree/$numFile.tree > tree/$numFile.labels";
open (LABELS, "tree/$numFile.labels");
open (OUTLABELS, ">tree/$numFile.map");
$cuentaNum=0;
while (<LABELS>){
 chomp;
 $cuentaNum++;
 $nameG=$_;
 $nameG=~ s/\d+\|//;
 @giA=split(/\|/,$_);
 
 
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
 print EDIT qq|"<circle style='fill:green;stroke:black' r='4'/>" I $cc|;
 print EDIT "\n";
}
close EDIT;

#system "nw_rename -l tree/$numFile.tree tree/$numFile.map";
system "nw_rename -l tree/$numFile.tree tree/$numFile.map |nw_display -w 2000 -$round  -S -v 100 -b 'opacity:0' -i 'visibility:hidden' -o tree/ornament.$numFile ->tree/$numFile.p.svg";
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
|;
 
print qq|

 </body>
 </html>|;
  exit; 

