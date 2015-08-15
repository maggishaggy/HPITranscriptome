#! usr/bin/perl
#use strict;
#Zhuofei Xu, Aug 3, 2015
die "Usage: $0 directory-containing-count-table > merged-count.tab" unless (@ARGV == 1);

my $inputdir = shift @ARGV;
my %hash = ();

my @aln_array;
opendir(DIR, $inputdir) || die $!;

print "Gene_ID";

for my $file ( readdir(DIR) ) {
 if( $file =~ /^(.*?)-/) { 
   my $name = $1;
   print "\t$name";
   open(LIST, "$inputdir/$file") || die "can't open file:$!\n";
   while(<LIST>){                               
	chomp;
	if(/^__/){
	  next;
	  }
   if (/^(\S+)\s+(\S+)$/){
	push @{$hash{$1}}, $2;
	}
}
close LIST;
}
}

print "\n";

for my $ele (keys %hash){
	 
   print "$ele\t", join("\t", @{$hash{$ele}}), "\n";

}

