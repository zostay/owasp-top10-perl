#!/usr/bin/env plackup
use v5.22;

use Plack::Request;

my $app = sub {
    # Plack::Request makes getting parameters easier
    my $req = Plack::Request->new(shift);

    # Load the expression
    my $file = $req->parameters->{file};

    # Validate the filename is what we expect
    $file =~ m{^[a-z0-9._\-]+$}
        or return [ 400, [ 'Content-type' => 'text/plain' ], [ 'Bad filename.' ] ];

    # Use multi-arg system to be more safe
    system(qw( touch ), $file) == 0
        or return [ 500, [ 'Content-type' => 'text/plain' ], [ "ERROR: $!" ] ];

    return [ 200, [ 'Content-type' => 'text/plain' ], [ "RESULT = $value" ] ];
};

# vim: ft=perl ts=4 sw=4
