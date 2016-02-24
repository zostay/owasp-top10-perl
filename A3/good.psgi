#!/usr/bin/env plackup
use v5.22;

use HTML::Entities;
use Plack::Request;

my $app = sub {
    # Use Plack::Request to help parse the environment
    my $req = Plack::Request->new(shift);

    # Load our input
    my $input = $req->parameters->{input};

    # Validate the input to make sure there aren't any <script> tags in it
    return [ 400, [ 'Content-type' => 'text/html' ], [ 'You are naughty.' ] ]
            unless $input =~ /^\w+$/;

    # Prior to outputting, make sure we encode it for HTML
    my $output = encode_entities($input);

    # Display that input in the HTML page
    return [
        200, [ 'Content-type' => 'text/html' ],
        [
            qq[<html><head><title>Hello</title></head>],
            qq[<body><p>$output</p></body></html>],
        ]
    ];
};

# vim: ft=perl ts=4 sw=4
