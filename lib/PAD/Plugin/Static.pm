package PAD::Plugin::Static;
use strict;
use warnings;
use parent 'PAD::Plugin';
use Plack::MIME;
use Plack::App::File;

sub suffix { qr/.+/ }

sub content_type {
    my ($self, $path) = @_;
    Plack::MIME->mime_type($path) || 'text/plain; charset=UTF-8';
}

sub execute {
    my ($self, $req) = @_;
    my $path = "./" . $req->path_info;
    Plack::App::File->new->serve_path($req->env, $path);
    return Plack::App::Directory->new->to_app->($req->env);
}

1;
__END__
