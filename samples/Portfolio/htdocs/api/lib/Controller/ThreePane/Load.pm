package Controller::ThreePane::Load;
use strict;
use warnings;
use base qw/Web::Controller/;
use Model::Blog;

sub do_task {
    my $self = shift;
    
    $self->view->vars(Model::Blog->load);

    $self->response->content_type = 'text/xml';
    $self->response->content = $self->view->to_xml;
}

1;