#!/usr/bin/zsh

set -ueo pipefail

p=$(nproc)

# Downloading sequences from SRA database

fasterq-dump 'SRR8797416' -p -e $p

# Correcting the read names to make them compatible with MIRA assembler

cat 'SRR8797416_1.fastq' | paste - - | sed 's/^\(\S*\)/\1\/1/' | tr "\t" "\n" > t
mv -f t 'SRR8797416_1.fastq'
cat 'SRR8797416_2.fastq' | paste - - | sed 's/^\(\S*\)/\1\/2/' | tr "\t" "\n" > t
mv -f t 'SRR8797416_2.fastq'

# Compressing sequences

pigz -p $p *.fastq

# Correcting reads with Lighter

lighter -od . -r *_1.fastq.gz -r *_2.fastq.gz -K 21 6500000 -t 4 -maxcor 1 -trim

# Merging reads with FLASH

flash -m 20 -M 251 -d . -o flash -t 4 *1.cor.fq.gz *2.cor.fq.gz

# Removing reads containing vector contamination with Deconseq

. ~/.profile
for i in flash*.fastq
  do
    perl ~/Bioinfo/deconseq/deconseq.pl -f $i -dbs univec -id "${i%.fastq}"
  done

# Re-synchronizing cleaned, unmerged paired-end reads

fastq_pair 'flash.notCombined_1_clean.fq' 'flash.notCombined_2_clean.fq'

# Compressing sequence files with proper extensions for MIRA assembler

for i in flash*.f*q
  do
    pigz -p $p $i
    mv -f "${i}.gz" "${i%.fq}.fastq.gz"
  done

# Assembling genome with MIRA

mira 'CH28_MIRA_manifest.txt'
