#! usr/bin/perl -w
# Zhuofei Xu, 2015 March 27
use strict;
die "Usage: perl $0 filtered-pathway-all.gmt filtered-pathway-all.gmt" unless (@ARGV == 2);
open(LIST,$ARGV[0])or die "cannot open $ARGV[0]\n";

open(OUT, ">$ARGV[1]") || die "can't open file\n";
binmode(OUT);

my $name = '';
my $desc = '';
my $info = '';

while(<LIST>){
	chomp;
	$_ =~ s/\s+$//g;
	 if(/^.*%(.*?)\t(.*)$/){
	  $name = $1;
	  $desc = $2;
	 print OUT "$name\t$desc\n";
	 }
}
close LIST;