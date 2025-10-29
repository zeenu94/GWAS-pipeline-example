#!/bin/bash -l
# Filter VCF variants to include only PASS entries
# Author: Zainab Khurshid
# Date: 2025-10
# Usage: qsub 00_filter_pass_variants.sh [chromosome_number]
#
# Description:
#  Decompresses a gzipped VCF, removes header lines, extracts key fields,
#  and retains only variants marked as PASS.

chr=$1
vcf=chr${chr}.vcf.gz
out=chr${chr}_step0
zcat $vcf | grep -v  "#"| cut -f1-7 |  grep  PASS  > $out
