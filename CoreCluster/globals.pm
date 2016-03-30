#####Reference genome and query
$SPECIAL_ORG="2"; ## Reference organism having a known BGC, will be used as reference for BGC homology
$QUERIES="realAroA.query";

#####homology search parameters
$e="0.00000001"; 		#sss1E-15					# E value. Minimal for a gene to be considered a hit.
$bitscore="300"; ## Revisar el archivo .BLAST.pre para tener idea de este parámetro.
$ClusterRadio="30"; #number of genes in the neighborhood to be analized
$eCluster="0.1"; 		#Evalue for the search of queries (from reference organism) homologies, values above this will be colored
$eCore=$eCluster; 		#Evalue for the search of ortholog groups within the collection of BGCs	

#####db management
$RAST_IDs="RAST.IDs";
$BLAST_CALL="";
$DOWNLOAD="0";			#1 If you need to download The files needed for the script from RAST 0 if you already have downloaded your genomes database
$USER="nselem35";		#If you are going to download files
$PASS="q8Vf6ib";		#password for RAST account
$FORMAT_DB="0"; 		#here you put 0 if  the genomes DB is already formatted and 1 if you want to reformat the whole DB


#####working directory.. for most cases do not touch
$NAME="ClusterTools1";					##Name of the group (Taxa, gender etc)
$BLAST="$NAME.blast";
$dir="/Users/FBG/Desktop/ClusterTools3/ClusterTools3/$NAME";		##The path of your directory
#$dir="/Users/FBG/Desktop/$NAME";		##The path of your directory

#####for second round of analysis with selected genomes
#$LIST = ""; 					##Wich genomes would you process in case you might, otherwise left empty for whole DB search
$LIST= "1,2,4,5,16";
$NUM = `wc -l < $RAST_IDs`;
chomp $NUM;
$NUM=int($NUM);
#the number of genomes to be analized in case you used the option $LIST, comment if $LIST is empty
#$NUM="70";
$NUM="13";

#Window size
$RESCALE=100000;              ## Adjust horizontal size on arrows (genes) if greater then arrows are smaller and you will see more genes.
