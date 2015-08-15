#! usr/bin/perl
#use strict;
#Zhuofei Xu, Aug 8, 2015
die "Usage: $0 gene-info.txt > results.tab" unless (@ARGV == 1);

open(LIST,$ARGV[0])or die "cannot open $ARGV[0]\n";

my %hash = ();
my %vash = ();
my %viralhash = ();
#ViralGeneSymbol	ViralGeneProduct	RefSeq_ID	baseMean	log2FoldChange	lfcSE	stat	pvalue	padj	Viral_Gene_Symbol	Virus RefSeqID	Host UniprotID	Detection Method	Interaction Type	Source Database	Uniprot ID	Entrez ID	ENTREZID	SYMBOL	GENENAME	ENTREZID	Gene-set_ID	Geneset_ID	Description	p.Val	FDR	Phenotype

my $dumpline = <LIST>;
chomp $dumpline;
print "Gene-set_ID\tDescription\tp-value\tq-value\tPhenotype\tProtein receptors in host\tViral DEGs\n";

while(<LIST>){                              
	chomp;
	if (/^(\S+)\t(.*)\t(.*?)\t(.*?)\t(.*?)\t(.*?)\t(.*?)\t(.*?)\t(.*?)\t(.*?)\t(.*)$/){
	 #warn "$1\t$3\t$11\t";
	my $viralsymbol = $1;
	my $hostsymbol = $3;
	my $gsid = $7;
	my $gsdesc = $8;
	my $pvalue = $9;
	my $qvalue = $10;
	my $pheno = $11;
	$hash{$gsid}{$hostsymbol} = 1;
	$viralhash{$gsid}{$viralsymbol} = 1;
	$vash{$gsid} = "$gsdesc\t$pvalue\t$qvalue\t$pheno";
	}
}
close LIST;


for my $ele (sort keys %hash){
    my @arrayhost = ();
	my @arrayviral = ();
     print "$ele\t$vash{$ele}\t";
	 for my $role (sort keys %{$hash{$ele}}){
	   push @arrayhost, $role;
	   }
	 for my $tag (sort keys %{$viralhash{$ele}}){
	  push @arrayviral, $tag;
	  }
	  print join(", ", @arrayhost), "\t", join(", ", @arrayviral), "\n";
}

