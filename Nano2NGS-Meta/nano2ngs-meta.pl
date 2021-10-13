#!/usr/bin/perl -w
use strict;
use File::Basename;
use Getopt::Long;
use FindBin qw/$Bin/;

sub USAGE
{
    my $usage=<<USAGE;

===============================================
Edit by Jidong Lang; E-mail: jidong.lang\@qitantech.com;
===============================================

Option
        -fq <Input_File>    Input .fastq .fq file's
        -read_len  <Extract Read Length>    Extract sequencing read length. Suggest more than 75bp.
	-time	<Number of Swipes>	The number of swipes for the extract the reads
        -help   print HELP message

Example:

perl $0 -fq test.fq -read_len 100 -time 10


USAGE
}

unless(@ARGV>2)
{
    die USAGE;
    exit 0;
}


my ($fq,$read_len,$time);
GetOptions
(
    'fq=s'=>\$fq,
    'read_len=i'=>\$read_len,
    'time=i'=>\$time,
    'help'=>\&USAGE,
);

my $path=`pwd`;
$path=~s/\n//g;

open IN, "$fq" or die;

my @num;

while(<IN>)
{
	chomp;
	if(/^@/)
	{
		#print "$_\n";
		my $seq=<IN>;
		chomp $seq;
		my $plus=<IN>;
		my $qual=<IN>;
		chomp $qual;
		my $len=length($seq);
		my $tmp=int($len/$time);
		for(my $i=0;$i<$time;$i++)
		{
			my $start=int(rand($tmp))+$i*$tmp;
			push @num,$start;
			my $sub_seq=substr($seq,$start,$read_len);
			my $sub_qual=substr($qual,$start,$read_len);
			my $sub_seq_len=length($sub_seq);
			if($sub_seq_len>=$read_len)
			{
				open OUT, ">>$path/tmp.$i.fq" or die;
				my @title=split(/\s+/,$_,2);
				#$title[0]=~s/^@/\@/g;
				#my $tmp_qual= "K" x $sub_seq_len;
				print OUT "$title[0]\n$sub_seq\n+\n$sub_qual\n";
			}
		}
	}
}

