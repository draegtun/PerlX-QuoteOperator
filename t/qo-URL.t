#!perl -T

use Test::More tests => 3;

use Directory::Scratch;
use constant WIN32 => $^O eq 'MSWin32';

my $tmpfile = 'qURL';
my $tmp  = Directory::Scratch->new;
my $file = $tmp->touch( $tmpfile, stuff() );

my $url  = 'file:' . sub {
    return $_[0]->as_foreign('Unix') if WIN32;
    return $_[0]->stringify;
}->( $file );

# default test
use PerlX::QuoteOperator::URL;
is qURL/$url/, test_stuff(), 'qURL testing file:// content';

# renamed to qh
use PerlX::QuoteOperator::URL 'qh';
is qh{$url}, test_stuff(), 'qh testing file:// content';

# re-test default again but with ()
is qURL($url), test_stuff(), 'qURL() testing file:// content';

# clear up scratch
$tmp->delete( $tmpfile ) or diag "Issue removing tmp file ($file)";
undef $tmp; # everything else is removed


sub test_stuff { stuff() . "\n" }

sub stuff {
    join "\n", (
        "first line of data",
        "now the second line",
        "and finally the third line",
    );
}
