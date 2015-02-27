# NAME

PerlX::QuoteOperator - Create new quote-like operators in Perl

# VERSION

Version 0.07

# SYNOPSIS

Create a quote-like operator which convert text to uppercase:

    use PerlX::QuoteOperator quc => {
        -emulate => 'q', 
        -with    => sub ($) { uc $_[0] }, 
    };
    
    say quc/do i have to $hout/;
    
    # => DO I HAVE TO $HOUT

# DESCRIPTION

## QUOTE-LIKE OPERATORS

Perl comes with some very handy Quote-Like Operators 
[http://perldoc.perl.org/perlop.html#Quote-Like-Operators](http://perldoc.perl.org/perlop.html#Quote-Like-Operators) :)

But what it doesn't come with is some easy method to create your own quote-like operators :(

This is where PerlX::QuoteOperator comes in.  Using the fiendish [Devel::Declare](https://metacpan.org/pod/Devel::Declare) under its hood  
it "tricks", sorry "helps!" the perl parser to provide new first class quote-like operators.

## HOW DOES IT DO IT?

The subterfuge doesn't go that deep.  If we take a look at the SYNOPSIS example:

    say quc/do i have to $hout/;
    

Then all PerlX::QuoteOperator actually does is convert this to the following before perl compiles it:

    say quc q/do i have to $hout/;
    

Where 'quc' is a defined sub expecting one argument  (ie, sub ($) { uc $\_\[0\] }  ).

This approach allows PerlX::QuoteOperator to perform the very basic keyhole surgery on the code,
ie. just put in the emulated quote-like operator between keyword & argument.

However this approach does have caveats especially when qw// is being used!.  See CAVEATS.
There is an alternative parser when can be invoked,  see -parser Export parameter.

## WHY?

Bit like climbing Mount Everest... because we can!  ;-)

Is really having something like:

    say quc/do i have to $hout/;
    

so much better than:

    say uc 'do i have to $hout';
    

or more apt this:

    say uc('do i have to $hout');
    

Probably not... at least in the example shown.  But things like this are certainly eye catching:

    use PerlX::QuoteOperator::URL 'qh';
    
    my $content = qh( http://transfixedbutnotdead.com );   # does HTTP request

NOTICE - As for version 0.05 (23rd Feb 2015), PerlX::QuoteOperator::URL was moved to its own distribution.

And this:

    use PerlX::QuoteOperator qwHash => { 
        -emulate    => 'qw',
        -with       => sub (@) { my $n; map { $_ => ++$n } @_ },
    };

    my %months = qwHash/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/;

Certainly give the code aesthetic a good pause for thought.

# EXPORT

By default nothing is exported:

    use PerlX::QuoteOperator;    # => imports nothing
    

Quote operator is imported when passed a name and options like so:

    use PerlX::QuoteOperator quote_operator_name_i_want_to_use => { }   

A hashref is used to pass the options.

## PARAMETERS

### -emulate

Which Perl quote-like operator required to emulate.  q, qq & qw have all been tested.

Default: emulates qq

### -with

Your quote-like operator code reference / anon subroutine goes here.

Remember to use subroutine prototype (if not using -parser option):

    -with    => sub ($) { uc $_[0] }, 

This is a mandatory parameter.

### -parser

If set then alternative parser kicks in.   This parser currenly works on single line of code only
and must open/close quote with (), {}, \[\], <> or must have same delimeter for beginning and end of quote:

    -parser => 1
    

When invoked this parser will take this:

    quc/do i have to $hout/;

And by finding the end of the quote will then encapulate it like so:

    quc(q/do i have to $hout/);

Default: Not using alternative parsing.

### -debug

If set then prints (warn) the transmogrified line so that you can see what PerlX::QuoteOperator has done!

    -debug => 1

Default:  No debug.

# FUNCTIONS

## import

Module import sub.

## parser

When keyword (defined quote operator) is triggered then this sub uses [Devel::Declare](https://metacpan.org/pod/Devel::Declare) 
to provide necessary keyhole surgery/butchery on the code to make it valid Perl code (think Macro here!).

## \_closing\_delim

Internal subroutine used in -parser option.

# CAVEATS

Performing a method call or dereference using -> like below will not work:

    use PerlX::QuoteOperator qurl => { 
        -emulate => 'q', 
        -with    => sub ($) { require URI; URI->new($_[0]) },
    };
    
    qurl(http://www.google.com/)->authority;   # Throws an error

Because the parsed qurl line becomes this...

    qurl q(http://www.google.com/)->authority;

... so throwing an error trying to call `authority` on a string.  See "HOW DOES IT DO IT" for more info.  

A workaround is to use the _alternative_ parser and the line would now be parsed like this:

    qurl(q(http://www.google.com/))->authority;
    

See -parser option for more information.

Also see examples/qw.pl for some more issues with creating qw based quote-like operators. NB. The alternative parser will get around some of these problems but then (potentially) introduces a few new ones! (see TODO)

Recommendation: Stick with Perl parser and all will be fine! 

# SEE ALSO

- [PerlX::QuoteOperator::URL](https://metacpan.org/pod/PerlX::QuoteOperator::URL)

# CONTRIBUTORS

Toby Inkster ([https://metacpan.org/author/TOBYINK](https://metacpan.org/author/TOBYINK)) for Text::Balanced patch to the alternative parser at 0.04

# AUTHOR

Barry Walsh, `<draegtun at cpan.org>`

# BUGS

Please report any bugs or feature requests to [https://github.com/draegtun/PerlX-QuoteOperator/issues](https://github.com/draegtun/PerlX-QuoteOperator/issues)

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc PerlX::QuoteOperator

You can also look for information at:

- Github issues & push requests

    [https://github.com/draegtun/PerlX-QuoteOperator/issues](https://github.com/draegtun/PerlX-QuoteOperator/issues)

- Old resolved bugs can be found on RT: CPAN's request tracker

    [http://rt.cpan.org/NoAuth/Bugs.html?Dist=PerlX-QuoteOperator](http://rt.cpan.org/NoAuth/Bugs.html?Dist=PerlX-QuoteOperator)

- AnnoCPAN: Annotated CPAN documentation

    [http://annocpan.org/dist/PerlX-QuoteOperator](http://annocpan.org/dist/PerlX-QuoteOperator)

- CPAN Ratings

    [http://cpanratings.perl.org/d/PerlX-QuoteOperator](http://cpanratings.perl.org/d/PerlX-QuoteOperator)

- Search CPAN

    [http://search.cpan.org/dist/PerlX-QuoteOperator/](http://search.cpan.org/dist/PerlX-QuoteOperator/)
    [https://metacpan.org/pod/PerlX::QuoteOperator/](https://metacpan.org/pod/PerlX::QuoteOperator/)

# ACKNOWLEDGEMENTS

From here to oblivion!:  [http://transfixedbutnotdead.com/2009/12/16/url-develdeclare-and-no-strings-attached/](http://transfixedbutnotdead.com/2009/12/16/url-develdeclare-and-no-strings-attached/)

And a round of drinks for the mad genius of [MST](http://search.cpan.org/~mstrout/) for creating [Devel::Declare](https://metacpan.org/pod/Devel::Declare) in the first place!

# DISCLAIMER

This is (near) beta software.   I'll strive to make it better each and every day!

However I accept no liability _whatsoever_ should this software do what you expected ;-)

# COPYRIGHT & LICENSE

Copyright 2009-2015 Barry Walsh (Draegtun Systems Ltd | [http://www.draegtun.com](http://www.draegtun.com)), all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.
