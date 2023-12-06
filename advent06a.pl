#!/usr/bin/perl

my @t; # times
my @r; # records
while(<>) { 
    @t ? @r : @t = grep {/^\d+$/} split /\s+/
}

my $p = 1;
for(@t) {
    my $r = sqrt($_*$_/4 - shift(@r));
    my ($x1, $x2) = ($_/2 - $r, $_/2 + $r);
    $x1 = int($x1 + 1);
    $x2 = $x2 == int($x2) ? int($x2 - 1) : int($x2);
    $p *= ($x2 - $x1 + 1);
    
}
print $p;
