#!/bin/bash -l
# Standardize variant IDs and extract PASS variants across datasets
# Author: Zainab Khurshid
# Date: 2022
# Usage: qsub 03_standardize_variant_ids.sh [chromosome_number]
#
# Description:
#  - Generates standardized variant IDs (CHR:POS:REF:ALT)
#  - Updates PLINK .bim file IDs accordingly
#  - Extracts PASS variants for final harmonized PLINK dataset
#
# Dependencies: bcftools/1.12, plink/1.90b6.4


module load bcftools/1.12
module load plink/1.90b6.4
#$ -m ea
#$ -M zainabk@bu.edu

chr=$1
out1=chr${chr}_step0
out2=chr${chr}_step1
out3=chr${chr}_step2.ID
out4=chr${chr}_step2

awk '{print $1":"$2":"$4":"$5}' $out1 | sed 's/chr//g' > $out3
mv ${out2}.bim ${out2}.bim.ori
awk '$2=$1":"$4":"$6":"$5' ${out2}.bim.ori > ${out2}.bim

plink --bfile $out2 --extract ${out3} --make-bed --out $out4
