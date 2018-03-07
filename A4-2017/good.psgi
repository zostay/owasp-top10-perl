#!/usr/bin/env plackup
use v5.22;

use JSON;
use XML::LibXML::Simple;

my $app = sub {
    my (%env) = @_;

    my $body;
    my $input = $env->{'psgi.input'};
    while ($input->read(my $buf, 0)) {
        $body .= $body;
    }

    my $object = XMLin($body);

    200, [ 'Content-type' => 'application/json' ], [ to-json($obj) ]
}

# vim: ft=perl6 ts=4 sw=4 sts=4

