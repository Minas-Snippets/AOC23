#!/usr/bin/perl

my @b;
push(@b, []) for 0 .. 255;

my $s = <STDIN>;
while($s =~ s/^([^,]+),?//) {
    $1 =~ /^(.+)([=-])(.*)/;
    my ($label, $action,$focal) = ($1, $2, $3);
    my $box = ha($label);
    my $i = f($b[$box], $label);
    if($action eq '=') {
        if ($i < 0) {
            push(@{$b[$box]},[$label,$focal]);
            next
        }
        $b[$box]->[$i] = [$label,$focal];
        next
    }
    $i < 0 or splice(@{$b[$box]},$i,1);
}

my $sum = 0;
for my $i (0 .. 255) {
    next unless @{$b[$i]};
    $sum += ($i+1)*($_+1)*$b[$i]->[$_]->[1] for 0 .. @{$b[$i]} -1
}
print $sum;

sub ha {
    my ($v, $c, $label) = (0, '', $_[0]);

    while($label =~ s/^(.)//) {
        $c = $1;
        $v += ord($c);
        $v *= 17;
        $v = $v % 256;
    }
    return $v
}

sub f {
    my ($b, $label) = @_;
    for(0 .. @{$b}-1) {
        $b->[$_]->[0] eq $label and return $_
    }
    return -1;
}

