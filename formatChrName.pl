#! user/bin/perl -w
use strict;
#Zhuofei Xu, July 30, 2015
die "Usage:  $0 old.fa new.fa \n" if(@ARGV != 2);

open (IN, "$ARGV[0]")||die "Can't open file: $!";
open (OUT, ">$ARGV[1]")||die "Can't open file: $!";

while (<IN>){
	chomp;
	if (/^>(.*)/){
		print OUT ">chr$1\n";
		
	}
	else {
	print OUT "$_\n";
	}
}
close (IN);
