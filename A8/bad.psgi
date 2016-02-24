#!/usr/bin/env plackup
use v5.22;

use autodie;
use Plack::Request;

# This example assumes that you have Plack::Middleware::Session in place or
# something similar.

my $app = sub {

    # Use Plack::Request to parse the env
    my $req = Plack::Request->new(shift);

    # Make sure the user is logged in
    return [ 403, [ 'Content-type' => 'text/plain' ], [ 'Not welcome.' ] ]
        unless $req->session->{authorized_user};

    my $name   = $req->parameters->{name};
    $name =~ m{^[a-zA-Z]+$}
        or return [ 400, [ 'Content-type' => 'text/plain' ], [ 'Letters only, you.' ] ];

    my $secret = $req->parameters->{secret};
    $secret =~ m{^[a-zA-Z\s]+$}
        or return [ 400, [ 'Content-type' => 'text/plain' ], [ 'Your secret is too complicated.' ] ];

    # Make sure the user is allowed to do this
    return [ 403, [ 'Content-type' => 'text/plain' ], [ 'Not the one.' ] ]
        unless $req->session->{user_name} = $name;

    # BAD BAD BAD Update vulnerable to Cross Site Request Forgery
    update_secret_data_for($name, $secret);

    return [ 200, [ 'Content-type' => 'text/plain' ], [ 'Secret updated.' ] ];
}

# Very official secret updater thing
sub update_secret_data_for {
    my ($name, $secret) = @_;

    open my $fh, "secrets/$name";
    say $fh $secret;
    close $fh;
}

# vim: ft=perl ts=4 sw=4
