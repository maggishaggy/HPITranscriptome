#! /usr/bin/perl -w
use strict;
#Zhuofei Xu, March 5, 2015
die "Usage: $0 vacv.gff chromsomeName > genesModel.bed" unless (@ARGV == 2);

open(IN,"$ARGV[0]")|| die "can't open file:$!\n";
my $chrname = $ARGV[1];

#NC_006998.1	RefSeq	CDS	5578	5724	.	-	0	ID=cds4;Parent=gene4;Dbxref=Genbank:YP_232887.1;Name=YP_232887.1;Note=similar to 259aa VACCP-C19L/B25R;gbkey=CDS;product=ankyrin-like protein;protein_id=YP_232887.1
my $count = 0;

while(<IN>){
  chomp;
  if(/^#/){
   print "$_\n";
   }elsif(/^(\S+)\s+(.*)$/){
	 print "$chrname\t$2\n";
	 }
}
close IN;
