#!/usr/bin/perl

my @s;  # seeds
our @m; # mappings
while(<>) { 
    if(s/^seeds: //) {
        # seeds come in pairs (first, length)
        # we store [ first, last ] think of intervals
        push(@s,[$1,$1+$2-1]) while s/^\s*(\d+)\s+(\d+)//;
        next;
    }
    if(m/map:$/) {
        @s = map{ ma(@$_) } @s;
        @m = ();
        next        
    }
    m/(\d+)\s+(\d+)\s+(\d+)/ and push(@m, [$2, $2 + $3 - 1, $1-$2 ]);
    # we store the mappings as
    # [ first, last, offset ]
}

@s = map{ ma(@$_) } @s;

my $min = $s[0]->[0];
$min = $_->[0] < $min ? $_->[0] : $min for @s;

print $min;

sub ma { # ma stands for "mapping apply"
    my ($a,$b) = @_; # (a,b) is the seed intervall 
    for (@m) {
        my ($f, $l, $o) = @$_; # (f,l,o) are first, last, offset in a mapping
        next if $b < $f || $l < $a;
        return 
            $a >= $f && $b <= $l ? [ $a + $o, $b + $o ] :
                $a < $f ?
            ( ma($a,$f - 1), [ $f + $o, ($b > $l ? $l : $b) + $o ], $b > $l ? () : ma($l, $b) ) :
            ( [$a + $o, $l + $o], ma($l + 1, $b ) )
    }
    return [ $a,$b ]
}
