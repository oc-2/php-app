#!/usr/bin/env perl
use strict;
use warnings;
use Cwd 'abs_path';

my $php = $ENV{PHP} || 'php';

# check php availability
my $php_check = system($php, '-v');
die "PHP not found or not executable ('$php'). Set \$ENV{PHP} or ensure 'php' is in PATH.\n"
    if $php_check != 0;

my ($host, $port, $docroot) = @ARGV;
$host    ||= '127.0.0.1';
$port    ||= '8000';
$docroot ||= '.';

die "Docroot '$docroot' does not exist or is not a directory.\n" unless -d $docroot;

print "Starting PHP built-in server at http://$host:$port/ (docroot=" . abs_path($docroot) . ")\n";
exec $php, '-S', "$host:$port", '-t', $docroot or die "Failed to exec php: $!\n";