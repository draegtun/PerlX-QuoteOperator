package PerlX::QuoteOperator;
use strict;
use warnings;
use Devel::Declare ();
use base 'Devel::Declare::Context::Simple';

our $VERSION = '0.01';
our $qtype   = __PACKAGE__ . '::qtype';
our $parser  = __PACKAGE__ . '::parser';
our $debug   = __PACKAGE__ . '::debug';

sub import {
    my ($self, $name, $param, $caller) = @_;
    
    # not importing unless name & parameters provided (TBD... check these)
    return unless $name && $param;
    
    # called directly and not via a PerlX::QuoteOperator::* module
    unless ($caller) {
        $caller = caller;
        $self   = __PACKAGE__->new;
    }
    
    # quote like operator to emulate.  Default is qq// unless -emulate is provided
    $self->{ $qtype } = $param->{ -emulate } || 'qq';  
    
    # invoke my heath robinson parser or not?  
    # (not using parser means just insert quote operator and leave to Perl)
    $self->{ $parser } = $param->{ -parser } || 0;
    
    # debug or not to debug... that is the question
    $self->{ $debug } = $param->{ -debug } || 0;

    # Create D::D trigger for $name in calling program
    Devel::Declare->setup_for(
        $caller, { 
            $name => { const => sub { $self->parser(@_) } },
        },
    );
    
    no strict 'refs';
    *{$caller.'::'.$name} = $param->{ -with };
}

sub parser {
    my $self = shift;
    $self->init(@_);
    $self->skip_declarator;          # skip past "http"

    my $line = $self->get_linestr;   # get me current line of code

    if ( $self->{ $parser } ) {
        # find start & end of quote operator
        my $pos   = $self->offset;        # position just after "http"
        my $delim = substr( $line, $pos, 1 );
        do { $pos++ } until substr( $line, $pos, 1 ) eq $delim;
        
        # and wrap sub() around quote operator (needed for lists)
        substr( $line, $pos + 1, 0 )      = ')';
        substr( $line, $self->offset, 0 ) = '(' . $self->{ $qtype };
        
    }
    else {
        # Can rely on Perl parser for everything.. just insert quote-like operator
        substr( $line, $self->offset, 0 ) = q{ } . $self->{ $qtype };
    }

    # eg: qURL(http://www.foo.com/baz) => qURL qq(http://www.foo.com/baz)
    # pass back to parser
    $self->set_linestr( $line );
    warn "$line\n" if $self->{ $debug };

    return;
}


1;


__END__

=head1 NAME

PerlX::QuoteOperator - Create new quote-like operators in Perl

=head1 VERSION

Version 0.01


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use PerlX::QuoteOperator;

    my $foo = PerlX::QuoteOperator->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 import


=head2 parser


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


=head1 DISCLAIMER

This is (near) beta software.   I'll strive to make it better each and every day!

However I accept no liability I<whatsoever> should this software do what you expected ;-)

=head1 COPYRIGHT & LICENSE

Copyright 2009 Barry Walsh (Draegtun Systems Ltd), all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

