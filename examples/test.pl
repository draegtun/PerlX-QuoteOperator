#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;

use PerlX::QuoteOperator qwuc => [ qw => sub (@) { @_ } ];
say qwuc/foo bar baz/, qw/one two three/;