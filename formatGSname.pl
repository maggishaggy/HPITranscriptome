#! usr/bin/perl -w
# Zhuofei Xu, 2015 Aug 17
use strict;
die "Usage: perl $0 filtered-pathway-all.gmt filtered-pathway-all.gmt" unless (@ARGV == 2);
open(LIST,$ARGV[0])or die "cannot open $ARGV[0]\n";

open(OUT, ">$ARGV[1]") || die "can't open file\n";
binmode(OUT);

my $name = '';
my $desc = '';
my %hash = ();

while(<LIST>){
	chomp;
	$_ =~ s/\s+$//g;
	 if(/^.*%(.*?)\t(.*)$/){
	  $name = $1;
	  $desc = $2;
	  push @{$hash{$name}}, $desc;
	 }
}
close LIST;

for my $ele (keys %hash){
   my $count = scalar @{$hash{$ele}};
   if($count == 1){
    print OUT "$ele\t@{$hash{$ele}}[0]\n";   
   }else{
   for (my $i = 0; $i<$count; $i++){
     my $number = $i+1;
	 print OUT "$ele$number\t@{$hash{$ele}}[$i]\n"; 
  }	
}  
}