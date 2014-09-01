#!/usr/bin/env perl

use strict;
use warnings;

my %school = ( renaissance   => 1
             , baroque       => 2
             , neoclassicism => 3
             , romanticism   => 4
             , impressionism => 5
             , mughal        => 6
             , watercolour   => 7
             );
my %rschool = reverse %school;
my %artist = ( bassano    => 1
             , botticelli => 2
             , raphael    => 3
             , titian     => 4
             , veronese   => 5
             , berchem     => 10
             , caravaggio  => 11
             , cuyp        => 12
             , dujardin    => 13
             , greco       => 14
             , hondecoeter => 15
             , miereveld   => 16
             , molenaer    => 17
             , monnoyer    => 18
             , murillo     => 19
             , poussin     => 20
             , rebecca     => 21
             , rembrandt   => 22
             , ribera      => 23
             , ricci       => 24
             , rosa        => 25
             , rubens      => 26
             , teniers     => 27
             , velazquez   => 28
             , wouwerman   => 29
             , canaletto   => 40
             , carlevariis => 41
             , dughet      => 42
             , kauffmann   => 43
             , panini      => 44
             , zoffany     => 45
             , boudin       => 50
             , constable    => 51
             , daubigny     => 52
             , delacroix    => 53
             , diaz         => 54
             , gainsborough => 55
             , goya         => 56
             , latour       => 57
             , leslie       => 58
             , loutherbourg => 59
             , mulready     => 60
             , rousseau     => 61
             , watts        => 62
             , gauguin    => 70
             , monticelli => 71
             , pissarro   => 72
             , basawan => 80
             , jagan   => 81
             , kesav   => 82
             , lal     => 83
             , miskin  => 84
             , tulsi   => 85
             , carpenter => 90
             , tagore    => 92
             , devi => 99
             );
my %rartist = reverse %artist;

my %ignore = ( watercolour => 1 , mughal => 1, na => 1 );

my $opts = { artist => { enc => \%artist , dec => \%rartist }
           , school => { enc => \%school , dec => \%rschool }
           };
my $acts =
    { enc    => sub ($$) {
                    $_ = shift;
                    my $n = shift;
                    s/^/$n:/;
                    $_;
                }
    , dec    => sub ($) {
                    $_ = shift;
                    s/^\d+://;
                    $_;
                    }
    };

my $usage  = "Usage: $0 <artist|school> <enc|dec>";
die $usage unless 2 == scalar @ARGV;
my $what   = shift;
my $action = shift;
die $usage unless exists $opts->{$what};
die $usage unless exists $acts->{$action};
my $trans  = $opts->{$what}->{$action};
my $feat   = $acts->{$action};
while (<>) {
    chomp;
    my ($key, @features) = split;
    next unless $key;                   # ignore empty lines
    next unless exists $trans->{$key};  # ignore unknown keys
    next if     exists $ignore{$key};   # ignore certain keys
    print $trans->{$key};
    for (my $i = 0; $i < scalar @features; $i++) {
        print ' ', $feat->($features[$i], $i+1);
    }
    print "\n";
}

