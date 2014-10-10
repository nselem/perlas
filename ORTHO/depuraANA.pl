use Getopt::Long;
#####################################
#REQUERIMIENTOS:
#-LISTA DE GENOMAS
#-BLAST UNO vs OTRO escalonado e.g. 1vs2  2vs3  3vs 4 .../
#- FAA DE CADA GENOMA -> FAA/
#AUTOR: Christian Eduardo Martinez G.
# cmartinez@langebio.cinvestav.mx
#####################################
#!/usr/bin/perl

$dir="/home/fbg/lab/ana/RASTtk";
$infile="NUEVOCORE";  ##Creará una carpeta asi
$outdir="/home/fbg/lab/ana/RASTtk/$infile";
$lista="lista.nuevocore";
$listaname="nuevocore.lista";
$DesiredGenes="Nuevocore.lista";

#sub Options;
#Options(\$verbose,\$inputlist,\$output);
#sub Options{
#        GetOptions ("In=s" => \$inputblast,"Out=s" => \$output,"Req=s" => \$Req,"verbose=s" => \$verbose) or die("Error in command line arguments\n");
#
 #       if(!$inputblast) {
  #              die("Please provide an all vs all file");
  #              }
   #     if (!$output){
   #             $output="Out_".$Req.".Ortho";
   #             }
   #     if(!$Req){
   #             die ("You must specify from which organisms you desire an ortho-group");
   #             }
   #     else{
   #             my @Required=split(",",$Req);
   #             if ($verbose){
   #                     print("You want ortho groups of the following genomes\n");
   #                     for my $req(@Required){
   #                             print "$req \t";
    #                            }
    #                            print("\n");
    #                    }
     #           return @Required;
      #          }
       # }



$start=2;
$end=13;
#-----------------------------------------
#system "ls FAA/*.faa >lista";
open (LS, "$lista") or die $!;

while (<LS>){
 chomp;
  push(@lista0, $_); 
 
}
close LS;
print "Seleccionando unicos...\n";
if (-e $outdir){system "rm -r $outdir";}
system "mkdir $outdir";
system "rm -r $outdir/FASTAINTER/";
system "mkdir $outdir/FASTAINTER/";
#print "$dir/FASTA";
system "rm -r $outdir/FASTAINTERporORG/";
system "mkdir $outdir/FASTAINTERporORG/";
system "rm lista.ORTHOall";
generaFasta();#INPUT los .bbh OUTPUT=interseccion de todos en  inter.todos
print "Done!\n";


####################################
##GENERA FASTA de las intersecciones
####################################


sub generaFasta{

	open (FAA, "$dir/$listaname") or die $!;
	print"Lista 30 abierta";## Lista con todos los nombres de faa en el directorio
	while($linea=<FAA>){
		chomp($linea);
		######### Get file number
		$fnumber=$linea;
		$fnumber=~s/\.faa//;
		#print($fnumber,"\n");
		####### llena hash con encabezado-secuencia#####
		open (CU, "$dir/$linea") or die $linea;
  		while(<CU>){

    			 if($_ =~ />/){
       				chomp;
       				$headerFasta=$_."|$fnumber";
				$org="";
				#print "$headerFasta\n";
     			}
     			else{
       				$_ =~ s/\*//g;
       				$hashFastaH{$headerFasta}= $hashFastaH{$headerFasta}.$_;
				#print"$headerFasta => $hashFastaH{$headerFasta}\n";
  
     			}
		 }#end while CU
	}#end while FAA ############# Termina de llenar has con encabezado-secuencia
	################################################
	close CU;
	
	#foreach $seq(keys %hashFastaH){
	#print($seq,"=>",$hashFastaH{$seq});}
	print "\n$dir/$DesiredGenes\n"; 
	open (ALL, "$dir/$DesiredGenes") or die $!;
	print "\nReading: $dir/$DesiredGenes\n";

	$cuenta=0;
 	while(<ALL>){
  		chomp; 
  @divAll=split("\t",$_);
  $cuenta++;## Laslineas de interANA.todos

  open (FASTAINTER, ">$outdir/FASTAINTER/$cuenta.interFastatodos") or die $!;
  print "Writing: $outdir/FASTAINTER/$cuenta.interFastatodo\n";

  open (LISTA, ">>$outdir/lista.ORTHOall") or die $!;
	print LISTA "$cuenta.interFastatodos \n";

    foreach my $i (@divAll){
	$name=$i;
	#$name=~s/\|\d*$//g; #Quito el indicador de organismo
	print "\n$name##$i\n";
        $concat=">$name";
	##print("Busco en hashFastaH",$concat,"\n");
	#print"##$concat##";
     if(exists $hashFastaH{$concat}){
	##print("Encontrado!");
       print FASTAINTER ">$i\n$hashFastaH{$concat}";
     }
     else{
       
       print "NOT FOUND!!!\n>*$i\n**$concat\n***$hashFastaH{$concat}\n";
       <STDIN>;
       
     }
    }#end while foreach
    close FASTAINTER;
     #---------acumula datos de fasta por org------------------
  #$subindice=1;
  foreach my $x (@divAll){
	  $numero=$x;
	  $numero=~s/fig\|*.*.peg.*\|//g; #Obtengo el indicador de organismo
    	  $porPRG[$numero]=$porPRG[$numero]."\t".$x;
	  #print"PORorganismo:\n$numero=> $porPRG[$numero]\n";
  } 
    
    #-------------end fasta por org---------
 }#end while ALL
$c=-1;
#------------------crea fasta por og------------
  foreach my $y (@porPRG){
     $c++;
     #print("\n##Organismo $c\n");	
     #print  "#$y#\n";
     $y =~ s/^\t//;
     @divporOrg = split("\t", $y);
     #print($divporOrg[0]);
    open (FASTAINTERORG, ">$outdir/FASTAINTERporORG/$c.interFastatodos") or die $!; 
    foreach my $i (@divporOrg){
      $concat2=">$i";
     if(exists $hashFastaH{$concat2}){
       print FASTAINTERORG ">$i\n$hashFastaH{$concat2}";
     }
     else{
       
       print "NOT FOUND! por ORG!!\n>$i\n$hashFastaH{$concat2}\n";
       <STDIN>;
       
     }
    }#end while froeach
    close FASTAINTERORG;
     
  }

  system "rm $outdir/FASTAINTERporORG/0.interFastatodos";
close ALL;
}#end sub


