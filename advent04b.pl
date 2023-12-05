#!/usr/bin/perl

my @sets;

while(<>) {
    s/Card \d+://; 
    my ($w, $h) = split /\|\s*/;
    my $n = map { $w =~ / $_ / ? 1 : () } grep {/^\d+$/} split /\s+/,$h;
    push(@sets, $n);
}

@sets = reverse @sets;

for(my $i = 0; $i < @sets; $i++) {
    my $s = 0;
    $s += $sets[$_] for $i - $sets[$i] .. $i;
    $sets[$i] = $s;
}

my $s = @sets;
$s += $_ for @sets;
print $s;
