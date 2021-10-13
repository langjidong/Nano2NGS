#! /usr/bin/perl -w
use strict;
#Edit by Jidong Lang
#E-mail: langjidong@hotmail.com

unless(@ARGV==11)
{
    die "perl $0 <hotspot_file> <file_1> <file_2> <file_3> <file_4> <file_5> <file_6> <file_7> <file_8> <file_9> <output file>\n";
}

open IN1,"$ARGV[0]" or die;
open IN2,"$ARGV[1]" or die;
open IN3,"$ARGV[2]" or die;
open IN4,"$ARGV[3]" or die;
open IN5,"$ARGV[4]" or die;
open IN6,"$ARGV[5]" or die;
open IN7,"$ARGV[6]" or die;
open IN8,"$ARGV[7]" or die;
open IN9,"$ARGV[8]" or die;
open IN10,"$ARGV[9]" or die;
open OUT,">$ARGV[10]" or die;

my (@tmp,@tmp1,@tmp2,@tmp3,@tmp4,@tmp5,@tmp6,@tmp7,@tmp8,@tmp9);
my (@k1,@k2,@k3,@k4,@k5,@k6,@r1,@r2,@r3,@s1,@s2,@s3,@t1,@t2,@t3,@u1,@u2,@u3,@v1,@v2,@v3,@w1,@w2,@w3,@x1,@x2,@x3,@y1,@y2,@y3,@z1,@z2,@z3);
my ($r,$final_ao,$final_dp,$final_freq);
my ($rr,$ss,$tt,$uu,$vv,$ww,$xx,$yy,$zz);
my ($ao1,$ao2,$ao3,$ao4,$ao5,$ao6,$ao7,$ao8,$ao9,$dp1,$dp2,$dp3,$dp4,$dp5,$dp6,$dp7,$dp8,$dp9);

while(<IN1>)
{
	chomp;
	@tmp=split;
	push @k1,$tmp[0];
	push @k2,$tmp[1];
	push @k3,$tmp[2];
	push @k4,$tmp[3];
	push @k5,$tmp[4];
	push @k6,$tmp[5];
}

while(<IN2>)
{
	chomp;
	@tmp1=split(/\t/,$_,16);
	push @r1,$tmp1[1];
	push @r2,$tmp1[2];
	push @r3,$tmp1[14];
}

while(<IN3>)
{
        chomp;
        @tmp2=split(/\t/,$_,16);
        push @s1,$tmp2[1];
        push @s2,$tmp2[2];
        push @s3,$tmp2[14];
}

while(<IN4>)
{
        chomp;
        @tmp3=split(/\t/,$_,16);
        push @t1,$tmp3[1];
        push @t2,$tmp3[2];
        push @t3,$tmp3[14];
}

while(<IN5>)
{
        chomp;
        @tmp4=split(/\t/,$_,16);
        push @u1,$tmp4[1];
        push @u2,$tmp4[2];
        push @u3,$tmp4[14];
}

while(<IN6>)
{
        chomp;
        @tmp5=split(/\t/,$_,16);
        push @v1,$tmp5[1];
        push @v2,$tmp5[2];
        push @v3,$tmp5[14];
}

while(<IN7>)
{
        chomp;
        @tmp6=split(/\t/,$_,16);
        push @w1,$tmp6[1];
        push @w2,$tmp6[2];
        push @w3,$tmp6[14];
}

while(<IN8>)
{
        chomp;
        @tmp7=split(/\t/,$_,16);
        push @x1,$tmp7[1];
        push @x2,$tmp7[2];
        push @x3,$tmp7[14];
}

while(<IN9>)
{
        chomp;
        @tmp8=split(/\t/,$_,16);
        push @y1,$tmp8[1];
        push @y2,$tmp8[2];
        push @y3,$tmp8[14];
}

while(<IN10>)
{
        chomp;
        @tmp9=split(/\t/,$_,16);
        push @z1,$tmp9[1];
        push @z2,$tmp9[2];
        push @z3,$tmp9[14];
}

