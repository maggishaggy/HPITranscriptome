#! usr/bin/perl
# Zhuofei Xu, March 31 2015
#use strict;
die "Usage: $0 NC_006998.faa deg-pvalue0.1.txt > deg-pvalue0.1.faa" unless (@ARGV == 2);

open(GENE,$ARGV[0])or die "cannot open $ARGV[0]\n";
open(LIST,$ARGV[1])or die "cannot open $ARGV[1]\n";

my %hash = ();
my $name = '';
my $anno = '';
my $count = 0;

local $/ = '>';

#>gi|66275928|ref|YP_233013.1| core protein [Vaccinia virus]
while(<GENE>){
	chomp;
        my ($head,$sequence) = split(/\n/,$_,2);
        #>IGR0048:87114-87665	552 bp	SSU98_0098	SSU98_2253
        if($head =~ /ref\|(.*?)\|\s+(.*)$/){
        	$name = $1;
        	$anno = $2;
        }
        #warn "$name   $anno\n";
        $sequence =~ s/\n//g;
        $hash{$name} = $anno."\n".$sequence;
      
}
close (GENE);


while(<LIST>){
	chomp;
	my @arr = split(/\n/,$_);
		foreach my $ele (sort {$a cmp $b} @arr){
			if (exists $hash{$ele}){
		print "\>$ele $hash{$ele}\n";
	}
}
}
close LIST;