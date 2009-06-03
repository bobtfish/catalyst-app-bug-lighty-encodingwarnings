package MyApp::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    if ($c->user) {
        $c->stash->{template} = 'logged_in.tt';
    }
    else {
        if (!$c->req->param('username') {
            $c->stash->{template} = 'login.tt';
        }
        if ($c->authenticate({username => $c->req->param('username'), password => $c->req->param('password') }) ) {
            $c->stash->{template} = 'logged_in.tt';
        }
        else {
            $c->stash->{template} = 'fail.tt';
        }
    }
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Tomas Doran,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
