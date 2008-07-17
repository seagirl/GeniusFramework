#!/usr/bin/perl

use strict;
use warnings;
use lib qw(lib);
use Web::Application;

my $application = Web::Application->new;

my $response = $application->dispatch;

print $application->request->header(
    -type => $response->content_type,
    -charset => 'utf-8',
    -Content_length => $response->content_length
);

print $response->content;

exit 0;