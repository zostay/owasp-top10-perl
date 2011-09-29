#!/usr/bin/env plackup
use v5.14;

use Plack::Request;

my $app = sub {
    # Build a request object to parse the parameters for us
    my $req = Plack::Request->new(shift);

    # Get the goto parameter
    my $goto = $req->parameters->{goto};

    # BAD BAD BAD Redirect to wherever that says to go
    return [ 302, [ 'Location' => $goto ], [] ];
};

# vim: ft=perl
