#!perl -T

use Test::More tests => 2;

use PerlX::QuoteOperator::URL;

my $content = qqURL( http://www.draegtun.com );

# naff test for now
ok( length( $content) > 100, "naff web test");


use PerlX::QuoteOperator::URL 'qh';

ok( length( qh(http://www.draegtun.com) ) > 100, "naff 2");