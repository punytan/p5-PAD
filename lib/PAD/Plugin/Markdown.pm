package PAD::Plugin::Markdown;
use strict;
use warnings;
use parent 'PAD::Plugin';
use Plack::MIME;
use Plack::App::File;
use Text::Markdown 'markdown';

sub suffix { qr/.md$/ }

sub content_type { 'text/html; charset=UTF-8' }

sub execute {
    my ($self, $req) = @_;
    my $path = "./" . $req->path_info;

    open my $text, '<', $path or die $!;
    my $md = markdown(do { local $/; <$text> });

    $req->new_response(
        200,
        ['Content-Type' => $self->content_type],
        $md
    )->finalize;
}

1;
__END__

