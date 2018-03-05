#!/usr/bin/env plackup
use v5.22;

use Plack::Request;

my $app = sub {
    # Plack::Request makes getting parameters easier
    my $req = Plack::Request->new(shift);

    # Load the expression
    my $expression = $req->parameters->{expression};

    # Make sure it's just numbers and accepted operators
    $expression =~ m{^\d+[+-*]\d+$}
        or return [ 403, [ 'Content-type' => 'text/plain' ], [ 'Naughty!' ] ];

    # Still not wonderful... eval the validated expression
    my $value = eval "$expression";

    return [ 200, [ 'Content-type' => 'text/plain' ], [ "RESULT = $value" ] ];
};

# vim: ft=perl ts=4 sw=4 sts=4
