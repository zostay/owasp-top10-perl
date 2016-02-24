#!/usr/bin/env plackup

# BAD BAD BAD Using an old and probably less secure version of Perl
use 5.800000;

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
