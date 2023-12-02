#!/usr/bin/perl

use 5.34.0;

my $sum = 0;
my %max = ( red => 12, green => 13, blue => 14 );

while(<>) {
    s/^Game (\d+):\s+(.+)$/$2/ or next;
    my $id = $1;
    my @tries = split ';';
    for(@tries) {
        last unless $id;
        my @marbles = split ',';
        for(@marbles) {
            last unless $id;
            m/(\d+)\s(\w+)/ or next;
            $1 <= $max{$2} or $id = 0;
        }
    }
    $sum += $id;
}

say $sum
