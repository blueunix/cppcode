#!/usr/bin/env perl

use warnings;
use strict; # comment
print "Hello World \n";

my $s="asdfasdf \nsdfsdg\n";
print $s;
chomp($s);        
warn "string is '$s'";

my $a= 'a'.'bc'."\n";
print $a;


my $str=join(" and ",qw(apple orange china));
print "$str.\n";


my @trees = qw(12 34 56);
unshift(@trees,'78');
warn $trees[0];
foreach my $tree (@trees){
  print "tree is '$tree'\n";
}

