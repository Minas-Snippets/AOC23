#!/usr/bin/perl

my $t; # time 
while(<>) {
    s/\D//g;
    unless($t) {
        $t = $_/2;
        next
    }
    my $r = sqrt($t*$t -$_);
    my ($x1, $x2) = ($t - $r, $t + $r);
    $x1 = int($x1 + 1);
    $x2 = $x2 == int($x2) ? int($x2 - 1) : int($x2);
    print ($x2 - $x1 + 1);    
}
