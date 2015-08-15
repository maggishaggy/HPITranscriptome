#! /usr/bin/perl -w
use strict;
# Zhuofei Xu, April 7, 2015
die "Usage: perl human-gs-ready.gmt linked-table-2.tab > viral-DE-PPI-human-GS-1.tab" unless (@ARGV == 2);

open (DATA, $ARGV[0])||die "Can't open file $ARGV[0]:$!\n";
open (FILE, $ARGV[1])||die "Can't open file $ARGV[1]:$!\n";

my %hash = ();

#CASPASE CASCADE IN APOPTOSIS	Caspase Cascade in Apoptosis	836	7124	3002	7132	596	6720	5551	581	6709	1073	7150	8795	8567	1677	1676	397	8797	8738	7020	84823	4926	6304	835	58	2620	637	5747	3984	3875	356	4000	598	4001	355	2934	843	330	841	8737	8772	351	839	7186	317	4214	56616	142	840	331	8717	842	8743	55367	7431	54205	207																																																																																																																																																																																																																																																																																																																																																																																																																																																													

while (<DATA>){
	chomp;
	if (/^(.*?)\t(.*?)\t(.*)$/){
	#if (/^(\S+)/){
	my $geneid = $3;
	my $pathwayid = $1;
	my $pathwaydes = $2;
	my @arr = split(/\s+/, $geneid);
	for my $ele (@arr){
		push @{$hash{$ele}}, $pathwayid;
	}
	}
}
close (DATA);

my $dumpline = <FILE>;
chomp $dumpline;
print "$dumpline\tGene-set_ID\n";

while (<FILE>){
	chomp;
	if (/^(.*)\t(.*)$/){
	    my $info = $1;
		my $name = $2;
		if($name eq '-'){
		  print "$_\t-\n";
		}elsif(exists $hash{$name}){
	  for my $i (0..$#{$hash{$name}}){                          
		 print "$info\t$name\t$hash{$name}[$i]\n";
		 	}
		}else{
		print "$info\t$name\t-\n";
	}
	}
}
close (FILE);