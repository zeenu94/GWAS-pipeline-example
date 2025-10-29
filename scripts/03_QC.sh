#!/bin/bash -l

# LD pruning and variant QC for high-quality independent SNP set
# Author: Zainab Khurshid
# Date: 2022
# Usage: qsub 04_ld_pruning_qc.sh [chromosome_number]
#
# Description:
#  Performs genotype missingness, MAF filtering, and LD pruning
#  to generate a set of independent, high-quality SNPs for PCA or GRM construction for rare-variants.
#  Dependencies: bcftools/1.12, plink2/2.00a2.3

module load bcftools/1.12
module load plink2/2.00a2.3
#$ -m ea
#$ -M zainabk@bu.edu

chr=$1
out1=chr${chr}_step2
out2=chr${chr}_step3ID
out3=chr${chr}_step3
#pruning, select high callrate, pass hwe test, common variants, pruned
plink2 --bfile ${out1}  --geno 0.05  --maf 0.01 --indep-pairwise 50 5 0.5 --set-all-var-ids @_#  --out ${out2}

#pull out those pruned variants from plink file
plink2 --bfile  ${out1}   --extract  ${out2}.prune.in --set-all-var-ids @_# --make-bed --out ${out3}
