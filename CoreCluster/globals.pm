#####Reference genome and query
$SPECIAL_ORG="1235"; ## Reference organism having a known BGC, will be used as reference for BGC homology
$QUERIES="enedyene.query"; 
#####homology search parameters
$e="0.0000000000000000000000001"; 		#sss1E-15					# E value. Minimal for a gene to be considered a hit.
$BITSCORE="2000"; ## Revisar el archivo .BLAST.pre para tener idea de este parámetro.
$ClusterRadio="15"; #number of genes in the neighborhood to be analized
$eCluster="0.00001"; 		#Evalue for the search of queries (from reference organism) homologies, values above this will be colored
$eCore="0.00001"; 		#Evalue for the search of ortholog groups within the collection of BGCs	

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
#$dir="/Users/FBG/Desktop/ClusterTools1/$NAME";		##The path of your directory
$dir="/Users/FBG/Desktop/$NAME";		##The path of your directory

#####for second round of analysis with selected genomes
$LIST = ""; 					##Wich genomes would you process in case you might, otherwise left empty for whole DB search    
#$LIST = "1235,310,318"; 					##Wich genomes would you process in case you might, otherwise left empty for whole DB search    
#$LIST= "68,69,70,983,1013,984,985,312,328,408,411,413,414,415,484,485,491,495,516,520,529,542,546,586,780,924,928,946,986,987,988,1005,1007,1016,1243,1244,1245,1246";

$NUM = `wc -l < $RAST_IDs`;
chomp $NUM;
$NUM=int($NUM);
#the number of genomes to be analized in case you used the option $LIST, comment if $LIST is empty
#$NUM="";
#$NUM="38";

#Window size
$RESCALE=85000;              ## Adjust horizontal size on arrows (genes) if greater then arrows are smaller and you will see more genes.
