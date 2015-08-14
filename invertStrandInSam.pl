#! usr/bin/perl -w
# Zhuofei Xu, 2015 Aug 4
use strict;
die "Usage: perl $0 sam > invertStand.sam" unless (@ARGV == 1);
open(LIST,$ARGV[0])or die "cannot open $ARGV[0]\n";


while(<LIST>){
	chomp;
	if(/^@/){
	 print "$_\n";
	 }elsif(/^(\S+)\s+16\s+(.*)$/){
	   print "$1\t0\t$2\n";
	 }elsif(/^(\S+)\s+0\s+(.*)$/){
	   print "$1\t16\t$2\n";
	 }
}
close LIST;