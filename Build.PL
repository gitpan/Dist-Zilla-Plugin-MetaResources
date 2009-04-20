
use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
  module_name   => 'Dist::Zilla::Plugin::MetaResources',
  license       => 'perl',
  dist_abstract => "Dist\:\:Zilla\ with\ meta\ resources",
  dist_name     => "Dist\-Zilla\-Plugin\-MetaResources",
  dist_author   => [
"Fayland\ Lam\ \<fayland\@gmail\.com\>",
  ],
  requires      => {
    "Dist::Zilla" => '1.006',
  },
  script_files => [ qw() ],
  meta_merge  => {
    resources => {
        homepage => 'http://github.com/fayland/dist-zilla-plugin-metaresources',
        repository => 'http://github.com/fayland/dist-zilla-plugin-metaresources/tree/master',
        bugtracker => 'http://github.com/fayland/dist-zilla-plugin-metaresources/issues',
    }
  },
);

$build->create_build_script;
