# Nano2NGS - Developed by Jidong Lang (langjidong@hotmail.com)

Nano2NGS: A Framework for Converting Third-Generation Sequencing Data to NGS-Liked Sequencing Data for Hotspot Mutation Detection and Metagenomic Analysis

The Nano2NGS as a data analysis framework for hotspot mutation detection and metagenomic analysis based on long reads from nanopore sequencing. Nano2NGS is characterized by applying nanopore sequencing data to next generation sequencing (NGS) data analysis pipelines. The main idea is to convert long reads into NGS-like short reads for data analysis. Long reads can be converted into short reads using statistical methods and then processed through existing NGS analysis pipelines to obtain more accurate results compared to conventional third generation sequencing (TGS) data analysis algorithms. Nano2NGS serves as a reference and tool for TGS data analysis, such as base mutation detection and taxonomic classification of metagenomic data based on nanopore sequencing.

The Nano2NGS framework consists of two modules: Nano2NGS-Muta for hotspot mutation analysis and Nano2NGS-Meta for metagenomic analysis.

For the Nano2NGS-Muta modules:

Usage:

Option
        -fq	<Input File>	Input fq.gz file
        -read_len	<To NGS-Liked Read Length>	Extracted Nanopore read to NGS-Liked read length, default is 101bp
        -position_step	<Step Size>	The step size for hotspot site on the NGS-Liked reads, default is 10
        -configure	<Hotspot BED File>	Hotspot bed file, the format likes: chr\tstart\tend\tgene symbol\tmutation\ttranscription ID (optional)
        -process	<Number of process used>	N processes to use, default is 1
        -help	print HELP message

Example:

perl nano2ngs-muta.pl -fq nanopore.fq -read_len 101 -position_step 10 -configure Hotspot.bed -process 8

Note: You should prepare a check-hotspot.list file for calling final target hotspot mutation. The format was just like the hotspot bed file. Why this? Because one probe may contain two or more mutations, the configure file must choose the minimal position, others may be loss. So the check file should contail all the mutation positions.

For the Nano2-Meta modules:

Usage:

Option
        -fq <Input_File>    Input .fastq .fq file's
        -read_len  <Extract Read Length>    Extract sequencing read length. Suggest more than 75bp.
	      -time	<Number of Swipes>	The number of swipes for the extract the reads
        -help   print HELP message

Example:

perl nano2ngs-meta.pl -fq test.fq -read_len 100 -time 10


Note: The Nano2NGS as an analytical framework requires further development and optimization regarding computing resource consumption, running time, and statistical algorithms, among others, to minimize running time and resource consumption while ensuring the accuracy of analysis. In the future, we will develop algorithms for the detection of copy number variation, structural variation, gene fusion, and gene expression level.