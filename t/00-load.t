#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok('Dist::Zilla::Plugin::MetaResources');
}

diag(
"Testing Dist::Zilla::Plugin::MetaResources $Dist::Zilla::Plugin::MetaResources::VERSION, Perl $], $^X"
);
