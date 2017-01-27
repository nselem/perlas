# aqui puedes poner las instrucciones que te envie  
cambio de linea igual a doble espacio enter   
titulo = #  
codigo = `hola`    
#Instrucciones Pseudocore
1 Para obtener los BBH de todos los faa a partir del core 558PAraCORE
Hace blast y crea el fasta
en GENOMES deben estar 558PAraCORE y los faa y el script BBH.pl
 
cd GENOMES
ls *faa | while read line; do perl BBH.pl 558ParaCORE $line; done


2 Para obtener cuales estan en todos (El pseudoCore)
590 es fijo, 38 se cambia por el numero total de faa
`for i in {1..590} ; do num=$(grep ">${i}_" *Central | wc -l| cut -f1 -d' '); if [ "38"  =  "$num"  ]; then echo "$i $num"; fi;done >PseudCore`

Para poner en fasta el Pseudocore
`perl -p -i -e 's/^\n//' *Central`  
`perl -p -i -e 's/\n/\t/ if />/' *Central`  
cut -f1 -d' ' PseudCore | while read line; do gen=$(grep ">$line"_ *Central | cut -d'>' -f2); echo ">$gen"> $line; done
mkdir GENES
mv *[0-9] GENES
cd GENES
perl -p -i -e 's/^/>/' [0-9]*
perl -p -i -e 's/\t/\n/' [0-9]*

Para Alinear
perl -p -i -e 's/>>/>/' [0-9]*
perl -p -i -e 's/>>/>/' [0-9]*
ls [0-9]* | while read gen; do echo $gen; muscle -in $gen -out $gen.muscle.pir -fasta -quiet -group; done

PAra ordenar y Rasurar
SortAlign.pl debe estar en la carpeta GENE
ls *pir | while read line; do perl SortAlign.pl $line; done

Concatenador debe estar en GENE
perl Concatenador.pl
aqui escoger un archivo de nombres
Rast ids esta afuera de GENOMAS a la misma altura
cut -f2 ../../Clavi_Ene_2016.Ids | while read line; do name=$( grep $line ../../Clavi_Ene_2016.Ids| cut -f3); perl -p -i -e 's/'"$line"'/'"$name"'/' SalidaConcatenada.txt ; done
perl -p -i -e 's/ /_/g if />/' Sa*	

De aui ya sigue guardar en nexus y correr en MrBayes
