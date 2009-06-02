#!/usr/bin/perl
use strict;
use warnings;

my $app = 'myapp';

use Cwd;
my $pwd=Cwd::cwd();

my $filename='test.conf';
open my $f, '>', $filename or die "$filename: $!";

print $f <<EOF;
server.modules              = ("mod_fastcgi")

server.document-root        = "root"

index-file.names            = ( "index.html", "index.htm", "default.htm" )
# server.event-handler = "freebsd-kqueue" # needed on OS X

server.port                = 1500

fastcgi.server = (
    "" => (
        "app" => (
            "socket" => "$pwd/app.socket",
            "check-local" => "disable",
            "bin-path" => "$pwd/script/${app}_fastcgi.pl",
            "min-procs"    => 2, "max-procs"    => 5, "idle-timeout" => 20
        )                                                                           )
)
EOF

close $f;

exec 'lighttpd', '-D', '-f', 'test.conf';
