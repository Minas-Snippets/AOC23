#!/usr/bin/perl

our @directions;
our %nodes;

while(<>) {
    chomp;
    m/(\w+)\W+(\w+)\W+(\w+)/ and $nodes{$1} = [$2,$3]; # [ left node, right node ]
    m/^\w+$/ and @directions = map { $_ eq 'L' ? 0 : 1 } ( split '' );
}

my @a = grep {/..A/} keys %nodes;

our $l = @directions;

my $p = $l;

$p *= steps($_)/$l for @a;

print $p;

sub steps {
    my ($x,$n) = (shift, 0);
    while($x !~ /..Z/) {
        $x = $nodes{$x}->[ $directions[$n % $l] ];
        $n++;
    }
    return $n
}
