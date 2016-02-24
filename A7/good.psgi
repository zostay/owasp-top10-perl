#!/usr/bin/env plackup
use v5.22;

use Plack::Request;

# This example assumes that you have Plack::Middleware::Session in place or
# something similar.

my $app = sub {

    # Use Plack::Request to parse the env
    my $req = Plack::Request->new(shift);

    # Only let logged users in; maybe best to send them off to a login screen
    return [ 403, [ 'Content-type' => 'text/plain' ], [ 'No way, José!' ] ]
            unless $req->session->{'authorized_user'};

    # Return secrets without checking access
    return [ 200, [ 'Content-type' => 'text/plain' ], [ 'Secret Data for Logged Users Only' ] ];
};

# vim: ft=perl ts=4 sw=4
