
use Cwd;
#####Reference genome and query
$SPECIAL_ORG="1251"; ## Reference organism having a known BGC, will be used as reference for BGC homology
$QUERIES="1251_SPINOSAD.query"; 
#####homology search parameters
$e="0.0000000000000000001"; 		#sss1E-15					# E value. Minimal for a gene to be considered a hit.
$BITSCORE="2000"; ## Revisar el archivo .BLAST.pre para tener idea de este parámetro.
$ClusterRadio="25"; #number of genes in the neighborhood to be analized
$eCluster="0.001"; 		#Evalue for the search of queries (from reference organism) homologies, values above this will be colored
$eCore="0.001"; 		#Evalue for the search of ortholog groups within the collection of BGCs	

#####db management
$RAST_IDs="RAST.IDs";
$BLAST_CALL="";
$DOWNLOAD="0";			#1 If you need to download The files needed for the script from RAST 0 if you already have downloaded your genomes database
$USER="nselem35";		#If you are going to download files
$PASS="q8Vf6ib";		#password for RAST account
$FORMAT_DB="1"; 		#here you put 0 if  the genomes DB is already formatted and 1 if you want to reformat the whole DB


#####working directory.. for most cases do not touch
#####working directory.. for most cases do not touch
#$NAME="ClusterTools4";
$currWorkDir = &Cwd::cwd();
$dir=$currWorkDir;		##The path of your directory
$NAME= pop @{[split m|/|, $currWorkDir]};					##Name of the group (Taxa, gender etc)
$BLAST="$NAME.blast";

#####for second round of analysis with selected genomes
$LIST = "534,489,806,387,1251,683,637,785,507,512,530,478"; 	
			##Wich genomes would you process in case you might, otherwise left empty for whole DB search    
#$LIST= "1251,387,354";
$NUM = `wc -l < $RAST_IDs`;
chomp $NUM;
$NUM=int($NUM);
#the number of genomes to be analized in case you used the option $LIST, comment if $LIST is empty
#$NUM="3";


#Window size
$RESCALE=105000;              ## Adjust horizontal size on arrows (genes) if greater then arrows are smaller and you will see more genes.

