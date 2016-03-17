open(LIST, "listaParaFiltrar");
while(<LIST>){
chomp;
 $hashF{$_}=$_;

}
close LIST;

open(FASTA, "losCasi200HEADER.fasta");
while(<FASTA>){
chomp;
   if($_ =~ />/){
     @a=split(/\|/,$_);
     $flagError=0;
       #if(exists $hashF{$a[$#a]}){ 
       if($#a > 5){ 
       #if($_ =~ /\|$/){
          $flagError=1;
	  #print "ERROR,$_\n";
	  #<STDIN>;
	  next;
       }
       else{
          print "$_\n";
       }
    }
    else{
      if($flagError==1){
          #print "$_\n";
	  #<STDIN>;
	  next;
      }
      else{
         print "$_\n";
      }
    }    
   

}
