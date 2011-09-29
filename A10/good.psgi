#!/usr/bin/env plackup -p5010
use v5.14;

use Plack::Request;

my $app = sub {
    # Build a request object to parse the parameters for us
    my $req = Plack::Request->new(shift);

    # Get the goto parameter
    my $goto = $req->query_parameters->{goto};

    # FORBIDDEN unless the goto is one we expect
    return [ 403, [ 'Content-type' => 'text/plain' ], [ 'Absolutely not.' ] ]
        unless $goto ~~ [ qw( http://foo http://bar http://baz ) ];

    # Redirect to wherever that says to go
    return [ 302, [ 'Location' => $goto ], [] ];
};

# vim: ft=perl
