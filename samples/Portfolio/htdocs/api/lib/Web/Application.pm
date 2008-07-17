package Web::Application;
use strict;
use warnings;
use base qw/Class::Accessor::Lvalue::Fast/;
use Web::View;
use Web::Response;
use CGI;
use UNIVERSAL::require;

__PACKAGE__->mk_accessors(qw/request path/);

sub dispatch {
    my $self = shift;
    
    if (not defined $self->request) {
        $self->request = CGI->new;
    }
        
    $self->path = $self->request->path_info;
    
    my $c = $self->controller;
    $c->request = $self->request;
    $c->response = Web::Response->new;
    $c->view = Web::View->new({ path_segments => [ $self->path_segments ] });
    $c->handle_request;
    
    return $c->response;
}

sub controller {
    my $self = shift;
    my $handler = join '::', 'Controller',
        map {ucfirst} $self->path_segments;
    $handler->require or die $@;
    return $handler->new;
}

sub path_segments {
    my $self = shift;
    $self->path ||= '/';
    
    my @path_segments = split '/', $self->path;
    shift @path_segments;
    push @path_segments, 'index' if not @path_segments;
    
    return @path_segments;
}

1;