#! /usr/bin/perl -w
use strict;
#Edit by Jidong Lang
#E-mail: langjidong@hotmail.com

unless(@ARGV==6)
{
    die "perl $0 <fasta_file> <seed1_position> <seed1_length> <seed2_position> <seed2_length> <output file>\n";
}

open IN,"sed '\$a>' $ARGV[0]|" or die;
open OUT,">$ARGV[5]" or die;

my $seed1_pos = $ARGV[1];
my $seed1_len = $ARGV[2];
my $seed2_pos = $ARGV[3];
my $seed2_len = $ARGV[4];
my ($seq,$seq1,$seq2,$seq1_rev,$seq2_rev,$n,$m);

while(<IN>)
{
	chomp;
	if(/^>/)
	{
		#print "$seq\n";
		$n+=1;
		if(defined($seq))
		{
			$seq1=substr($seq,$seed1_pos,$seed1_len);
			$seq2=substr($seq,$seed2_pos,$seed2_len);
			$seq1_rev=$seq1;
			$seq1_rev=~tr/ATCG/TAGC/;
			$seq1_rev=reverse($seq1_rev);
			$seq2_rev=$seq2;
			$seq2_rev=~tr/ATCG/TAGC/;
			$seq2_rev=reverse($seq2_rev);
			$m=$n-1;
			print OUT "Tag_$m-F\t$seq1\t$seq2_rev\n";
		}
		$seq=();
		next;
	}
	else
	{
		$seq.=$_;
	}

}
