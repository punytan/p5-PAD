use inc::Module::Install;
name 'PAD';
all_from 'lib/PAD.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
