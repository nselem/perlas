package MyConstant;

use strict;
use warnings;

use base 'Exporter';

use constant CONST => "NELLY";
my %constants;
BEGIN {
   %constants = (
      AMIGA       => "VERO",
      LOG_USERS_ACTIONS => 1,
      ENABLE_RCSE       => "1",
   );
}

use constant \%constants;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
$VERSION     = 1.00;
@ISA         = qw(Exporter);
@EXPORT_OK = qw (func1 func2 CONST);
push @EXPORT_OK, keys(%constants);

%EXPORT_TAGS = (
   ALL     => \@EXPORT_OK,
   DEFAULT => \@EXPORT,
   LOG     => [ grep /^LOG_/, @EXPORT_OK ], # all constants beginning +with "LOG_"
   FUNC    => [qw(&func1 &func2)]
);

sub func1  { return reverse @_  }
sub func2  { return map{ uc }@_ }

1;
