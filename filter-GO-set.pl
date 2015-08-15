#! usr/bin/perl -w
# Zhuofei Xu, 2015 March 19
use strict;
die "Usage: perl $0 Human_GO_AllPathways_no_GO_iea_February_24_2015_entrezgene.gmt" unless (@ARGV == 1);
open(LIST,$ARGV[0])or die "cannot open $ARGV[0]\n";
open(OUT,">filtered-pathway-all.gmt") || die "can't open file\n";
binmode(OUT);

my $name = '';
my $count = 0;
my $desc = '';

while(<LIST>){
	chomp;
	my @array = split(/\t/,$_);
	$name = shift @array;
	$desc = shift @array;
	$count = scalar @array;
	unless( ($count > 500) || ($count < 5)){                       
		print OUT "$_\n";
			}
}
close LIST;