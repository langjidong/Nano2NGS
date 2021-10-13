#!/usr/bin/perl -w
use strict;
use File::Basename;
use Getopt::Long;
use FindBin qw/$Bin/;

sub USAGE
{
    my $usage=<<USAGE;

===============================================
Edit by Jidong Lang; E-mail: langjidong\@hotmail.com;
===============================================

Option
        -fq	<Input File>	Input fq.gz file
        -read_len	<To NGS-Liked Read Length>	Extracted Nanopore read to NGS-Liked read length, default is 101bp
        -position_step	<Step Size>	The step size for hotspot site on the NGS-Liked reads, default is 10
        -configure	<Hotspot BED File>	Hotspot bed file, the format likes: chr\tstart\tend\tgene symbol\tmutation\ttranscription ID (optional)
        -process	<Number of process used>	N processes to use, default is 1
        -help	print HELP message

Example:

perl $0 -fq nanopore.fq -read_len 101 -position_step 10 -configure Hotspot.bed -process 1

Note: You should prepare a check-hotspot.list file for calling final target hotspot mutation. The format was just like the hotspot bed file. Why this? Because one probe may contain two or more mutations, the configure file must choose the minimal position, others may be loss. So the check file should contail all the mutation positions.

USAGE
}

unless(@ARGV>3)
{
    die USAGE;
    exit 0;
}


my ($fq,$read_len,$position_step,$configure,$process);
GetOptions
(
    'fq=s'=>\$fq,
    'read_len=i'=>\$read_len,
    'position_step=i'=>\$position_step,
    'configure=s'=>\$configure,
    'process=i'=>\$process,
    'help'=>\&USAGE,
);

$read_len ||=101;
$position_step ||=10;
$process ||=1;

my (@tmp,@tmp1,@tmp2,@k1,@k2,@k3,@k4,@k5,@k6,@t1,@t2,@t3);
my ($i,$j,$m,$n,$x,$y,$times,$start_position);
my ($ao1,$ao2,$ao3,$ao4,$ao5,$ao6,$ao7,$ao8,$ao9,$do1,$do2,$do3,$do4,$do5,$do6,$do7,$do8,$do9);
my $basename=basename($fq);
$basename=~s/(.*).fq/$1/g;

####Prepare Hotspot Sequence and Seed Sequence####

open IN, "$configure" or die;

`mkdir target`;

while(<IN>)
{
    chomp;
    @tmp=split;
    $times=int($read_len/$position_step)-1;
    for($i=0;$i<$times;$i++)
    {
	    $start_position=$tmp[1]-($i+1)*$position_step;
	    `perl $Bin/script/Target_reference_prepare.pl $Bin/database/by_chr/$tmp[0].fa $start_position $read_len $tmp[3]_$tmp[4] ./target/reference.$i.fa`;
    }
}

for($j=0;$j<$times;$j++)
{
	`perl $Bin/script/Seed.pl ./target/reference.$j.fa 0 10 91 10 ./target/seed.$j.info`;
}

####Extract the NGS-Liked Reads by Seed Sequences from Nanopore Reads####

