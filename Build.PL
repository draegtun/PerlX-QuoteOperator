use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'PerlX::QuoteOperator',
    license             => 'perl',
    dist_author         => q{Barry Walsh <draegtun@cpan.org>},
    dist_version_from   => 'lib/PerlX/QuoteOperator.pm',
    build_requires => {
        'Test::More' => 0,
        'Devel::Declare' => 0,
        'Devel::Declare::Context::Simple' => 0,
        'LWP::Simple' => 0,
    },
    add_to_cleanup      => [ 'PerlX-QuoteOperator-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
