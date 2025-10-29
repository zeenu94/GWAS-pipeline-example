

# Rare variant GWAS Pipeline Example

This repository demonstrates a modular, reproducible workflow for genome-wide association analysis (GWAS) using **PLINK**, **bcftools**, GENESIS, and shell scripting.  
Each script corresponds to one stage of data preparation and QC on chromosome-level VCF files.

---

## Overview

| Step | Script | Purpose |
|------|---------|----------|
| 00 | [`scripts/00_filter_pass_variants.sh`](scripts/00_filter_pass_variants.sh) | Filter raw VCFs to include only variants marked `PASS`; remove headers and extract essential columns. |
| 01 | [`scripts/01_vcf_to_plink.sh`](scripts/01_vcf_to_plink.sh) | Convert filtered VCF files into PLINK binary format (`.bed/.bim/.fam`). |
| 03 | [`scripts/03_standardize_variant_ids.sh`](scripts/03_standardize_variant_ids.sh) | Standardize variant IDs (`CHR:POS:REF:ALT`) and ensure consistent naming between VCF and PLINK files. |
| 04 | [`scripts/04_ld_pruning_qc.sh`](scripts/04_ld_pruning_qc.sh) | Perform genotype missingness, MAF filtering, and LD pruning to create an independent SNP set for PCA/GRM. |
| 05 | [`scripts/05_merge_pruned_snps.sh`](scripts/05_merge_pruned_snps.sh) | Merge per-chromosome LD-pruned datasets into one combined dataset. |
| 06 | [`scripts/06_downstream_qc_hwe.sh`](scripts/06_downstream_qc_hwe.sh) | Apply Hardy-Weinberg equilibrium and additional QC filters for downstream GWAS or PCA. |

---

## Requirements
- **bcftools ≥ 1.12**  
- **PLINK 1.9 / 2.0**  
- Bash environment (SGE job scheduler syntax included; can be adapted for Slurm).  

Example module loads used on an HPC:
```bash
module load bcftools/1.12
module load plink/1.90b6.4
module load plink2/2.00a2.3
qsub scripts/00_filter_pass_variants.sh 22
qsub scripts/01_vcf_to_plink.sh 22