`mkdir NGS-Liked`;
`less $configure|awk '{print \$1"\t"\$2-24"\t"\$3+24}' > NGS-Liked/hotspot.bed`;
for($m=0;$m<$times;$m++)
{
	`mkdir NGS-Liked/Analysis-$m`;
	`less ./target/seed.$m.info|while read a b c;do perl $Bin/script/Tagseq-fastq.pl $fq \${b} \${c} NGS-Liked/Analysis-$m/$basename-$m.fq;done`;
	`bwa mem -t $process /mnt/nas/bioinfo/langjidong/PERL/resequencing/database/hg19/database/index/hg19.fa NGS-Liked/Analysis-$m/$basename-$m.fq > NGS-Liked/Analysis-$m/$basename-$m.sam`;
	`samtools view -b -S -t /mnt/nas/bioinfo/langjidong/PERL/resequencing/database/hg19/database/index/hg19.fa.fai NGS-Liked/Analysis-$m/$basename-$m.sam|samtools sort -m 2000000000 -@ $process - -o NGS-Liked/Analysis-$m/$basename-$m.bam`;
	`rm -rf NGS-Liked/Analysis-$m/$basename-$m.sam`;
	`samtools index NGS-Liked/Analysis-$m/$basename-$m.bam`;
	`freebayes -F 0.01 -C 1 -t NGS-Liked/hotspot.bed -f /mnt/nas/bioinfo/langjidong/PERL/resequencing/database/hg19/database/index/hg19.fa NGS-Liked/Analysis-$m/$basename-$m.bam > NGS-Liked/Analysis-$m/$basename-$m.vcf`;
	`perl /mnt/nas/bioinfo/langjidong/PERL/WGS/annovar_new_version/table_annovar.pl NGS-Liked/Analysis-$m/$basename-$m.vcf /mnt/nas/bioinfo/langjidong/PERL/WGS/annovar_new_version/humandb_hg19_new/ -out NGS-Liked/Analysis-$m/$basename-$m.anno -remove -protocol refGene -operation g --buildver hg19 --nastring . --vcfinput --otherinfo --dot2underline`;
	`freebayes -F 0.001 -C 1 -t NGS-Liked/hotspot.bed -f /mnt/nas/bioinfo/langjidong/PERL/resequencing/database/hg19/database/index/hg19.fa NGS-Liked/Analysis-$m/$basename-$m.bam > NGS-Liked/Analysis-$m/$basename-$m-1.vcf`;
	`perl /mnt/nas/bioinfo/langjidong/PERL/WGS/annovar_new_version/table_annovar.pl NGS-Liked/Analysis-$m/$basename-$m-1.vcf /mnt/nas/bioinfo/langjidong/PERL/WGS/annovar_new_version/humandb_hg19_new/ -out NGS-Liked/Analysis-$m/$basename-$m-1.anno -remove -protocol refGene -operation g --buildver hg19 --nastring . --vcfinput --otherinfo --dot2underline`;
	`freebayes -F 0.0001 -C 1 -t NGS-Liked/hotspot.bed -f /mnt/nas/bioinfo/langjidong/PERL/resequencing/database/hg19/database/index/hg19.fa NGS-Liked/Analysis-$m/$basename-$m.bam > NGS-Liked/Analysis-$m/$basename-$m-2.vcf`;
	`perl /mnt/nas/bioinfo/langjidong/PERL/WGS/annovar_new_version/table_annovar.pl NGS-Liked/Analysis-$m/$basename-$m-2.vcf /mnt/nas/bioinfo/langjidong/PERL/WGS/annovar_new_version/humandb_hg19_new/ -out NGS-Liked/Analysis-$m/$basename-$m-2.anno -remove -protocol refGene -operation g --buildver hg19 --nastring . --vcfinput --otherinfo --dot2underline`;
	`perl /mnt/nas/bioinfo/langjidong/PERL/software/Third-Generation/Pipeline/script/static_data.pl NGS-Liked/Analysis-$m/$basename-$m.fq NGS-Liked/Analysis-$m/$basename-$m.stat`;
}

####Final Result with Weighting####

`mkdir Result`;
for($n=0;$n<$times;$n++)
{
	`perl $Bin/script/AnnovarTxt.format.pl NGS-Liked/Analysis-$n/$basename-$n.anno.hg19_multianno.txt > Result/$basename-$n.format`;
	`perl $Bin/script/AnnovarTxt.format.pl NGS-Liked/Analysis-$n/$basename-$n-1.anno.hg19_multianno.txt > Result/$basename-$n-1.format`;
	`perl $Bin/script/AnnovarTxt.format.pl NGS-Liked/Analysis-$n/$basename-$n-2.anno.hg19_multianno.txt > Result/$basename-$n-2.format`;
}

`perl $Bin/script/Weight.pl ./check-hotspot.list Result/$basename-0.format Result/$basename-1.format Result/$basename-2.format Result/$basename-3.format Result/$basename-4.format Result/$basename-5.format Result/$basename-6.format Result/$basename-7.format Result/$basename-8.format Result/Final.result`;
