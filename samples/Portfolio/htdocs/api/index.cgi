#!/usr/bin/perl

use warnings;
use strict;
use lib qw(lib);
use FrontController;

my $controller = new FrontController();
my $output = $controller->output;

print $controller->query->header(
    -type   => 'application/xml',
    -Content_length => length($output),
);
print $output;

exit(0);
