#!/usr/bin/perl

my @hands;

our $strength_order = 'J23456789TQKA';

# read the input (data file is command line parameter)
# We store the data in an array of tupels ( numerical strength value and bid)

m/(\S+)\s+(\d+)/ and push(@hands,[hand_strength($1),$2]) while <>;

@hands = sort { $a->[0] <=> $b->[0] } @hands;

my $sum = 0;
$sum += $_ * $hands[$_ - 1]->[1] for 1 .. @hands;
print $sum;

# End of program

# Beginning of subroutines

sub card_strength {

# assign a numerical value to each card 

    my $card = shift;
    $strength_order =~ /^([^$card]*?)$card/ and return length($1)
}

sub get_type {

# assign a numerical value to each type of hand
# 5 equals: 6 
# 4 equals: 5
# Full House: 4
# 3 equals: 3
# 2 pairs: 2
# 1 pair: 1
# nothing: 0

# max is the highest number for any card
# n is number of different cards we have

    my @hand = split('',shift);
    my $max  = 0;
    my %hand;
    for(@hand) {
        $hand{$_} = exists($hand{$_}) ? $hand{$_} + 1 : 1;
        $hand{$_} > $max and $max = $hand{$_};
    }
    my $n = ( keys(%hand) );
    
# When calculating the strength we still have to 
# account for Jokers $hand{J}

    $max == 5 and return 6;
    $max == 4 and return exists($hand{J}) ? 6 : 5;
    if($max == 3) {
        exists($hand{J}) or return ($n == 2 ? 4 : 3);
        $hand{J} == 1 and return 5;
        $hand{J} == 2 and return 6;
        $hand{J} == 3 and return 8 - $n;
    }
    if($max == 2) {
        exists($hand{J}) or return ($n == 3 ? 2 : 1);
        $hand{J} == 2 and return $n == 3 ? 5 : 3;
        return 7 - $n;
    }
    return exists($hand{J}) ? 1 : 0;
}

sub hand_strength {

# we have six types of strengths:
# the type, and the 5 cards
# For both categories we have 13 resp. 7 
# possible values. We assign 4 bits (total 24) 
# to each type of strength and store everything 
# in a single number.
# Leading bits are the one more relevant

    my $hand = shift;
    my $type_strength = 0;
    my @hand = split('',shift);
    my $mult = 1;
    my $strength = 0;
    for( reverse(split('',$hand)) ) {
        $strength += $mult * card_strength($_);
        $mult *= 16;
    }
    return $strength += $mult * get_type($hand); 
}
