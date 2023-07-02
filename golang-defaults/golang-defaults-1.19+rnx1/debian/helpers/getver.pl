#!/usr/bin/perl

# Extract upstream version from version in changelog.

use warnings;
use strict;

use Dpkg::Changelog::Parse;

my $fields = changelog_parse();
my $v = $fields->{Version}->version();
$v =~ /^([0-9]+\.[0-9]+).*/ or die 'INVALID VERSION! (needs X.Y)';

printf("%s\n", $1);
