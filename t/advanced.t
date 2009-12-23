#!perl -T

use Test::More skip_all => 'TBD';

my @list = qw/foo bar baz/;
my $expected = join q{ }, @list;

use PerlX::QuoteOperator qwuc => { -emulate => 'qw', -with => sub (@) { @_ } };

# multi-line qw// not possible yet (would require risky parsing!!)
is_deeply [ qwuc/
    foo 
    bar 
    baz/], \@list, 'advanced qw test';

# TBD
#  qw only allows matching delimiters, for eg.  / !    Need to add (), {}, [] into parser
