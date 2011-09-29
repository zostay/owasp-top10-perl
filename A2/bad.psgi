#!/usr/bin/env plackup
use v5.14;

use Plack::Request;

my $app = sub {
    # Use Plack::Request to help parse the environment
    my $req = Plack::Request->new(shift);

    # Load our input
    my $input = $req->parameters->{input};

    # Display that input in the HTML page
    return [ 
        200, [ 'Content-type' => 'text/html' ], 
        [ "<html><head><title>Hello</title></head><body><p>$input</p></body></html>" ] 
    ];
};

# vim: ft=perl
