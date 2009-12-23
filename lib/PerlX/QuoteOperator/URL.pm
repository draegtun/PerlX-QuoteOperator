package PerlX::QuoteOperator::URL;
use strict;
use warnings;
use PerlX::QuoteOperator ();
use LWP::Simple ();

our $VERSION = '0.01';

sub import {
    my ($class, $name) = @_;
    
    my $caller = caller;
    my $code   = sub ($) { LWP::Simple::get( $_[0] ) };

    my $ctx = PerlX::QuoteOperator->new;
    $ctx->import( $name || 'qURL', { -emulate => 'qq', -with => $code }, $caller );
}

1;

__END__

=head1 NAME

PerlX::QuoteOperator::URL - Quote-like operator returning http request for the URL provided.

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use PerlX::QuoteOperator::URL;

    my $content = qURL( http://transfixedbutnotdead.com );   # does HTTP request


=head1 DESCRIPTION

For more info see L<PerlX::QuoteOperator>.

For now here is another example:

    use PerlX::QuoteOperator::URL 'qh';
    use JSON qw(decode_json);

    say decode_json( qh{ http://twitter.com/statuses/show/6592721580.json } )->{text};

    # => "He nose the truth."
    

=head1 EXPORT

By default 'qURL' is exported to calling package/program.

This can be changed by providing a name of your own choice:

    use PerlX::QuoteOperator::URL 'q_http_request';
    

=head1 FUNCTIONS

=head2 import

Standard import subroutine.


=head1 SEE ALSO

=over 4

=item * L<PerlX::QuoteOperator>

=item * L<http://transfixedbutnotdead.com/2009/12/16/url-develdeclare-and-no-strings-attached/>

=back


=head1 AUTHOR

Barry Walsh, C<< <draegtun at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-perlx-quoteoperator at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=PerlX-QuoteOperator>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc PerlX::QuoteOperator


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=PerlX-QuoteOperator>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/PerlX-QuoteOperator>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/PerlX-QuoteOperator>

=item * Search CPAN

L<http://search.cpan.org/dist/PerlX-QuoteOperator/>

=back


=head1 ACKNOWLEDGEMENTS

Inspired by this blog post: L<http://ozmm.org/posts/urls_in_ruby.html> and wanting to learn L<Devel::Declare>


=head1 DISCLAIMER

This is (near) beta software.   I'll strive to make it better each and every day!

However I accept no liability I<whatsoever> should this software do what you expected ;-)

=head1 COPYRIGHT & LICENSE

Copyright 2009 Barry Walsh (Draegtun Systems Ltd), all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