for($r=0;$r<@k1;$r++)
{
	for($rr=0;$rr<@r1;$rr++)
	{
		if($r3[$rr]=~/$k4[$r](.*)$k5[$r]/)
		{
			$ao1=int(0.05*$r2[$rr]+0.5);
			$dp1=int(0.05*$r1[$rr]+0.5);
		}
	}
	for($ss=0;$ss<@s1;$ss++)
	{
		if($s3[$ss]=~/$k4[$r](.*)$k5[$r]/)
		{
			$ao2=int(0.075*$s2[$ss]+0.5);
			$dp2=int(0.075*$s1[$ss]+0.5);
		}
	}
	for($tt=0;$tt<@t1;$tt++)
	{
		if($t3[$tt]=~/$k4[$r](.*)$k5[$r]/)
		{
			$ao3=int(0.1*$t2[$tt]+0.5);
			$dp3=int(0.1*$t1[$tt]+0.5);
		}
	}
	for($uu=0;$uu<@u1;$uu++)
	{
		if($u3[$uu]=~/$k4[$r](.*)$k5[$r]/)
		{
			$ao4=int(0.15*$u2[$uu]+0.5);
			$dp4=int(0.15*$u1[$uu]+0.5);
		}
	}
	for($vv=0;$vv<@v1;$vv++)
	{
		if($v3[$vv]=~/$k4[$r](.*)$k5[$r]/)
		{
			$ao5=int(0.25*$v2[$vv]+0.5);
			$dp5=int(0.25*$v1[$vv]+0.5);
		}
	}
	for($ww=0;$ww<@w1;$ww++)
	{
		if($w3[$ww]=~/$k4[$r](.*)$k5[$r]/)
		{
			$ao6=int(0.15*$w2[$ww]+0.5);
			$dp6=int(0.15*$w1[$ww]+0.5);
		}
	}
	for($xx=0;$xx<@x1;$xx++)
	{
		if($x3[$xx]=~/$k4[$r](.*)$k5[$r]/)
		{
			$ao7=int(0.1*$x2[$xx]+0.5);
			$dp7=int(0.1*$x1[$xx]+0.5);
		}
	}
	for($yy=0;$yy<@y1;$yy++)
	{
		if($y3[$yy]=~/$k4[$r](.*)$k5[$r]/)
		{
			$ao8=int(0.075*$y2[$yy]+0.5);
			$dp8=int(0.075*$y1[$yy]+0.5);
		}
	}
	for($zz=0;$zz<@z1;$zz++)
	{
		if($z3[$zz]=~/$k4[$r](.*)$k5[$r]/)
		{
			$ao9=int(0.05*$z2[$zz]+0.5);
			$dp9=int(0.05*$z1[$zz]+0.5);
		}
	}
	$final_ao=$ao1+$ao2+$ao3+$ao4+$ao5+$ao6+$ao7+$ao8+$ao9;
	$final_dp=$dp1+$dp2+$dp3+$dp4+$dp5+$dp6+$dp7+$dp8+$dp9;
	$final_freq=($final_ao/$final_dp)*100;
	#$final_freq=(($ao1+$ao2+$ao3+$ao4+$ao5+$ao6+$ao7+$ao8+$ao9)/($dp1+$dp2+$dp3+$dp4+$dp5+$dp6+$dp7+$dp8+$dp9))*100;
	#	print "$ao1\t$ao2\t$ao3\t$ao4\t$ao5\t$ao6\t$ao7\t$ao8\t$ao9\n";
	#	print "$dp1\t$dp2\t$dp3\t$dp4\t$dp5\t$dp6\t$dp7\t$dp8\t$dp9\n";
	print OUT "$k1[$r]\t$k2[$r]\t$k3[$r]\t$k4[$r]\t$k5[$r]\t$k6[$r]\t$final_ao\t$final_dp\t$final_freq\%\n";
	$ao1=0;
	$ao2=0;
	$ao3=0;
	$ao4=0;
	$ao5=0;
	$ao6=0;
	$ao7=0;
	$ao8=0;
	$ao9=0;
	$dp1=0;
	$dp2=0;
	$dp3=0;
	$dp4=0;
	$dp5=0;
	$dp6=0;
	$dp7=0;
	$dp8=0;
	$dp9=0;
}
