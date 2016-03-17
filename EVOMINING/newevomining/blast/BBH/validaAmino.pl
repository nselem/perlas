#$file = $ARGV[0];
$cad="MNHQSGLWLTYERQLARTIKPPSAKVEPVTVNEDSFTNWKNREEIAESMIPVIGKLHRERDVTILLHSRSLVNKSVVSILKTHRFARQIAGEELSVTETLPFLKTLAALDLGPSQIDLGMLAATYRADDRGLTVEEFTAEAVAGATGANKIERREGRDVVLYGFGRIGRLLARLLIEKAGSGNGLRLRAIVVRKGAGQDLVKRASLLRRDSIHGQFHGTITVDEENSTIVANGNEIKVIYSDDPTAVDYTAYGIRDAILIDNTGRWRDREGLSKHLRPGIAKVVLTAPGKGDVPNIVHGVNHDTIKPDEQILSCASCTTNAIVPPLKAMADEFGVLGGHVETVHSYTNDQNLLDNYHKSDRRGRSAALNMVITETGAASAVAKALPDLKAKITGSSIRVPVPDVSIAILSLRLGRETTREEVLDHLREVSLTSPLKRQIDFITAPDAVSNDFVGSRHASIVDAGATKVEGDNAILYLWYDNEFGYSCQVVRVVQHVSGVEYPTFPAPVA";
#open (FI, "$file");
#while (<FI>){
#  chomp;
#  if ($_ !~ />/){
    
    
    @a= split (//, $cad);
    foreach my $x (@a){
   # print "$x siii\n";
   # <STDIN>;
      if ($x ne '-' and $x ne 'S' and $x ne 'T' and $x ne 'N' and $x ne 'Q' and $x ne 'K' and $x ne 'R' and $x ne 'H' and $x ne 'E' and $x ne 'D' and $x ne 'C' and $x ne 'G' and $x ne 'P' and $x ne 'A' and $x ne 'I' and $x ne 'L' and $x ne 'M' and $x ne 'F' and $x ne 'W' and $x ne 'V' and $x ne 'Y' ){ 
         print "Caracter diferente *$x* en linea !!!\n";
        # <STDIN>;
  
      }
    }
  #}  

#}
