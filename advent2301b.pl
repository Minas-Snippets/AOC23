#!/usr/bin/perl

use 5.34.0;

my $s = 0;
while(<>) {
    chomp;
    s/twone/twoone/g;
    s/eightwo/eighttwo/g;
    s/eighthree/eightthree/g;
    s/oneight/oneeight/g;
    s/nineight/nineeight/g;
    s/sevenine/sevennine/g;

    s/one/1/g;
    s/two/2/g;
    s/three/3/g;
    s/four/4/g;
    s/five/5/g;
    s/six/6/g;
    s/seven/7/g;
    s/eight/8/g;
    s/nine/9/g;
    if(m/^\D*(\d)/) {
        $s += 10*$1;
    }
    if(m/(\d)\D*$/) {
        $s += $1;
    }
}
say $s
