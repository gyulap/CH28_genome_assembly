# Genome assembly of *Mycolicibacterium* sp. CH28
Pipeline for the genome assembly of *Mycolicibacterium* sp. CH28 published by Zsilinszky *et al.*, (2019) in Microbiology Resource Announcements

## Requirements
* Linux operation system with zsh shell (I used Ubuntu 18.04.2 LTS)
* sra-toolkit v2.9.2 [link](https://github.com/ncbi/sra-tools)
* pigz v2.4 [link](https://github.com/madler/pigz)
* Lighter v1.1.1 [link](https://github.com/mourisl/Lighter)
* FLASH v1.2.11 [link](https://sourceforge.net/projects/flashpage/)
* DeconSeq v0.4.3 [link](https://sourceforge.net/projects/deconseq/files/)
* fastq-pair v0.1 [link](https://github.com/linsalrob/fastq-pair)
* MIRA v5rc2 [link](https://github.com/bachev/mira)

Make sure that every tool works and are in your PATH. For some reason DeconSeq work only if I run it directly through perl so change the path to your `deconseq.pl` in the script.

## Usage
Download this directory and run the `CH28_genome_assembly.sh` script which downloads sequences from the SRA database and processes them. The results are placed in the 'CH28_MIRA5_MiSeq_deconseq' directory.
