library(SeqArray)
library(SeqVarTools,lib.loc = "/share/pkg.7/r/4.0.5/install/lib64/R/library")
library(SNPRelate)
library(GWASTools)
library(GENESIS)

bed.fn <- "step5.bed"
bim.fn <- "step5.bim"
fam.fn <- "step5.fam"

gds <- "genesis.gds"


snpgdsBED2GDS(bed.fn, fam.fn, bim.fn, gds)
