#!/usr/bin/env perl
use v5.22;

my $app = sub {
    my $env = shift;

    # Return some stuff
    return [ 200, [ 'Content-type' => 'text/plain' ], [ 'Fixed Query String Eval' ] ];
};

# vim: ft=perl ts=4 sw=4 sts=4
