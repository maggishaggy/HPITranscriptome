#! /usr/bin/perl -w
use strict;
#Zhuofei Xu, Aug 8, 2015
die "Usage: $0 human-expressedGene.txt HPIs.addGeneSymbol.txt > hpi-expressedGene.txt" unless (@ARGV == 2);
open(IN,"$ARGV[0]")|| die "can't open file:$!\n";
open(LIST,"$ARGV[1]")|| die "can't open file:$!\n";

my %hash = ();


while(<IN>){
  chomp;
  if(/^(\S+)/){
   my $flag = $1;
   $hash{$flag} = $flag;
	 }
	}
close IN;

my $dumpline = <LIST>;
print "$dumpline";

while(<LIST>){
  chomp;
  if(/\s+(\S+)$/){
   if(exists $hash{$1}){
     print "$_\n";
	 }
	 }
}
close LIST;