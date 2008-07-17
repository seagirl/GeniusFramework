package Web::View;
use strict;
use warnings;
use base qw/Class::Accessor::Lvalue::Fast/;

__PACKAGE__->mk_accessors(qw/path_segments vars/);

sub vars {
    my $self = shift;
    $self->{'vars'} ||= {};
    
    if (@_) {
        my %args = (ref $_[0]) ? %{$_[0]} : @_;
        while (my ($key, $value) = each %args) {
            $self->{'vars'}->{$key} = $value;
        }
    }
    else {
        return $self->{'vars'};
    }
}

sub template_file {
    my $self = shift;
    File::Spec->require;
    my $file = File::Spec->catfile('webroot', @{$self->path_segments});
    $file .= '.html';
    return $file;
}

sub render {
    my $self = shift;
    Template->require;
    my $template = Template->new;
    $template->process($self->template_file, $self->vars, \my $out)
        or die $template->error;
    return $out;
}

sub to_xml {
    my $self = shift;
    XML::Simple->require;
    my $xs = XML::Simple->new(
        KeepRoot => 1,
        NoAttr => 1,
        rootname => 'result',
        XMLDecl => '<?xml version="1.0" encoding="utf-8"?>'
    );
    return $xs->XMLout($self->vars);
}

sub to_json {
    my $self = shift;
    JSON::XS->require;
    my $json = JSON::XS->new;
    return $json->pretty(1)->encode($self->vars);   
}

1;