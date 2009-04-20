
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Dist-Zilla-Plugin-MetaResources',
  NAME      => 'Dist::Zilla::Plugin::MetaResources',
  AUTHOR    => 'Fayland\ Lam\ \<fayland\@gmail\.com\>',
  ABSTRACT  => 'Dist::Zilla with meta resources',
  VERSION   => '0.01',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Dist::Zilla" => '1.006',
  },
  META_MERGE  => {
    resources => {
        homepage => 'http://github.com/fayland/dist-zilla-plugin-metaresources',
        repository => 'http://github.com/fayland/dist-zilla-plugin-metaresources/tree/master',
        bugtracker => 'http://github.com/fayland/dist-zilla-plugin-metaresources/issues',
    }
  },
);
