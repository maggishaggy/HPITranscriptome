#! /usr/bin/perl -w
use strict;
#Zhuofei Xu, Aug 4, 2015
die "Usage: $0 vacv.gff > genes-ID.tab" unless (@ARGV == 1);

open(IN,"$ARGV[0]")|| die "can't open file:$!\n";
my $chrname = $ARGV[1];

#NC_006998.1	RefSeq	gene	4919	5137	.	+	.	ID=gene2;Dbxref=GeneID:3707618;Name=VACWR003;gbkey=Gene;locus_tag=VACWR003
#NC_006998.1	RefSeq	CDS	5578	5724	.	-	0	ID=cds4;Parent=gene4;Dbxref=Genbank:YP_232887.1;Name=YP_232887.1;Note=similar to 259aa VACCP-C19L/B25R;gbkey=CDS;product=ankyrin-like protein;protein_id=YP_232887.1

print "GeneID\tSymbol\tCDSID\tRefseqID\tViral_Gene_Product\n";

while(<IN>){
  chomp;
  if(/^\S+\s+\S+\s+gene/){
    if(/\s+ID=(.*?);/){
	  print "$1\t";
	  }
	if(/;Name=(.*?);/){
	  print "$1\t";
	  }
   }
   if(/^\S+\s+\S+\s+CDS/){
        if(/\s+ID=(.*?);/){
	  print "$1\t";
	  }
	if(/;Name=(.*?);/){
	  print "$1\t";
	  }
	if(/;product=(.*?);/){
	  print "$1\n";
	  }
   }
}
close IN;
