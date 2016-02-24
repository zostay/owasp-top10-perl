#!/usr/bin/env plackup
use v5.22;

use Plack::Request;

my $app = sub {
    # Build a request object to parse the parameters for us
    my $req = Plack::Request->new(shift);

    # Get the goto parameter
    my $goto = $req->query_parameters->{goto};

    # FORBIDDEN unless the goto is one we expect
    return [ 403, [ 'Content-type' => 'text/plain' ], [ 'Absolutely not.' ] ]
        unless $goto ~~ [ qw( http://foo http://bar http://baz ) ];

    # TODO A lookup table for redirects would be even better!

    # Redirect to wherever that says to go
    return [ 302, [ 'Location' => $goto ], [] ];
};

# vim: ft=perl ts=4 sw=4 sts=4
