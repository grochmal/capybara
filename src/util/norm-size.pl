#!/usr/bin/env perl

use strict;
use warnings;

my $usage = "Usage: $0 <width>x<height> <normalise_to>\n";
sub ex ($$) { print (shift); exit (shift); }
ex $usage, 1 unless 2 == scalar @ARGV;
my ($w,$h) = split 'x', $ARGV[0];
my $factor = sqrt $ARGV[1]/($h*$w);
my ($neww,$newh) = map { int($_ * $factor + 0.5) } ($w,$h);
print "${neww}x${newh}\n";

