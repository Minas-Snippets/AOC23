#!/usr/bin/perl

my $s = 0;
while(<>) {
    chomp;
    if(m/^\D*(\d)/) {
        $s += 10*$1;
    }
    if(m/(\d)\D*$/) {
        $s += $1;
    }
}
print "$s\n";
