#!/mnt/gvol/langjidong/miniconda3/bin/perl -w
use strict;

unless(@ARGV==3)
{
	die "perl $0 <merged_metaphlan txt> <sample_name> <output txt>\n";
}

open IN, "$ARGV[0]" or die;
open OUT, ">$ARGV[2]" or die;

my (@tmp);
my ($i,$j,$m,$num1,$num2,$num3,$mean,$sd,$mean_final,$cycle_final);

while(<IN>)
{
	chomp;
	if(/^ID/)
	{
		print OUT "ID\t$ARGV[1]\n";
		next;
	}
	@tmp=split(/\s+/);
	my $cycle=@tmp-1;
	for($i=0;$i<$cycle;$i++)
	{
		$num1+=$tmp[$i+1];
		$mean=$num1/$cycle;
	}
	for($j=0;$j<$cycle;$j++)
	{
		$num2+=($tmp[$j+1]-$mean)**2;
		$sd=sqrt($num2/($cycle-1));
	}
	#print "$cycle\n";
	#print OUT "$tmp[0]\t$mean\t$sd\n";
	$num1=0;
	$num2=0;
	my $CI_lower=$mean-1.96*$sd/sqrt($cycle);    ####alpha=0.05, 95% Confidence Interval####
	my $CI_upper=$mean+1.96*$sd/sqrt($cycle);    ####alpha=0.05, 95% Confidence Interval####
	#print OUT "$tmp[0]\t$mean\t$sd\t$CI_lower\t$CI_upper\n";
	for($m=0;$m<$cycle;$m++)
	{
		if($tmp[$m+1]>=$CI_lower && $tmp[$m+1]<=$CI_upper)
		{
			$cycle_final+=1;
			$num3+=$tmp[$m+1];
		}
		else
		{
			next;
		}
		$mean_final=$num3/$cycle_final;
	}
	print "$num3\t$cycle_final\n";
	$num3=0;
	$cycle_final=0;
	print OUT "$tmp[0]\t$mean_final\n";
}
