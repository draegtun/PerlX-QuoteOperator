#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;

# some qw// examples

use PerlX::QuoteOperator qwuc => { 
    -emulate    => 'qw', 
    -with       => sub (@) { map { uc } @_ },
};

# yikes.. it does qw/one two three/ as well!  
say qwuc/foo bar baz/, qw/one two three/;

# this loses qw/one two three/  :(
my @list = (qwuc/foo bar baz/), qw/one two three/;
say @list;

# so in this position have to use -parser
use PerlX::QuoteOperator qwucx => { 
    -emulate    => 'qw',
    -parser     => 1,
    -with       => sub (@) { map { uc } @_ },
};

# now works as expected
say qwucx/foo bar baz/, qw/one two three/;
