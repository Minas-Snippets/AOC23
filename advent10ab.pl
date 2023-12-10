#!/usr/bin/perl

# This does both parts of the puzzle

my %d = ('|'=> 9,'-'=> 6,'L'=> 5,'J'=> 3,'7'=> 10,'F'=> 12,'.'=> 0,'S'=> 0);
        
my (@s, @m, @r, @path);

while(<>) {
    chomp;
    push(@m, [ 0, ( map { $d{$_} } split '' ) , 0 ] );
    m/^(.*)S/ and @s = ( scalar(@m) , length($1) + 1 );
}

unshift( @m, [ ( 0 ) x @{$m[0]} ] );
push( @m, [ ( 0 ) x @{$m[0]} ] );

for (@m) {
    push(@r,    [ ( 0 ) x @{$m[0]} ] );
    push(@path, [ ( 0 ) x @{$m[0]} ] );
}

my $s = 0;

$m[ $s[0] - 1 ]->[ $s[1]     ] & 8 and $s += 1;
$m[ $s[0] + 1 ]->[ $s[1]     ] & 1 and $s += 8;
$m[ $s[0]     ]->[ $s[1] - 1 ] & 4 and $s += 2;
$m[ $s[0]     ]->[ $s[1] + 1 ] & 2 and $s += 4;

# print "S is of type $s\n";
$m[$s[0]]->[$s[1]]    = $s;
$path[$s[0]]->[$s[1]] = $s;
my @p = @s;
my $p = $m[$p[0]]->[$p[1]];

my @f;
@f =  $p & 1 ? ( $p[0] - 1, $p[1] ) : 
    ( $p & 2 ? ( $p[0], $p[1] + 1 ) : ( $p[0] + 1, $p[1] ) );
my $f = $m[ $f[0] ]->[ $f[1] ];

$path[$f[0]]->[$f[1]] = $f;
$f -= $p & 1 ? 8 : ( $p & 2 ? 4 : 1 );
my $n = 1;

while($f[0] != $s[0] || $f[1] != $s[1]) {
    @f = ( $f[0] - ( $f & 1 ) + ( $f & 8 ? 1 : 0 ), $f[1] - ( $f & 2 ? 1 : 0 ) + ( $f & 4 ? 1 : 0 ) );
    $p = $m[$f[0]]->[$f[1]];
    $path[ $f[0] ]->[ $f[1] ] = $p;
    $f = $p - ( $f & 1 ? 8 :
        ( $f & 2 ? 4 : ( $f & 4 ? 2 : 1 ) ) );
    $n++;
}

print $n/2 . " is the furthest distance.\n";

$n = 0;

($r[0]->[$_], $r[@m -1]->[$_], $r[$_]->[@m-1], $r[$_]->[0]) = ( 511 ) x 4 for 0 .. @m-1;

my ($top, $bottom, $left, $right) = map { bitsum(@$_) } ( [0,1,2], [6,7,8], [0,3,6], [2,5,8] );
my ($void, $nw, $ne, $ew, $ns, $sw, $se) = (0,3,5,6,9,10,12);

my $found = 1;
while($found) {
    $found = 0;
    for my $y (0 .. @m -1) {
        for my $x ( 0 .. @{$m[0]} ) {
            my $z = $r[$y]->[$x];
            $z or next;
            if($y > 0) {
                my $test = \${r[$y-1]->[$x]};
                unless($$test) {
                    my $mask = $top & $z;
                    if($mask) {
                        my $pipe = $path[$y-1]->[$x];
                        $found++;
                        $pipe == 0 and $$test = 511;
                        $pipe == 3 and $$test = bitsum(2,5,6,7,8);
                        $pipe == 5 and $$test = bitsum(0,3,6,7,8);
                        $pipe == 6 and $$test = bitsum(6,7,8);
                        $pipe == 9 and $$test = $mask == 1 ? bitsum(0,3,6) : bitsum(2,5,8);
                        $pipe == 10 and $$test = $mask == 1 ? bitsum(6) : bitsum(0,1,2,5,8);
                        $pipe == 12 and $$test = $mask == 1 ? bitsum(0,1,2,3,6) : bitsum(8);
                    }
                }
            }
            if($x < @{$m[0]}-1) {
                my $test = \${r[$y]->[$x+1]};
                unless($$test) {
                    my $mask = $right & $z;
                    if($mask) {
                        my $pipe = $path[$y]->[$x+1];
                        $found++;
                        $pipe == 0 and $$test = 511;
                        $pipe == 3 and $$test = $mask == 4 ? bitsum(0) : bitsum(2,5,6,7,8);
                        $pipe == 5 and $$test = bitsum(0,3,6,7,8);
                        $pipe == 6 and $$test = $mask == 4 ? bitsum(0,1,2) : bitsum(6,7,8); 
                        $pipe == 9 and $$test = bitsum(0,3,6);
                        $pipe == 10 and $$test = $mask == 4 ? bitsum(0,1,2,5,8) : bitsum(6);
                        $pipe == 12 and $$test = bitsum(0,1,2,3,6);
                    }
                }
            }
            if($y < @m-1) {
                my $test = \${r[$y+1]->[$x]};
                unless($$test) {
                    my $mask = $bottom & $z;
                    if($mask) {
                        my $pipe = $path[$y+1]->[$x];
                        $found++;
                        $pipe == 0 and $$test = 511;
                        $pipe == 3 and $$test = $mask == 64 ? bitsum(0) : bitsum(2,5,6,7,8);
                        $pipe == 5 and $$test = $mask == 64 ? bitsum(0,3,6,7,8) : bitsum(2);
                        $pipe == 6 and $$test = bitsum(0,1,2);
                        $pipe == 9 and $$test = $mask == 64 ? bitsum(0,3,6) : bitsum(2,5,8);
                        $pipe == 10 and $$test = bitsum(0,1,2,5,8);
                        $pipe == 12 and $$test = bitsum(0,1,2,3,6);
                    }
                }
            }
            if($x > 0) {
                my $test = \${r[$y]->[$x-1]};
                unless($$test) {
                    my $mask = $left & $z;
                    if($mask) {
                        my $pipe = $path[$y]->[$x-1];
                        $found++;
                        $pipe == 0 and $$test = 511;
                        $pipe == 3 and $$test = bitsum(2,5,6,7,8);
                        $pipe == 5 and $$test = $mask == 1 ? bitsum(2) : bitsum(0,3,6,7,8);
                        $pipe == 6 and $$test = $mask == 1 ? bitsum(0,1,2) : bitsum(6,7,8); 
                        $pipe == 9 and $$test = bitsum(2,5,8);
                        $pipe == 10 and $$test = bitsum(0,1,2,5,8);
                        $pipe == 12 and $$test = $mask == 1 ? bitsum(0,1,2,3,6) : bitsum(8);
                    }
                }
            }
        }
    }
}

$n = 0;

for my $y (0 .. @m-1) {
    $n += ( $r[$y]->[$_] || $path[$y]->[$_] ? 0 : 1 ) for 0 .. @{$m[0]}-1 
}

print "\narea enclosed: $n\n";

sub bitsum {
    my $s = 0;
    $s += 1 << $_ for @_;
    return $s;
}
