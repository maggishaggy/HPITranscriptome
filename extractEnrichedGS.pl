#! usr/bin/perl
#use strict;
#Zhuofei Xu, July 23, 2015
die "Usage: $0 human-gs-ready.gmt enriched-up.tab enriched-down.tab results.tab" unless (@ARGV == 4);

open(LIST,$ARGV[0])or die "cannot open $ARGV[0]\n";
open(UP,$ARGV[1])or die "cannot open $ARGV[1]\n";
open(DOWN,$ARGV[2])or die "cannot open $ARGV[2]\n";
open(OUT, ">$ARGV[3]") || die "can't open file\n";
binmode(OUT);
my %hash = ();

while(<LIST>){                               
	chomp;
	if (/^(.*?)\t(.*?)\t/){
	 $hash{$1} = $2;
	}
}
close LIST;

my $name = '';
my $pvalue = 0;
my $qvalue = 0;

my $dumpline = <UP>;
print OUT "Geneset_ID\tDescription\tp.Val\tFDR\tPhenotype\n";
while(<UP>){
   chomp;
   if(/^(.*?)\t(\S+)\t(\S+)\t(\S+)\t(\S+)\t\d+/){
     $name = $1;
	 $pvalue = $4;
	 $qvalue = $5;
	 if(($qvalue < 0.1) && ($qvalue ne "NA")){
	 if(exists $hash{$name}){
		print OUT "$name\t$hash{$name}\t$pvalue\t$qvalue\t\+1\n";
		}else{
		warn "error $name\n";
		}
	}
	}
}
close (UP);

$dumpline = <DOWN>;
while(<DOWN>){
   chomp;
   if(/^(.*?)\t(\S+)\t(\S+)\t(\S+)\t(\S+)\t\d+/){
     $name = $1;
	 $pvalue = $4;
	 $qvalue = $5;
	 #if(($qvalue < 0.0001) && ($qvalue ne "NA")){
	 if(($qvalue < 0.1) && ($qvalue ne "NA")){
	 if(exists $hash{$name}){
		print OUT "$name\t$hash{$name}\t$pvalue\t$qvalue\t-1\n";
		}else{
		warn "error $name\n";
		}
	}
	}
}
close (DOWN);