#!/usr/bin/perl
use strict;
## It is asumed that the svg is parsed before to s/>/>\n/

my $file= $ARGV[0];
my @parts=split("blast",$file);
my $path=$parts[0];
#######modificado Christian 11/02/16##########


#####################fin Christian########################
 
#`perl -p -i -e 's/// $file'`;
my $w=300; ##Desired new w

# Obtain width From Line <svg width='200'
## Store this vaue on $W
my $W=GetWidth($file);

# Create new svg with $scale=$w/$W
my $scale=$w/$W;

NewSvg($file);

sub NewSvg{
	print "Opening New\n";
	my $file=shift;
	if (-e "$file.new"){unlink("$file.new");}
	open(ORIGINAL, "$file") or die "Couldn't open SVG file $!";
	open(NEW, ">$file.new") or die "Couldn't open new SVG file $!";
	
	my $previous="";

	while (my $line=<ORIGINAL>){
		chomp $line;
	
		if($line=~/svg\swidth/){
           		$line ="<svg width='$w' height='$w' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'> <script xlink:href=\"/html/evoMining/js/SVGPan.js\"/>";
## Agregar linea javaScript
		#	print "$line\n";
			}
		if($line=~/\/defs/){
			## Agregar  viewId
           		$line ="</defs> <g id=\"viewport\" transform='scale($scale,$scale)'>";
		#	print "$line\n";
			}
			if($line=~/<\/svg>/){
		        	$line ="</g> </svg>";
		#	print "$line\n";
			}
			
		if($line=~/\<text class=\'leaf-label\'/){
			$previous=$line;
			$previous =~ s/\<text/\<a xlink\:href=\"\/cgi-bin\/newevomining\/sendtoDrawContext\.pl\?XXXX|$path\" target=\"iframe_abajo\"\>\<text/;
			$line="";
			}	
                if($line=~/\<\/text\>/ and $line=~/.+[a-zA-Z].+\<\/text\>/){
		 	my $ID=$line;
			$ID=~s/\<\/text\>//;
			$line =~ s/\<\/text\>/\<\/text\>\<\/a\>/;
			$previous=~s/XXXX/$ID/;
			#$line=~$file.$line;
			$line=$previous."\n".$line;
			$previous="";

			}
		print NEW "$line\n";
		}
	close ORIGINAL;
	close NEW;
	}

#below line </defs> insert: $line="<g transform='scale(.03,.03)'>"
# Sunstitute last ine for $final_line="</g> </svg>";

sub GetWidth{
	my $file=shift;
	my $width=0;
	open(ORIGINAL, "$file") or die "Couldn't open SVG file $!";
	while (my $line=<ORIGINAL>){
		chomp $line;
		if($line=~/svg\swidth/){
			#print "$line\n";
			my @sp=split("width='",$line);
			my @sp1=split("'",$sp[1]);
			#print"Split: $sp[1]\n";
			#print"Split: $sp1[0]\n";
			$width=$sp1[0];		
			print "width=$width\n";
			last;
			}	
		}
	close ORIGINAL;
	return $width;
	}

