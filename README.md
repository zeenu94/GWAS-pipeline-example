# GWAS Pipeline Example

This repository demonstrates a modular, reproducible workflow for rare variant genome-wide association analysis (GWAS) and mixed-model association testing using **PLINK**, **bcftools**,and **GENESIS (R)**.  
It includes shell scripts for variant-level QC, LD pruning, and data preparation, and R scripts for association testing, null model fitting, and visualization.

---

## 📘 Overview

| Step | Script | Purpose |
|------|---------|----------|
| 00 | [`00_filter_pass_variants.sh`](00_filter_pass_variants.sh) | Filter raw VCFs to include only variants marked `PASS`; remove headers and extract key columns. |
| 01 | [`01_vcf_to_plink.sh`](01_vcf_to_plink.sh) | Convert filtered VCF files into PLINK binary format (`.bed/.bim/.fam`). |
| 02 | [`02_standardize_variant_ids.sh`](02_standardize_variant_ids.sh) | Standardize variant IDs (`CHR:POS:REF:ALT`) to ensure consistent naming across files. |
| 03 | [`03_QC.sh`](03_QC.sh) | Perform genotype and MAF filtering, LD pruning, and variant-level quality control. |
| 04 | [`04_merge_pruned_snps.sh`](04_merge_pruned_snps.sh) | Merge per-chromosome LD-pruned datasets into one combined dataset. |
| 05 | [`05_downstream`](05_downstream) | Apply downstream Hardy-Weinberg equilibrium and call rate filtering for clean GWAS input. |

---

## 🧬 GENESIS Workflow

| Step | Script | Purpose |
|------|---------|----------|
| 1 | [`step1_genesis.R`](step1_genesis.R) | Create a GDS file from PLINK data (Step 4 output). |
| 2 | [`step2_genesis.R`](step2_genesis.R) | Compute kinship matrix using KING or PC-Relate. |
| 3 | [`step3_genesis.R`](step3_genesis.R) | Perform PCA to derive ancestry principal components. |
| 4 | [`step4_genesis.R`](step4_genesis.R) | Construct a genetic relationship matrix (GRM). |
| — | [`nullmod.R`](nullmod.R) | Fit null mixed model adjusting for covariates and PCs. |
| — | [`assoc.R`](assoc.R) | Run association tests (e.g., single-variant or gene-based) using the GENESIS package. |
| — | [`QQ_Manhattan.R`](QQ_Manhattan.R) | Generate Manhattan and QQ plots from association results. |

---

## ⚙️ Requirements

### Software
- **bcftools ≥ 1.12**
- **PLINK ≥ 1.9 / 2.0**
- **R ≥ 4.2**
- R libraries: `GENESIS`, `GWASTools`, `SNPRelate`, `SeqArray`, `data.table`, `ggplot2`

### Environment
- Scripts include Sun Grid Engine (SGE) syntax for HPC submission (`qsub`).  
  Adaptable for Slurm (`#SBATCH`) if needed.

Example module loads:
```bash
module load bcftools/1.12
module load plink/1.90b6.4
module load plink2/2.00a2.3
module load R/4.2.0
qsub 00_filter_pass_variants.sh 22
qsub 01_vcf_to_plink.sh 22
# Run interactively or as batch jobs
Rscript step1_genesis.R
