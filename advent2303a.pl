#!/usr/bin/perl

use 5.34.0;

# Part 1

our @s; # symbols
my  @n; # numbers

my $y = 0;
while(<>) {
    s/\./ /g;
    while(m/^(\D*)(\d+)/) {
        my ($x,$n,$l) = (length($1), $2, length($2));
        push(@n,[$n,$x,$y,$l]);
        substr($_,$x,$l) = ' ' x $l;
    }
    while(s/^(\s*)\S/$1 /) {
        push(@s,[ length($1), $y])
    }
    $y++;
}
my $s = 0;
for( @n ) {
    $s += has_near($_);
}
say $s;

sub near {
    my ($symX,$symY,$numX,$numY,$len) = @_;
    return abs($symY - $numY) > 1 || $numX - $symX > 1 || $symX - $numX - $len > 0 ? 0 : 1
}

sub has_near {
    my ($n,$x,$y,$l) = @{$_[0]};
    for(@s) {
        near($_->[0],$_->[1],$x,$y,$l) and return $n
    }
    return 0
}
