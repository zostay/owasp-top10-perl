#!/usr/bin/env plackup
use v5.22;

use Plack::Request;

my $app = sub {
    # Use Plack::Request to help parse the environment
    my $req = Plack::Request->new(shift);

    # Load our input
    my $input = $req->parameters->{input};

    # BAD BAD BAD Display that input in the HTML page, but without validation or
    # encoding out the possibly SCRIPT or other malicious tags.
    return [
        200, [ 'Content-type' => 'text/html' ],
        [
            qq[<html><head><title>Hello</title></head>],
            qq[<body><p>$input</p></body></html>],
        ]
    ];
};

# vim: ft=perl ts=4 sw=4 sts=4
