package PAD;
use strict;
use warnings;
our $VERSION = '0.01';
use Plack::Runner;
use Plack::Request;
use Plack::App::Directory;

sub new {
    my ($class, %args) = @_;
    $class->require($args{class});
    bless { %args }, $class;
}

sub psgi_app {
    my $self = shift;
    return sub {
        my $req  = Plack::Request->new(shift);
        my $path = $req->path_info;
        $path =~ s/[\/\\\0]//g;

        if ($path eq '/' || $path eq 'favicon.ico' || not $path) {
            return Plack::App::Directory->new->to_app->($req->env);
        }

        if ($path =~ $self->class->suffix) {
            return $self->class->execute($req, $path);
        }

        return Plack::App::Directory->new->to_app->($req->env);
    };
}

sub require {
    my (undef, $class, $method) = @_;
    unless ($class->can($method || "new")) {
        my $path = $class;
        $path =~ s|::|/|g;
        require "$path.pm"; ## no critic
    }
}

sub class { shift->{class} }

1;
__END__

=head1 NAME

PAD -

=head1 SYNOPSIS

  use PAD;

=head1 DESCRIPTION

PAD is

=head1 AUTHOR

punytan E<lt>punytan@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
