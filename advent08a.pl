#!/usr/bin/perl

my @l;
my %h;

while(<>) {
    chomp;
    m/(\w+)\W+(\w+)\W+(\w+)/ and $h{$1} = [$2,$3];
    m/^\w+$/ and @l = split '';
}

my $n = 0;

my $f = 'AAA';
while($f ne 'ZZZ') {
    $n++;
#    print "$n $f
    my $i = shift(@l);
    push(@l,$i);
    $f = $h{$f}->[ $i eq 'L' ? 0 : 1 ];
}
print $n;
