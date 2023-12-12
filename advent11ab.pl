#!/usr/bin/perl

my @g; # "g" for "galaxies"
my %c; # "c" for "columns with galaxies
my ($r, $n) = (-1, 0); # "r" for "row", "n" for "number of columns"
my $e = 999_999; # "e" for expansion, replace with  1 for part 1

while(<>) {
    $r++;
    !$n && /(.*)/ and $n = length($1);
    !/#/ and $r += $e;
    my $l = 0; # "l" for "last horizontal postion of a galaxy"
    while(s/^(\.*)#//) {
        push(@g, [ $r, $l += length($1) ]);
        $c{$l++} = 1;
    }
}

for my $i ( sort { $b <=> $a } map { $c{$_} ? () : $_ } 0 .. $n-1 ) {
    $_->[1] > $i and $_->[1] += $e for @g;
}
my $s = 0; # "s" for "sum of distances
for my $i (0 .. @g - 2) {
    $s += abs($g[$i]->[0] - $g[$_]->[0]) + abs($g[$i]->[1] - $g[$_]->[1]) for $i+1 .. @g-1
}
print $s;
