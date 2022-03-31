# Nano2NGS - Developed by Jidong Lang (langjidong@hotmail.com)

Nano2NGS: A Framework for Converting Nanopore Sequencing Data to NGS-Liked Sequencing Data for Hotspot Mutation Detection and Metagenomic Analysis

The Nano2NGS as a data analysis framework for hotspot mutation detection and metagenomic analysis based on long reads from nanopore sequencing. The Nano2NGS’s main idea is characterized by applying nanopore sequencing data to NGS-liked data analysis pipelines. Long reads can be converted into short reads and then processed through existing NGS analysis pipelines in combination with statistical methods. Nano2NGS not only effectively avoids false positive/negative results caused by non-random errors and unexpected insertions-deletions (indels) of nanopore sequencing data, improves the reads efficient utilization, but also breaks the barriers of data analysis methods between short-read sequencing and long-read sequencing. We hope Nano2NGS can serves as a reference method for nanopore sequencing data, and promotes higher application scope of nanopore sequencing technology in scientific research and clinical practice.

The Nano2NGS framework consists of two modules: Nano2NGS-Muta for hotspot mutation analysis and Nano2NGS-Meta for metagenomic analysis.

For the Nano2NGS-Muta modules:

Usage:

Option
        -fq		<Input File>			Input fq.gz file
        -read_len	<To NGS-Liked Read Length>	Extracted Nanopore read to NGS-Liked read length, default is 101bp
        -position_step	<Step Size>			The step size for hotspot site on the NGS-Liked reads, default is 10
        -configure	<Hotspot BED File>		Hotspot bed file, the format likes: chr\tstart\tend\tgene symbol\tmutation\ttranscription ID (optional)
        -process	<Number of process used>	N processes to use, default is 1
        -help						print HELP message

Example:

perl nano2ngs-muta.pl -fq nanopore.fq -read_len 101 -position_step 10 -configure Hotspot.bed -process 8

Note: You should prepare a check-hotspot.list file for calling final target hotspot mutation. The format was just like the hotspot bed file. Why this? Because one probe may contain two or more mutations, the configure file must choose the minimal position, others may be loss. So the check file should contail all the mutation positions.

For the Nano2-Meta modules:

Usage:

Option
        -fq 		<Input_File>    		Input .fastq .fq file's
        -read_len  	<Extract Read Length>   	Extract sequencing read length. Suggest more than 75bp.
	-time		<Number of Swipes>		The number of swipes for the extract the reads
        -help   					print HELP message

Example:

perl nano2ngs-meta.pl -fq test.fq -read_len 100 -time 10


Important Notes and Extensions: The current version of the Nano2NGS framework only converts long reads into a set of short reads, with no error correction for reads and/or bases. Therefore, although Nano2NGS can improve the reads efficient utilization, converted short reads may contain lower or similar error rates to the long reads. We recommend that users should evaluate whether it is suitable to use the Nano2NGS framework or Nano2NGS+NGS data analysis software/algorithms according to the purpose and actual needs of the research and the characteristics of Nano2NGS outputs. The Nano2NGS framework is compatible with NGS data analysis software, but regardless of the analysis algorithm and/or pipelines used, it is necessary to use actual data for limit of detection (LoD) analysis and background noise evaluation, as different analysis algorithms can produce different result features.
The Nano2NGS as an analytical framework also requires further development and optimization regarding computing resource consumption, running time, and statistical algorithms, among others, to minimize running time and resource consumption while ensuring the accuracy of analysis. In the future, we will develop algorithms for the detection of copy number variation, structural variation, gene fusion, and gene expression.

BTW, if you have any good suggestions or comments for Nano2NGS, please don't hesitate to contact us, we look forward to communicating and discussing with you.
