open(LIST, "listaBorrar");
 while(<LIST>){
  chomp;
  system "rm $_";
 } 
 close LIST
