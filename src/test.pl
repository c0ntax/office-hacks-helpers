#!/usr/bin/perl -w

$| = 1;

BEGIN {
    use File::Basename;
    push(@INC, dirname(__FILE__) . '/../lib');
}

use OfficeHacksHelpers::Utils;

my $utils = OfficeHacksHelpers::Utils->new('verbose' => 1, 'redirectToStderr' => 0);
$utils->vPrint('Hello...');
$utils->vPrint("Done\n");