package Web::Controller;
use strict;
use warnings;
use base qw/Class::Accessor::Lvalue::Fast/;
use Web::View;
use Web::Response;
use UNIVERSAL::require;

__PACKAGE__->mk_accessors(qw/request response view/);

sub handle_request {
    my $self = shift;
    
    $self->do_task;
    
    if (not defined $self->response->content) {
        $self->response->content = $self->view->render;
    }
    
    $self->response->content_type ||= 'text/html';
    return $self->response;
}

1;