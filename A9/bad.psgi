#!/usr/bin/env perl

# BAD BAD BAD Perl 5.8.0 is ancient and not patched against known
# vulnerabilities
use 5.800000;

my $app = sub {
    my $env = shift;

    # BAD BAD BAD Your own software has a well-known, unfixed flaw!
    return [ 200, [ 'Content-type' => 'text/plain' ], [ eval $env->{QUERY_STRING} ] ];
};

# vim: ft=perl ts=4 sw=4 sts=4
