#!perl -T

use Test::More tests => 2;

BEGIN {
    use_ok( 'PerlX::QuoteOperator' );
    use_ok( 'PerlX::QuoteOperator::URL' );
}

diag( "Testing PerlX::QuoteOperator $PerlX::QuoteOperator::VERSION, Perl $], $^X" );
