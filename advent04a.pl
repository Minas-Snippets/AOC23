#!/usr/bin/perl

my $p = 0; 

while(<>) { 
    my ($w, $h) = split /\|\s*/;
    $p += 1 << ( map { $w =~ / $_ / ? 1 : () } 
        grep {/^\d+$/} split /\s+/,$h ) - 1;
}
print $p 
