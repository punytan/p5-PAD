package PAD::Plugin;
use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    bless { %args }, $class;
}

sub suffix { }

sub execute { }

1;
__END__
