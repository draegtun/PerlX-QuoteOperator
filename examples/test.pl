#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;

# old style
#use PerlX::QuoteOperator qwuc => [ qw => sub (@) { @_ } ];

# new style
use PerlX::QuoteOperator quc => { -emulate => 'qq', -with => sub ($) { uc $_[0] } };
say quc{this will be all in upper case};

