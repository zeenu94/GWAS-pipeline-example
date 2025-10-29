# Merge per-chromosome LD-pruned datasets into one PLINK bed set
# Author: Zainab Khurshid
# Usage: qsub 05_merge_pruned_snps.sh
# Notes: Uses PLINK 1.9 for --merge-list

module load bcftools/1.12
module load plink/1.90b6.4
#$ -m ea
#$ -M zainabk@bu.edu
for chr  in {2..22};do
    echo chr${chr}_step3  >> total.txt
done
chr=1
chr1=chr1_step3
plink --bfile $chr1  --merge-list  total.txt  --out  step5
