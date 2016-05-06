use MyConstant qw (:ALL);
use strict;
my @list = qw (J u s t ~ A n o t h e r ~ P e r l ~ H a c k e r !);
 
print func1(@list),"\n";
print func2(@list),"\n";

#my $const=MyConstant::CONST;
#my $amiga=MyConstant::AMIGA;

my $const=CONST;
my $amiga=AMIGA;
my $UF=ENABLE_RCSE;

print " LA CONStaNTE es $const \n";
print " LA amiga es $amiga ".$UF."\n";

