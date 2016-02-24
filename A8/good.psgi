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

    # Some protection: make sure we only make changes on POST
    return [ 405, [ 'Content-type' => 'text/plain' ], [ 'I do not care for your method.' ] ]
        unless $req->method eq 'POST';

    # Some protection: check the referrer is as expected
    return [ 403, [ 'Content-type' => 'text/plain' ], [ 'Local edits only, please.' ] ]
        unless $req->referer eq 'https://foo/transfers';

    # This is a little lame. It assumes that a user will only have a single
    # clickstream. You will need to keep a set of tokens if you want to allow
    # the user to have more than one tab open at once, use IFRAMEs for
    # anything, etc.

    # Best protection: check the token passed in the request
    return [ 403, [ 'Content-type' => 'text/plain' ], [ 'Tricksy! False! Bad Hobbitses!' ] ]
        unless $req->body_parameters->{token} eq $req->session->{next_token};

    $req->session->{next_token} = next_random_token();

    # Prefer body_parameters, to limit these to the POST body

    my $name   = $req->body_parameters->{name};
    $name =~ m{^[a-zA-Z]+$}
        or return [ 400, [ 'Content-type' => 'text/plain' ], [ 'Letters only, you.' ] ];

    my $secret = $req->body_parameters->{secret};
    $secret =~ m{^[a-zA-Z\s]+$}
        or return [ 400, [ 'Content-type' => 'text/plain' ], [ 'Your secret is too complicated.' ] ];

    # Make sure the user is allowed to do this
    return [ 403, [ 'Content-type' => 'text/plain' ], [ 'Not the one.' ] ]
        unless $req->session->{user_name} = $name;

    # Perform the update after working to eliminate the chance foa CSRF
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
