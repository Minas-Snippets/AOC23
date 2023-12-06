#!/usr/bin/perl

my  @s; # seeds
our @m; # map
while(<>) { 
    if(s/^seeds: //) {
        @s = grep {/^\d+$/} split /\s+/;
        next;
    }
    if(m/map:$/) {
        @s = map{ma($_)} @s;
        @m = ();
        next
    }
    m/(\d+)\s+(\d+)\s+(\d+)/ and push(@m, [$2, $2 + $3, $1-$2 ]); 
    # structure in map is "first, last, offset
}

@s = map{ma($_)} @s;
my $min = shift(@s);
$min = $_ < $min ? $_ : $min for @s;

print $min;

sub ma { # "ma stands for 'map apply'
    my $n = shift;
    for(@m) {
        $n >= $_->[0] && $n <= $_->[1] or next;
        return $n + $_->[2]
    }
    return $n
}
