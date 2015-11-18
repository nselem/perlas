use strict;
use warnings;

my $condicion=1;
my $file=$ARGV[0];
#my @files=qw (242393.faa 242333.faa 242539.faa 242113.faa 242560.faa 156512.faa .faa 242476.faa 156514.faa 156496.faa 156499.faa 156510.faa 156521.faa 242183.faa 220635.faa 220651.faa 242050.faa 221031.faa 221059.faa 127984.faa 152721.faa 127985.faa 156494.faa 242271.faa 242364.faa 262855.faa 262852.faa 21217.faa 221067.faa 175714.faa 175715.faa 175716.faa 175717.faa 175718.faa 175719.faa 220597.faa 219828.faa 226559.faa 262850.faa 220918.faa 221005.faa 262856.faa 220962.faa 53578.faa 262857.faa 221053.faa 219833.faa 220951.faa 257834.faa 226551.faa 226556.faa 258037.faa 288399.faa 262858.faa 262860.faa 262862.faa 262872.faa 262874.faa 262880.faa 262879.faa 220815.faa 219833.faa 220951.faa);

my $file2=$ARGV[1];
#my $file2=$ARGV[0];
#__________________________________________
my %GENOME;
#___________________________________________
#foreach my $file (@files){
	my $Org=readRastGenomeFile($file,\%GENOME);
	my $OrgName=readOrgName($Org,$file2);
	printEvo(\%GENOME,$Org,$OrgName,$file);
#}

sub printEvo{
  my $refGENOME=shift;
    my $Org=shift;
    my $OrgName=shift;
    my $file=shift;

open (OUT,">$file.evo") or die "No pude abrir escritura $!" ;
    my @st=split(" ",$OrgName);
    my $NCBI=$st[$#st];
    $OrgName=~s/$NCBI//;
    #print "Org is $Org";
    my $file3=$file;
    $file3=~s/faa/txt/;

    foreach my $key (sort keys %{$refGENOME}){
        #print "KEY $key\n";
        open(FILE, "$file3") or die "Couldnt open Function File $!";
        #print "File3 $file3\n";
        foreach my $line(<FILE>){
            chomp $line;
            $line=~s/\r//;
            my @st=split("\t",$line);
            my $peg=$st[1]."\t";
            if($peg=~m/peg.$key\t/){
                print OUT ">gi|$key|$Org|$NCBI|$st[7]|$OrgName\n";
                #print ">gi|$key|$Org|$NCBI|$st[7]|$OrgName\n";
                print OUT "$refGENOME->{$key}\n";
                #print "$refGENOME->{$key}\n";
            #    >gi|ginumber|gb|gbId|funcion|OrganismoConcatenado
                last;
                }
            }   
        close FILE; 
        }close OUT;
    }
##################################################

sub readOrgName{
    my $Org=shift;
    my $file2=shift;
    my $name;
    open(FILE, "$file2") or die "Couldnt open Fasta $!";

    foreach my $line (<FILE>){
        chomp $line;
    #    print "$line\n"
        my @st=split("\t",$line);
        if ($line =~/$Org/){
    #        print"$st[0]\t$st[1]\t$st[2]\n";
            $name=$st[2];
            last;
            }
        }
    return $name;
    close FILE;
    }


#####################################################
sub readRastGenomeFile{
    my $file=shift;
    my $refGENOME=shift;
    my $orgNum;
    my $id="";

    open(FILE, "$file") or die "Couldnt open Fasta $!";
    foreach my $line (<FILE>){
        chomp $line;
        if ($line=~ />/ ){
            my $newline=$line;
            $newline=~s/>fig\|//;
            $newline=~s/\./\t/g;
            my @st=split("\t",$newline);
            #print "$st[0] \t $st[1] \t $st[3] \n";           
            $orgNum = join(".", $st[0], $st[1]);
            $id=$st[3];
            }
        else{
            if(!exists $refGENOME->{$id}){$refGENOME->{$id}="";}
            $refGENOME->{$id}=$refGENOME->{$id}.$line;
            }
        }
    #print "¡$orgNum!\n";

    close FILE;
    return $orgNum;   
    }
