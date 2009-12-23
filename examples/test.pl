#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;

# old style
#use PerlX::QuoteOperator qwuc => [ qw => sub (@) { @_ } ];

# new style
use PerlX::QuoteOperator qwuc => { -emulate => 'qw', -with => sub (@) { @_ } };
say qwuc/foo bar baz/, qw/one two three/;

