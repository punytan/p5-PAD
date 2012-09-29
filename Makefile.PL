use inc::Module::Install;
name 'PAD';
all_from 'lib/PAD.pm';

requires 'Plack::App::Directory';
requires 'Plack::App::File';
requires 'Plack::MIME';
requires 'Plack::Request';
requires 'Plack::Runner';
requires 'Text::Markdown';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;

install_script 'script/pad';

WriteAll;
