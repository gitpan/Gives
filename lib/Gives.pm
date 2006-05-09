package Gives;

require 5.006;

use strict;
use warnings;

use Attribute::Handlers;
use Carp qw( croak );
use Sub::Name;
use Want;

use version; our $VERSION = qv("0.1.0");

{
  sub UNIVERSAL::Gives :ATTR {
    my ($package, $glob, $ref, $attr, $data, $phase) = @_;
    {
      no strict 'refs';
      no warnings 'redefine';

      croak "Gives only applies to CODE" unless(UNIVERSAL::isa($ref,"CODE"));

      my $symbol = *$glob{NAME};
      my $pkg    = (defined $package) ? $package : "main";
      my @types  = (UNIVERSAL::isa($data,"ARRAY")) ? @$data : ($data);

      *{$glob} = subname "${pkg}::${symbol}" => sub {
	croak "sub ${symbol} returns ".join(", ",@types),
	  unless (want(@types));
	goto $ref;
      };
    }

  }
}

1;

=head1 NAME

Gives - Uses Want to add Perl types to subroutines

=begin readme

=head1 REQUIREMENTS

Perl 5.6.0 is required, along with the following (possibly non-core) modules:

  Attribute::Handlers
  Sub::Name
  Want
  version

=head1 INSTALLATION

Installation can be done using the traditional F<Makefile.PL> or the
newer F<Build.PL> method .

Using Makefile.PL:

  perl Makefile.PL
  make test
  make install

(On Windows platforms you should use F<nmake> instead.)

Using Build.PL (if you have L<Moddule::Build> installed):

  perl Build.PL
  perl Build test
  perl Build install

=end readme

=head1 SYNOPSIS

  use Gives;

  sub my_func : Gives('LIST') {
    ...
    return @some_list;
  }

  @val = my_func();  # ok

  $val = my_func();  # causes an error

=head1 DESCRIPTION

This package uses L<Want> to add some rudimentary context checking to
subroutines.  It allows you to avoid using a subroutine or method in
the wrong context.

It I<does not> check the type returned by the function. If you want to
enforce return types, use L<Variable::Strict::Types>. (You may be able
to use both packages together.)

You specify the context using the Gives attribute:

  sub my_func : Gives( @Contexts ) {
  }

where C<@Contexts> is a list of contexts accepted by L<Want> (see the
package documentation for valid contexts).

=head1 CAVEATS AND KNOWN ISSUES

This is an experimental package.  There may be bugs.

There may be incompatabilities with L<Class::Std>.

=head1 SEE ALSO

  Want
  Attribute::Context
  Sub::Context
  Attribute::Signature
  Attribute::Types
  Variable::Strict::Types

=head1 AUTHOR

Robert Rothenberg <rrwo at cpan.org>

=head2 Suggestions and Bug Reporting

Feedback is always welcome.  Please use the CPAN Request Tracker at
L<http://rt.cpan.org> to submit bug reports.

=head1 LICENSE

Copyright (c) 2006 Robert Rothenberg. All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
