use Module::Build;

my $build = Module::Build->new
    (
     module_name => 'Gives',
     license => 'perl',
     requires => {
       'perl'                => '5.6.0',
       'Attribute::Handlers' => 0,
       'Carp'                => 0,
       'Sub::Name'           => 0,
       'Want'                => 0,
       'version'             => 0,
     },
     recommends => {
       'Pod::Readme'      => 0.06,           # for building distro
     },
     build_requires => {
       'Test::More'     => 0,
     },
     create_readme      => ($Module::Build::VERSION >= 0.2702),
     create_makefile_pl => 'traditional',
     dist_author        => 'Robert Rothenberg <rrwo at cpan.org>',
     sign               => 0,
     keywords           => [
       "inside-out objects",
       "moebius objects",
       "tied hashes",
     ],
     resources          => {
       license          => 'http://dev.perl.org/licenses/',
       bugtracker       => 'http://rt.cpan.org/Public/Dist/Display.html?Name=Gives',
     },
);

$build->create_build_script;

