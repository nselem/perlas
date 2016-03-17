open (FILE, "../distance.1.only");
while(<FILE>){
 chomp;
 @array=split("\t", $_);
 
 #$array[0] =~ s/\t/-/;
 $acum= $acum." ".$array[0];
 #print "$acum\n";
 #<STDIN>;


}
print qq |"<circle style=\u2019fill:red;stroke:black\u2019 r=\u20195\u2019/>" I$acum\n|;
