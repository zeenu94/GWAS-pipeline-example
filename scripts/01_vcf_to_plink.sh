#!/bin/bash -l
# Example preprocessing script for converting VCF to PLINK binary format
# Author: Zainab Khurshid
# Date: 2022
# Usage: qsub 01_vcf_to_plink.sh [chromosome_number]

# Load required modules
module load bcftools/1.12
module load plink2/2.00a2.3

# Job scheduler settings (SGE example)
#$ -m ea
#$ -M zainabk@bu.edu

# Input chromosome argument
chr=$1
vcf=chr${chr}.vcf.gz
out=chr${chr}_step1

# Convert VCF to PLINK format
plink2 \
  --vcf $vcf \
  --double-id \
  --set-all-var-ids @:#:\$1:\$2 \
  --new-id-max-allele-len 10000 \
  --make-bed \
  --out $out
