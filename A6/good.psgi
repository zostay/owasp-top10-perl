#!/usr/bin/env plackup
use v5.22;

use Crypt::Rijndael;
use Crypt::SaltedHash;
use Plack::Request;

# This example assumes that you have Plack::Middleware::Session in place or
# something similar.

# Very official storage things
my %passwords;
my %credit_cards;

# Very official production application secret
#
# WARNING: Don't actually use this key and do not actually keep your key
# stored in your code. Preferably, the key used should be encrypted by another
# key and stored on a separate file system, which is protected by a passphrase
# which requires at least two DevOps/SysOps to enter during application start
# up.
#
my $PROD_SECRET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123';

my $app = sub {

    # Use Plack::Request to parse the env
    my $req = Plack::Request->new(shift);

    return [ 403, [ 'Content-type' => 'text/plain' ], [ 'This connection is not secure.' ] ]
        unless $req->secure;

    return [ 403, [ 'Content-type' => 'text/plain' ], [ 'You are not admin. Go away.' ] ]
        unless $req->session->{authorize_user};

    my $name     = $req->body_parameters->{name};
    $name =~ m{^[a-zA-Z]+$}
        or return [ 400, [ 'Content-type' => 'text/plain' ], [ 'That name is illegal.' ] ];

    my $password = $req->body_parameters->{password};

    # Storing passwords in a salted SHA-512
    my $csh = Crypt::SaltedHash->new(algorithm => 'SHA-512');
    $csh->add($password);
    $passwords{ $name } = $csh->generate;

    my $cc_number = $req->body_parameters->{credit_card_number};
    $cc_number =~ m{^[0-9]{15,16}$}
        or return [ 400, [ 'Content-type' => 'text/plain' ], [ 'That cannot possibly be a VISA or American Express.' ] ];

    # Storing credit card numbers using AES (aka Rijndael)
    my $cipher = Crypt::Rijndael->new($PROD_SECRET, Crypt::Rijndael::MODE_CBC);
    $credit_cards{ $name } = $cipher->encrypt($cc_number);

    return [ 200, [ 'Content-type' => 'text/plain' ], [ 'Account and payment information updated.' ] ];
};

# vim: ft=perl ts=4 sw=4
