#!perl -T

use Test::More tests => 3;

my @list = qw/foo bar baz/;
my $expected = join q{ }, @list;

use PerlX::QuoteOperator quc => { -emulate => 'q', -with => sub ($) { uc $_[0] } };
is quc/$expected/, uc('$expected'), 'basic q test';

use PerlX::QuoteOperator qquc => { -emulate => 'qq', -with => sub ($) { uc $_[0] } };
is qquc/$expected/, uc($expected), 'basic qq test';

use PerlX::QuoteOperator qwuc => { -emulate => 'qw', -with => sub (@) { @_ } };
is_deeply [qwuc/foo bar baz/], \@list, 'basic qw test';
