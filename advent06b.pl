#!/usr/bin/perl

my $t; # time 
while(<>) {
    s/\D//g;
    unless($t) {
        $t = $_/2;
        next
    }
    print 2*$t - 2*int($t - sqrt($t*$t -$_) + 1) + 1   
}
