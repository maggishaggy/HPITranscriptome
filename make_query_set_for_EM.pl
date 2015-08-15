#! /usr/bin/perl -w
use strict;
#Zhuofei Xu, Aug 11, 2015
die "Usage: $0 HPIs.addEntrezID.txt > interaction-query-set.gmt" unless (@ARGV == 1);
open(IN, "$ARGV[0]")|| die "can't open file:$!\n";

my $dumpline = <IN>;

print "signatureGS1\tHostGeneInteractedWithVirusGene";

my %hash = ();

while(<IN>){
  chomp;
  if(/\s+(\d+)$/){
    $hash{$1} = 1;
	}
}
close IN;

for my $ele (sort keys %hash){
   print "\t$ele";
  }
print "\n";
