 print "Kmer\tAssembly length\tGC content\ttotal N's\tTotal contigs\tCoverage\tUsed Reads\n";
@directory=qx/ls -d \*\/\|sort -n/;
foreach (@directory){
    $assemblyLength=0;
    $GC=0;    $totalNs=0;
    $contigs=0;     $coverage=0;
    $averageCoverage=0;     $accumulatedCoverage=0;
    $A=0;    $C=0;    $T=0;    $G=0;    $N=0;
    $totalNs=0;    $GC=0;    $AssemblySequence="";
    chop $_;
    open FILE, "$_\/contigs.fa" or die "Usage: \$perl contador.pl on the directory were the other sub directores are";

    while ($line=<FILE>){
        if ($line=~/>/){
            $line=~/(\>NODE_\d+_length_\d+_cov_)(\d+)/;
            $coverage="$2";
            $accumulatedCoverage+=$coverage;
            $contigs++;
            $contigLength=0;
            $contigSequence="";
            }
      else {
            $towaste="$line";
            $A+=$towaste=~s/A//gi;
            $C+=$towaste=~s/C//gi;
            $G+=$towaste=~s/G//gi;
            $T+=$towaste=~s/T//gi;
            $N+=$towaste=~s/N//gi;
            chomp $line;
            $AssemblySequence.=$line;
            $contigSequence.=$line;
            $totalNs=+$N;
            $contigLength=length$contigSequence;
            }
    }
            $GC = eval { ($G+$C)/($A+$T+$C+$G)};
            $accumulatedCoverage+=$coverage;
            $averageCoverage=($accumulatedCoverage/$contigs);
            $assemblyLength+=length$AssemblySequence;
    
    
    chop $_;      
    open FILE2, "$_\/Log" or die "Log file not found\n";
    while ($line2=<FILE2>){
        if ($line2=~/Final/){
           $line2=~/(\d+)\/(\d+)/;
           $usedReads=($1/$2)*100;
          
        }
    }
    
    print "$_\t$assemblyLength\t$GC\t$totalNs\t$contigs\t$averageCoverage\t$usedReads\n";

}

