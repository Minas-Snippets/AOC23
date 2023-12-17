#!/usr/bin/perl

my ($v, $c) = (0, '');
my @a;

my $s = <STDIN>;
my $sum = 0;

while($s =~ s/^(.)//) {
    $c = $1;
    if($c eq ',') {
        $sum += $v;
        $v = 0;
        next;
    }
    $v += ord($c);
    $v *= 17;
    $v = $v % 256;
}
print $v + $sum;
