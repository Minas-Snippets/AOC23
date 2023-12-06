#!/usr/bin/perl

my @t; # times
my @r; # records

@t ? @r : @t = grep {/^\d+$/} split /\s+/ while <>;

my $p = 1;
$p *= $_ - 2*int($_/2 - sqrt($_*$_/4 - shift(@r)) + 1) + 1 for @t;    
print $p
