package Web::Response;
use strict;
use warnings;
use base qw/Class::Accessor::Lvalue::Fast/;

__PACKAGE__->mk_accessors(qw/content_type content/);

1;