#!/usr/bin/env plackup
use v5.14;

use Plack::Request;

# This example assumes that you have Plack::Middleware::Session in place or
# something similar.

# Very official storage things
my %passwords;
my %credit_cards;

my $app = sub {
    
    # Use Plack::Request to parse the env
    my $req = Plack::Request->new(shift);

    return [ 403, [ 'Content-type' => 'text/plain' ], [ 'You are not admin. Go away.' ] ]
        unless $req->session->{authorize_user};

    my $name     = $req->body_parameters->{name};
    $name =~ m{^[a-zA-Z]+$}
        or return [ 400, [ 'Content-type' => 'text/plain' ], [ 'That name is illegal.' ] ];

    my $password = $req->body_parameters->{password};

    # BAD BAD BAD Storing passwords in plain text
    $passwords{ $name } = $password;

    my $cc_number = $req->body_parameters->{credit_card_number};
    $cc_number =~ m{^[0-9]{15,16}$}
        or return [ 400, [ 'Content-type' => 'text/plain' ], [ 'That cannot possibly be a VISA or American Express.' ] ];

    # BAD BAD BAD Storing credit card numbers in plain text
    $credit_cards{ $name } = $cc_number;

    return [ 200, [ 'Content-type' => 'text/plain' ], [ 'Account and payment information updated.' ] ];
};
