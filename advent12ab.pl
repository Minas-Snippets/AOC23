#!/usr/bin/perl

our %ac;

my %f = ( '.' => 1, '#' => 2, '?' => 3 );
my $s = 0;

while(<>) {
    my ($f, $n) = split /\s+/;
    # for part 1 comment the following line
    $f = join('?', ( $f ) x 5 );
    $f =~ s/^\.*//;
    $f =~ s/\.*$//;
    $f =~ s/\.\.+/./g;
    # for part 1 comment the following line
    $n = join(',', ( $n ) x 5 );
    my @b = split(',',$n);
    $s += ac( [ map { $f{$_} } split '', $f ], split(',',$n) );
}
print $s;


sub ac {
    my $sum = 0;
    my ($f, @n ) = @_;
    exists($ac{ join('', @$f) }->{ join(',',@n ) } ) and return $ac{ join('', @$f) }->{ join(',',@n ) };
    return match( $f, ( 1 ) x @$f ) ? 1 : 0 unless @n;
    my $s = sum(@n) + ( @n ? @n - 1 : 0 );
    my $n = shift(@n);
    my @b = ( ( 2 ) x $n , 1 );
    @n or pop(@b);
    my $l = @$f - $s;
    for ( 0 .. $l ) {
        $_ > 0 && $f->[$_ - 1] == 2 and last;
        if(match($f, @b)) {
            my $acr = ac([ @$f[ @b .. @$f - 1 ] ], @n);
            $sum += $acr;
            my ($x, $y) = ( join('', @$f[ @b .. @$f - 1 ]), join(',',@n) );
            exists($ac{$x}->{$y}) or $ac{$x}->{$y} = $acr
        }
        unshift( @b, 1 );
    }
    return $sum
}

sub match {
    $_[0]->[$_-1] & $_[$_] or return for 1 .. @_-1;
    return 1;
}

sub sum {
    my $s = 0;
    $s += $_ for @_;
    return $s
}
