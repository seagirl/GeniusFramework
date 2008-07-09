package FrontController;
use strict;
use warnings;
use CGI;
use XML::Simple;
use Controller::ThreePane;

sub new {
    my $invocant = shift;
    my $class = ref($invocant) || $invocant;
    my $self = { @_ };

    $self->{'query'} = new CGI();
    my %V = $self->{'query'}->Vars();
    my $result = { status => 2 };
    
    if (defined $V{'controller'} and defined $V{'action'}) {
        my %DS =
        (
            'ThreePane_load' => { class => 'ThreePane', method => 'load' },
            'ThreePane_sync' => { class => 'ThreePane', method => 'sync' },
        );
        
        my $k = $V{'controller'} . '_' . $V{'action'};
        if (defined $DS{$k}) {
            my $reference = 'Controller::' . $DS{$k}->{'class'};
            my $api = new $reference();
            my $action = $DS{$k}->{'method'};
            
            $result = $api->$action(\%V);
        }
    }
    
    my $xml = new XML::Simple(
        KeepRoot => 1,
        NoAttr => 1,
        XMLDecl => '<?xml version="1.0" encoding="utf-8"?>'
    );
    $self->{'output'} = $xml->XMLout($result);
    
    return bless($self, $class);
}

sub query {
  my $self = shift;
  return $self->{'query'};
}

sub output {
  my $self = shift;
  return $self->{'output'};
}

sub DESTROY {
  my $self = shift;
}

1;
