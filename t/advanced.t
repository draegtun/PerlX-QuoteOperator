#!perl -T

use Test::More tests => 2;

my @list = qw/foo bar baz/;
my $expected = join q{ }, @list;

use PerlX::QuoteOperator qwuc => { -emulate => 'qw', -with => sub (@) { @_ } };

# multi-line - only possible at this point as long as -parse not set
is_deeply [ qwuc{
    foo 
    bar 
    baz}], \@list, 'advanced qw multi-line test';

# multi-line would fail without -parser set
use PerlX::QuoteOperator qwS => { -emulate => 'qw', -with => sub (@) { join q{ }, @_ }, -parser => 1 };
is qwS/foo bar baz/, $expected, 'advanced qw multi-line parser test';
