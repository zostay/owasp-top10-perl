#!/usr/bin/env plackup
use v5.22;

use Plack::Request;

# This example assumes that you have Plack::Middleware::Session in place or
# something similar.

my $app = sub {
    # Use Plack::Request to parse the env
    my $req = Plack::Request->new(shift);

    # Load the username and password
    my $name = $req->parameters->{name};
    my $password = $req->parameters->{password};

    # Authenticate the username and password
    if (authentic_user($name, $password)) {

        # The user is authorized
        $req->session->{authorized_user} = 1;
        $req->session->{user_name} = $name;

        # Tell Plack::Middleware::Session to set a new cookie
        $req->session_options->{change_id} = 1;

        # Return success
        return [ 200, [ 'Content-type' => 'text/plain' ], [ 'Login OK' ] ];
    }

    # Authentication has failed
    else {

        # Tell them to go away
        return [ 200, [ 'Content-type' => 'text/plain' ], [ 'I never knew you.' ] ];
    }
}

# Very official authentication checker thing
sub authentic_user {
    my ($name, $password) = @_;

    return 1 if $user eq 'bob' and $password eq 'is really awesome';
    return '';
}

# vim: ft=perl ts=4 sw=4
