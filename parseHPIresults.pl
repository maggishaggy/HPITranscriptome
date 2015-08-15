#! /usr/bin/perl -w
use strict;
#Zhuofei Xu, Aug 7, 2015
die "Usage: $0 pln6ac1438692618_pr_res.tsv > hpiHostUniprotIDbased.list" unless (@ARGV == 1);

open(IN,"$ARGV[0]")|| die "Can't open file:$!\n";

#YP_232883.1	UNIPROT_AC:Q805H7	C23L_VACCW	Vaccinia virus WR	VIRUS	UNIPROT_AC:Q99729	ROAA_HUMAN	Homo sapiens	ANIMAL	pubmed:19637933	psi-mi:MI:0018(two hybrid)	psi-mi:MI:0915(physical association)	VirHostNet

my %hash = ();

my $dumpline = <IN>;
my $pathogen = '';
my $host = '';
my $pathogenid = '';
my $hostid = '';
my $method = '';

while(<IN>){
  chomp;
  if(/^(\S+)\t(.*?)\t(.*?)\t(.*?)\t(.*?)\t(.*?)\t(.*?)\t(.*?)\t(.*?)\t(.*?)\t(.*)$/){
    $pathogenid = $1;
	$pathogen = $4;
	$hostid = $6;
	$host = $8;
	$method = $11;
	$hostid =~ s/.*?://g;
	#warn "$host\n";

  if(($pathogen =~ /vaccinia virus/i) && ($host =~ /homo sapiens/i)){
	   $hash{"$pathogenid\t$hostid"} = $method;
	  }
}
}
close IN;

print "Virus RefSeqID\tHost UniprotID\tDetection Method\tInteraction Type\tSource Database\n";

for my $ele (sort keys %hash){
  print "$ele\t$hash{$ele}\n";
 }
