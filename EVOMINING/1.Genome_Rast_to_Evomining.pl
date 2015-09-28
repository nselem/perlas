use strict;
use warnings;

my $condicion=1;
my $file=$ARGV[0];
my $file2=$ARGV[1];
#__________________________________________
my %GENOME;
#___________________________________________
my $Org=readRastGenomeFile($file,\%GENOME);
my $OrgName=readOrgName($Org,$file2);
printEvo(\%GENOME,$Org,$OrgName,$file);

sub printEvo{
    my $refGENOME=shift;
    my $Org=shift;
    my $OrgName=shift;
    my $file=shift;

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
                print ">gi|$NCBI|$Org|$key|$st[7]|$OrgName\n";
                print "$refGENOME->{$key}\n";
            #    >gi|ginumber|gb|gbId|funcion|OrganismoConcatenado
                last;
                }
            }   
        close FILE;
        }
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


