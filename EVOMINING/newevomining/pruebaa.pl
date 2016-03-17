open(HASHBLAST, "/var/www/newevomining/blast/pscp.blast");
while (<HASHBLAST>){
  chomp; 
  @resblast=split(/\t/,$_);
  @datosMEtCent=split(/\|/,$resblast[1]);
  print "$datosMEtCent[1]|$datosMEtCent[5]\n";
  <STDIN>;
}

close HASHBLAST;
