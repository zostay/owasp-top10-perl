#!/usr/bin/env plackup
use v5.22;

use Plack::Builder;
use Plack::Request;

# BAD BAD BAD Left a developer configuration on in prod
our $developer_mode = 1;

my $app = sub {

    # Use Plack::Request to parse the environment
    my $req = Plack::Request->new(shift);

    return [ 200, [ 'Content-type' => 'text/html' ], [ '<h1>Fancy Production Application</h1>' ] ];
}

builder {
    enable 'Debug' if $developer_mode;

    $app;
};

# vim: ft=perl ts=4 sw=4 sts=4
