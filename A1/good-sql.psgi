#!/usr/bin/env plackup
use v5.22;

use Plack::Request;

my $app = sub {
    # Plack::Request makes getting parameters easier
    my $req = Plack::Request->new(shift);

    # Load the name
    my $name = $req->parameters->{name};

    # Bind the name to the SQL query
    my $foo = $dbh->selectrow_hashref(
        "select stuff from foo where name = ?", undef, $name);

    # Return the result
    return [ 200, [ 'Content-type' => 'text/plain' ], [ $foo->{stuff} ] ];
};

# vim: ft=perl ts=4 sw=4 sts=4
