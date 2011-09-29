#!/usr/bin/env plackup
use v5.14;

use Plack::Request;

# This example assumes that you have Plack::Middleware::Session in place or
# something similar.

my $app = sub {
    # Use Plack::Request to parse the environment
    my $req = Plack::Request->new(shift);

    # Get the name and make sure it's valid
    my $name = $req->parameters->{name};
    $name =~ m{^[a-zA-Z]+$}
        or return [ 400, [ 'Content-type' => 'text/plain' ], [ 'You give love a bad name.' ] ];

    # Check that the user is authorized to use this site
    return [ 403, [ 'Content-type' => 'text/plain' ], [ 'Neener! Neener! Neener!' ] ]
        unless $req->session->{authorized_user};

    # Lookup secret data for the anmed user
    my $data = lookup_secret_data_for($name);

    # Check that this user can see this secret data
    return [ 404, [ 'Content-type' => 'text/plain' ], [ 'What secret data?' ] ]
        unless defined $data;

    # BAD BAD BAD Show without making sure whose secrets you are 
    # giving away.
    return [ 200, [ 'Content-type' => 'text/plain' ], [ $data ] ];
};

# Very official secret keeper thing
sub lookup_secret_data_for {
    my $name = shift;

    state $secret_data = {
        bob   => 'likes cats',
        steve => 'likes dogs',
        rob   => 'likes ponies',
    };

    return $secret_data->{ $name } if defined $secret_data->{ $name };
    return;
}

# vim: ft=perl
