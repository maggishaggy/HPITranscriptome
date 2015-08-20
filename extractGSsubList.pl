#! usr/bin/perl
#use strict;
#Zhuofei Xu, Aug 11, 2015
die "Usage: $0 cluster-33GS-immune-response.list geneset-centric.txt > gene-set-sub.list" unless (@ARGV == 2);

open(LIST,$ARGV[0])or die "cannot open $ARGV[0]\n";
open(GENE,$ARGV[1])or die "cannot open $ARGV[0]\n";

my %hash = ();
my $count = 0;

while(<LIST>){                             
	chomp;
   if(/^(\S+)/){
	 $hash{$1} = 1;
}
}
close LIST;


my $dumpline = <GENE>;
print "$dumpline";

while(<GENE>){
	chomp;
    if(/^(\S+)\s+/){
	 my $gene = uc $1;
	 if(exists $hash{$gene}){
	   print "$_\n";
	   }
	  }
}
close (GENE);
