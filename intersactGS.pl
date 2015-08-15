#! usr/bin/perl
#use strict;
#Zhuofei Xu, April 7, 2015
die "Usage: $0 enriched-gs.tab viral-DE-PPI-human-GS-1.tab  viral-DE-PPI-human-GS-2.tab" unless (@ARGV == 3);

open(LIST,$ARGV[0])or die "cannot open $ARGV[0]\n";
open(GENE,$ARGV[1])or die "cannot open $ARGV[0]\n";
open(OUT, ">$ARGV[2]") || die "can't open file\n";
binmode(OUT);
my %hash = ();

while(<LIST>){                               #each line contains only one word
	chomp;
	if (/^(.*?)\t(.*)$/){
	 $hash{$1} = $_;
	}
}
close LIST;


my $dumpline = <GENE>;
chomp $dumpline;
print OUT "$dumpline\tGeneset_ID\tDescription\tp.Val\tFDR\tPhenotype\n";

while(<GENE>){
   chomp;
   if(/^.*\t(.*)$/){
     my $name = $1;
	 if(exists $hash{$name}){
		print OUT "$_\t$hash{$name}\n";
		}else{
		#print OUT "$_\t-\t-\t-\t-\t-\n";
		}
	}
}
close (GENE);
