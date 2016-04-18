#!/usr/bin/env perl

# BAD BAD BAD Perl 5.8.0 is ancient and not patched against known
# vulnerabilities
use 5.800000;

my $app = sub {
    my $env = shift;

    # BAD BAD BAD Your own software has a well-known, unfixed flaw!
    #
    # TODO 2012-05-04 This is a security bug, but we don't have time to fix
    # it right now. We'll fix it with Bug#45433 in next month's release..
    return [ 200, [ 'Content-type' => 'text/plain' ], [ eval $env->{QUERY_STRING} ] ];
};

# vim: ft=perl ts=4 sw=4 sts=4
