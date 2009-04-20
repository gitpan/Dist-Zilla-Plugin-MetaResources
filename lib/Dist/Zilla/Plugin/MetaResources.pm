package Dist::Zilla::Plugin::MetaResources;

# ABSTRACT: Dist::Zilla with meta resources

use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::InstallTool';

use Dist::Zilla::File::InMemory;

has 'homepage';
has 'repository';
has 'bugtracker';
has 'MailingList';

sub setup_installer {
    my ( $self, $arg ) = @_;

    my $has_meta;
    foreach ( 'homepage', 'repository', 'bugtracker', 'MailingList' ) {
        $has_meta++ if $self->{$_};
    }
    return unless $has_meta;

    # check if [MakeMaker] is there
    my $has_maker = $self->zilla->plugins->grep(
        sub { ref $_ eq 'Dist::Zilla::Plugin::MakeMaker' } )->length;

    if ($has_maker) {

        # get orignal Makefile.PL
        my $file =
          $self->zilla->files->grep( sub { $_->name =~ m{Makefile\.PL\z} } )
          ->head;

        if ($file) {
            my $content = $file->content;

            my $meta_resources = qq~
  META_MERGE  => {
    resources => {
~;
            foreach ( 'homepage', 'repository', 'bugtracker', 'MailingList' ) {
                if ( $self->{$_} ) {
                    $meta_resources .= "        $_ => '$self->{$_}',\n";
                }
            }
            $meta_resources .= "    }\n  },";
            $content =~ s/(PREREQ_PM\s+\=\>\s+\{(.*?)\}\,)/$1$meta_resources/s;
            $file->content($content);
        }
        else {
            $self->zilla->log(
"[MetaResources] Skip Makefile.PL ([MetaResources] needs after [MakeMaker]"
            );
        }
    }

    my $has_build = $self->zilla->plugins->grep(
        sub { ref $_ eq 'Dist::Zilla::Plugin::ModuleBuild' } )->length;

    if ($has_build) {

        # get orignal Makefile.PL
        my $file =
          $self->zilla->files->grep( sub { $_->name =~ m{Build\.PL\z} } )->head;

        if ($file) {
            my $content = $file->content;

            my $meta_resources = qq~
  meta_merge  => {
    resources => {
~;
            foreach ( 'homepage', 'repository', 'bugtracker', 'MailingList' ) {
                if ( $self->{$_} ) {
                    $meta_resources .= "        $_ => '$self->{$_}',\n";
                }
            }
            $meta_resources .= "    }\n  },";
            $content =~
              s/(script_files\s+\=\>\s+\[(.*?)\]\,)/$1$meta_resources/;
            $file->content($content);
        }
        else {
            $self->zilla->log(
"[MetaResources] Skip Build.PL ([MetaResources] needs after [MakeMaker]"
            );
        }
    }

    return;
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

=pod

=head1 NAME

Dist::Zilla::Plugin::MetaResources - Dist::Zilla with meta resources

=head1 VERSION

version 0.01

=head1 NAME

Dist::Zilla::Plugin::MetaResources - Dist::Zilla with meta resources

=head1 VERSION

version 0.01

=head1 SYNOPSIS

      # at the end of the dist.ini

      [MetaResources]
      repository = http://github.com/fayland/dist-zilla-plugin-metaresources/tree/master
      homepage = http://github.com/fayland/dist-zilla-plugin-metaresources
      bugtracker = http://github.com/fayland/dist-zilla-plugin-metaresources/issues

=head1 DESCRIPTION

rewrite the Makefile.PL and Build.PL

=head1 AUTHOR

    Fayland Lam <fayland@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Fayland Lam.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=head1 AUTHOR

  Fayland Lam <fayland@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Fayland Lam.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 

__END__
