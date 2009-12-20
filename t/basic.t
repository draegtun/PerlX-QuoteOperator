#!perl -T

use Test::More tests => 3;

my @list = qw/foo bar baz/;
my $expected = join q{ }, @list;

use PerlX::QuoteOperator quc => [ q  => sub ($) { uc $_[0] } ];
is quc/$expected/, uc('$expected'), 'basic q test';

use PerlX::QuoteOperator qquc => [ qq => sub ($) { uc $_[0] } ];
is qquc/$expected/, uc($expected), 'basic qq test';

use PerlX::QuoteOperator qwuc => [ qw => sub (@) { @_ } ];
is_deeply [qwuc/foo bar baz/], \@list, 'basic qw test';
