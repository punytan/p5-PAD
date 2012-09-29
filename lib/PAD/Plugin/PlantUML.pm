package PAD::Plugin::PlantUML;
use strict;
use warnings;
use parent 'PAD::Plugin';
use Plack::MIME;
use Plack::App::File;

sub suffix { qr/.uml$/ }

sub content_type { 'text/plain; charset=UTF-8' }

sub execute {
    my ($self, $req) = @_;
    my $path = "./" . $req->path_info;

    my $java_bin = `which java`;
    $java_bin =~ s/[\n\r]//g; # or die 'Install Java :(';

    my $graphviz_dot = `which dot`;
    $graphviz_dot =~ s/[\n\r]//g;#  or warn 'Running without graphviz';

    my $plant_uml_jar = "$ENV{HOME}/plantuml.jar";

    if ($req->query_parameters->{render}) {
        my $cmd = join " ",
        "env",
        "JAVA_BIN='$java_bin'",
        "GRAPHVIZ_DOT='$graphviz_dot'",
        "$java_bin -jar $plant_uml_jar",
        "-SdefaultFontName='Hiragino Kaku Gothic Pro W3'",
        "-charset utf8",
        "'$path'";

        system $cmd;
        $path =~ s/uml$/png/;
    }

    my $content_type = Plack::MIME->mime_type($path) || $self->content_type;

    open my $image, '<', $path or die $!;

    $req->new_response(
        200,
        ['Content-Type' => $content_type],
        $image,
    )->finalize;
}

1;
__END__


