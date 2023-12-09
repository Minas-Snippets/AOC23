#!/usr/bin/perl

my $p = 0;
$p += p(grep /\d+/, split /\s+/) for <>;

print $p;


sub p {
    my @stack = ( [ @_ ] );
    push(@stack, [ diffs( @{$stack[-1]}) ]) while unequal(@{$stack[-1]});
    my $last = $stack[-1]->[-1];
    push(@{$stack[-1]},$last);
    while(@stack > 1) {
        my @last = @{ pop(@stack) };
        
        my $prev = $stack[-1];
        my @prev = ( $prev->[0] );
        push(@prev, $prev[-1] + shift(@last)) while @last;
        @{$stack[-1]} = @prev;
    }
    return $stack[0]->[-1]
}

sub unequal {
    my $last   = shift;
    $last != shift and return 1 while @_;
    return 0
}

sub diffs {
    return map { $_[$_+1] - $_[$_] } 0..@_-2
}
