#!/usr/bin/env plackup
use v5.22;

use Plack::Request;

my $app = sub {
    # Plack::Request makes getting parameters easier
    my $req = Plack::Request->new(shift);

    # Load the expression
    my $expression = $req->parameters->{expression};

    # BAD BAD BAD Eval the given expression
    my $value = eval "$expression";

    return [ 200, [ 'Content-type' => 'text/plain' ], [ "RESULT = $value" ] ];
};

# vim: ft=perl ts=4 sw=4
