#!/usr/bin/perl

my $p = 0;
$p += p(grep /\d+/, split /\s+/) for <>;

print $p;


sub p {
    my @s = ( [ reverse(@_) ] );
    push(@s, [ d( @{$s[-1]}) ]) while u(@{$s[-1]});
    push(@{$s[-1]},$s[-1]->[-1]);
    while(@s > 1) {
        my @l = @{ pop(@s) };
        my @p = ( $s[-1]->[0] );
        push(@p, $p[-1] + shift(@l)) while @l;
        @{$s[-1]} = @p;
    }
    return $s[0]->[-1]
}

sub u {
    $_->[-1] != shift and return 1 while @_;
    return 0
}

sub d {
    return map { $_[$_+1] - $_[$_] } 0..@_-2
}
