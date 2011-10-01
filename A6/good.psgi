#!/usr/bin/env plackup
use v5.14;

use Plack::Builder;
use Plack::Request;

# DevOps set PLACK_ENV to "production" in production
our $developer_mode = $ENV{PLACK_ENV} eq 'development';

my $app = sub {

    # Use Plack::Request to parse the environment
    my $req = Plack::Request->new(shift);

    return [ 200, [ 'Content-type' => 'text/html' ], [ '<h1>Fancy Production Application</h1>' ] ];
}

builder {
    enable 'Debug' if $developer_mode;

    $app;
};

