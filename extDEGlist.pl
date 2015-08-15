#! usr/bin/perl -w
# Zhuofei Xu, 2015 Aug 4
use strict;
die "Usage: perl $0 deseq-output-symbol.txt > viralDEG.list" unless (@ARGV == 1);
open(LIST,$ARGV[0])or die "cannot open $ARGV[0]\n";

my $name = '';
my $fc = 0;
my $pvalue = 0;
my $qvalue = 0;

#geneSymbol	RefSeq_ID	baseMean	log2FoldChange	lfcSE	stat	pvalue	padj

my $dumpline = <LIST>;

while(<LIST>){
	chomp;
	if(/^\S+\s+(\S+)\s+\S+\s+(\S+)\s+\S+\s+\S+\s+\S+\s+(\S+)/){
	 $name = $1;
	 $fc = $2;
	 $fc = abs $fc;
	 $qvalue = $3;
	 if(($fc >= 1) && ($qvalue < 0.1)){
	   print "$name\n";
	 }
	 }
}
close LIST;