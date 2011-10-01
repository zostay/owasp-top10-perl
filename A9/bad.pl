#!/usr/bin/env perl
use v5.14;

# Technically speaking, this is not as much a web application security issue as
# much as it is a web server configuration issue. However, your application
# design will help affect this.
#
# As such, it is easier to demonstrate a client interation than a server one for
# this purpose.

use LWP::UserAgent;

# BAD BAD BAD Posting a login using HTTP without SSL
my $ua = LWP::UserAgent->new( cookie_jar => {} );
$ua->post('http://foo/login', [ username => 'me', password => 'secret' ]);
my $res = $ua->get('http://foo/info');
