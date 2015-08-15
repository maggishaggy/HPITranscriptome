#! /usr/bin/perl -w
use strict;
# Zhuofei Xu, Aug 7, 2015
die "Usage: perl bioDBnet_db2db_output.txt parsedHPIs.txt > parsedHPIs-EntrezID" unless (@ARGV == 2);

open (DATA, $ARGV[0])||die "Can't open file $ARGV[0]:$!\n";
open (FILE, $ARGV[1])||die "Can't open file $ARGV[1]:$!\n";

my %hash = ();

while (<DATA>){
	chomp;
	$_ =~ s/\s+$//g;
	if (/^(\S+)\s+(.*)$/){
	my $geneid = $1;
	my $entrezid = $2;
	if($entrezid eq '-'){
	  next;
	  }else{
	$entrezid =~ s/\s+//g;
	my @arr = split(/;/, $entrezid);
	#warn "@arr\n";
	@{$hash{$geneid}} = @arr;
	}
	}
}
close (DATA);

my $dumpline = <FILE>;
chomp $dumpline;
print "$dumpline\tUniprot ID\tEntrez ID\n";

while (<FILE>){
	chomp;
	if(/^\S+\s+(\S+)\s+/){
	  my $uniprot = $1;
	 if(exists $hash{$uniprot}){
	   for my $i (0..$#{$hash{$uniprot}}){ 
	    print "$_\t$uniprot\t$hash{$uniprot}[$i]\n";
		}
		}else{
		warn "Warning! No Entrez gene ID is corresponding to $uniprot\n";
		}
	}
}
close (FILE);