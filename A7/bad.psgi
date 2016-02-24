#!/usr/bin/env plackup
use v5.22;

use Plack::Request;

my $app = sub {

    # Use Plack::Request to parse the env
    my $req = Plack::Request->new(shift);

    # BAD BAD BAD Return secrets without checking access
    return [ 200, [ 'Content-type' => 'text/plain' ], [ 'Secret Data for Logged Users Only' ] ];
};

# vim: ft=perl ts=4 sw=4
