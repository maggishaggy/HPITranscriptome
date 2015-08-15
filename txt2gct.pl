#! /usr/bin/perl -w
use strict;
#Zhuofei Xu, Aug 7, 2015
die "Usage: $0 vacv.gff > genes-ID.tab" unless (@ARGV == 1);

open(IN,"$ARGV[0]")|| die "Can't open file:$!\n";

##1.2					
#17309	4				
#EntrezID	Description	A2h	A4h	B2h	B4h

my %hash = ();
my $count = 0;
my $number = 0;
my $dumpline = <IN>;

while(<IN>){
  chomp;
  if(/^(\S+)\s+(.*)$/){
    $hash{$1} = $2;
	$number = scalar (split(/\t/, $2));
	$count++;
	  }
	  }
close IN;

print "\#1\.2\n";
print "$count\t$number\n";
print "$dumpline";

for my $ele (sort keys %hash){
  print "$ele\t$hash{$ele}\n";
 }
