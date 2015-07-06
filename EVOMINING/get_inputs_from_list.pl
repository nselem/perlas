use strict;
use warnings;

my $file=$ARGV[0]; ##File with genome ids
print "$file\n";
my %LIST;


###################### Main ########################################
read_list($file,\%LIST);

foreach my $gi (keys %LIST){
	print "working on $gi\n";
	my $gi_file=$LIST{$gi};
	my %CONTEXT=read_context($gi,$gi_file);
	print_context($gi,\%CONTEXT);
}
#my $gi="297202266";
#my $gi_file="GBK_DB/NZ_CM000951.gbk"; 


#my %CONTEXT=read_context($gi,$gi_file);
#print_context($gi,\%CONTEXT);


######################### sub ########################################
sub print_context{
	my $gi=shift;
	my $refCONTEXT=shift;
	my $MID=$refCONTEXT->{$gi}[6];

	open (FILE,">$gi.input") or die "Could not open $gi file $!";

			my $start=$refCONTEXT->{$gi}[0];
			my $stop=$refCONTEXT->{$gi}[1];
			my $dir=$refCONTEXT->{$gi}[2];
			my $color=$refCONTEXT->{$gi}[3];
			if($dir eq "-"){
				my $temp=$start;
				$start=$stop;
				$stop=$temp;
				}
			my $org=$refCONTEXT->{$gi}[4];
			my $func=$refCONTEXT->{$gi}[5];
			print "$start\t$stop\t$dir\t$color\t$org\t$func\t$gi\n";
			print FILE "$start\t$stop\t$dir\t$color\t$org\t$func\t$gi\n";

	foreach my $key(sort {$a<=>$b} keys %{$refCONTEXT}){
	
		my $mid=$refCONTEXT->{$key}[6];
		my $dist=abs($MID-$mid);

		if($dist<5000){
			my $start=$refCONTEXT->{$key}[0];
			my $stop=$refCONTEXT->{$key}[1];
			my $dir=$refCONTEXT->{$key}[2];
			my $color=$refCONTEXT->{$key}[3];
			if($dist==0){$color=1;}
			if($dir eq "-"){
			my $temp=$start;
			$start=$stop;
			$stop=$temp;
			}
			my $org=$refCONTEXT->{$key}[4];
			my $func=$refCONTEXT->{$key}[5];
			print "$start\t$stop\t$dir\t$color\t$org\t$func\t$gi\n";
			print FILE "$start\t$stop\t$dir\t$color\t$org\t$func\t$gi\n";
			}
		}
	}




#________________________________________________________________________
sub read_context{
	my $gi=shift;
	my $gi_file=shift;
	my %GEN;
	

#	print "$gi\n";
#	print "$gi_file\n";

	open (FILE,$gi_file) or die "Could not open $gi_file \n $!";

	my $direction;
	my $start;
	my $stop;
	my $func;
	 my $bool;
	my $file=join(<FILE>);
	print "$file\n";



	foreach my $line (<FILE>){
		chomp $line;
		if ($line=~m/\s\sCDS\s\s\s/){
			$bool=1;
			my @sp=split(/[(.)]/,$line);
#			print ("########$line\n");

			if($sp[0]=~m/comp/){
				$direction="-";
				$start=$sp[1];
				$start=~s/[^\d]//g;
				$stop=$sp[3];
				$stop=~s/[^\d]//g;
			}
			else{
				$direction="+";
				$start=$sp[0];
				$start=~s/[^\d]//g;
				$stop=$sp[2];
				$stop=~s/[^\d]//g;
				}

#			print ("dir $direction, start $start, stop $stop\n");
			}
		if ($line=~m/product\=/){
			$func=$line;
			$func=~s/\/product\=//;
			$func=~s/\"//g;
			$func=~s/\s+/ /;
#			print"$func\n";
			}

		if ($line=~m/db_xref/ and $line=~m/GI/){
			chomp $line;
			my $GI=$line;
			$GI=~s/[^\d]//g;
#			print "GI:¡$GI!\n";
			my $midle=int(($start+$stop)/2);
			$GEN{$GI}=[$start,$stop,$direction,"0","org",$func,$midle];	
			}
		}	

	close FILE;
	return %GEN;
}
#_________________________________________________________________________________
sub read_list{
	my $file=shift;
	my $refLIST=shift;
	open (FILE, $file) or die "Could not open file $file \n $!";

	for my $line (<FILE>){
		chomp $line;
		my @sp=split(/\t/,$line);

		if ($sp[0] and $sp[1]){
			#print("0:$sp[0],1:$sp[1]\n");
			my $grep=`grep $sp[0] GBK_DB/*.gbk`;
			my $hit_file=$grep;
			chomp $hit_file;
			$hit_file=~s/:.+//g;

			#print "grep ¡$sp[0]!\n";
			print "File ¡$hit_file! for $sp[0] founded!\n";
			if($sp[0] and $hit_file){
				$refLIST->{$sp[0]}=$hit_file;
				}
			}
		else {
	#		my $np=$line;
	#		$np=~s/_\d+//;
	#		print "$np\n";
			}
		}
	close FILE;	
	}
