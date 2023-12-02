#!/usr/bin/perl

use 5.34.0;

my $sum = 0;

while(<>) {
    s/^Game \d+:\s+(.+)$/$1/ or next;
    my @tries = split ';';
    my %min = ( red => 0, green => 0, blue => 0 );
    for(@tries) {
        my @marbles = split ',';
        for(@marbles) {
            m/(\d+)\s(\w+)/ or next;
            $min{$2} = $1 if $1 > $min{$2}
        }
    }
    $sum += $min{red} * $min{green} * $min{blue};
}

say $sum
