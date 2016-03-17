

system "ls *.bindings> listaBindings";
open(LS, "RAST.Ids10");
#open(LS, "listaBindings");
while(<LS>){
chomp;

#los 10
#----------------
@dat=split(/\t/,$_);
$_=$dat[0].".bindings";
#----------------
print "$_\n";
#<STDIN>;
 open(FILE,"$_");
  while($line=<FILE>){
   chomp($line);
   $line =~ s/\r//g;
   $line =~ s/\[|\]|\(|\)//g;
   $line =~ s/ |-|\.|'|&|"|'|,/_/g;
   
   #if($line =~ /\W/){
    # print "$line";
    # <STDIN>;
   #} 
   
   my @div=split(/\t/,$line);
   my $id=$div[2];
    
    $div[2] =~ s/fig\|//g;
    $div[2] =~ s/\.\D+\.\d+//g;
    $div[0]=uc($div[0]);
    $div[1]=uc($div[1]);
    $hashSubsystem{$div[0]}++;
    #print "$div[2]\n";
    #<STDIN>;
    $hashOrg{$div[2]}++;
    
    #if(){}
     if(($div[0] eq $ant) and ($div[1] eq $hash{$div[0]}) and ($div[2] ne $organt))
    {
      $conta++;
      #$ant=$div[0] ;
      $orante=$div[2];
     # print "$conta\n";
    }
    else{
      $conta=1;
    }    
    
    if($div[0] ne $ant)
    {
      $cont=0;
      $ant=$div[0] ;
    }
    #print "/$div[1]/ ne /$hash{$div[1]}/\n";
    if($div[1] ne $hash{$div[0]})
    {
      $cont++;
       print ">$div[0]|$cont$\|$div[1]_$conta|$div[2]\n$id\n";
      
      #$hashCENTRAL{$llave}=$hashCENTRAL{$llave}.">$div[0]|$cont$\|$div[1]|$div[2]\n$id\n"
      $hash{$div[0]}=$div[1];
    
      
      <STDIN>;
    }
    else{
       print ">$div[0]|$cont$\|$div[1]_$conta|$div[2]\n$id\n";
        $hash{$div[0]}=$div[1];      
        <STDIN>;
    }
    
    
   #print ">$div[0]|$cont$\|$div[1]|$div[2]\n$id\n";
   #<STDIN>;
  }#end while interno

}#end while externo


$sizeSubsystem=(keys %hashSubsystem);
#print "subsystems $sizeSubsystem\n";

$sizeOrg=(keys %hashOrg);
#print "Orgs $sizeOrg\n";

#print "org".scalar keys %hashOrg."\n";

#    $hashOrg{$div[2]}++;
#foreach my $x (keys %hashCENTRAL){
#  print "+++$x+++\n\n$hashCENTRAL{$x}\n";
#  <STDIN>;#
#
#}
