#!/usr/bin/perl

use 5.34.0;

# Part 2

my  @s; # symbols (only stars)
our @n; # numbers

my $y = 0;
while(<>) {
    s/\./ /g;
    while(m/^(\D*)(\d+)/) {
        my ($x,$n,$l) = (length($1), $2, length($2));
        push(@n,[$n,$x,$y,$l]);
        substr($_,$x,$l) = ' ' x $l;
    }
    while(s/^([^\*]*)\*/$1 /) {
        push(@s,[ length($1), $y]);
    }
    $y++;
}
my $s = 0;
$s += near_numbers(@$_) for @s;

say $s;

sub near {
    my ($symX,$symY,$numX,$numY,$len) = @_;
    return abs($symY - $numY) > 1 || $numX - $symX > 1 || $symX - $numX - $len > 0 ? 0 : 1
}

sub near_numbers {
    my @m = map{ near($_[0],$_[1],(@$_)[1,2,3]) ? $_->[0] : () } @n;
    return @m == 2 ? $m[0] * $m[1] : 0
}
