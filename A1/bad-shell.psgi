#!/usr/bin/env plackup
use v5.14;

use Plack::Request;

my $app = sub {
    # Plack::Request makes getting parameters easier
    my $req = Plack::Request->new(shift);

    # Load the expression
    my $file = $req->parameters->{file};

    # BAD BAD BAD Use one-arg system to take action
    system "touch $file" == 0
        or return [ 500, [ 'Content-type' => 'text/plain' ], [ "ERROR: $!" ] ];

    return [ 200, [ 'Content-type' => 'text/plain' ], [ "RESULT = $value" ] ];
};

# vim: ft=perl
