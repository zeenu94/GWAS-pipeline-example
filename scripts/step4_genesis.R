library(SeqArray)
library(SeqVarTools,lib.loc = "/share/pkg.7/r/4.0.5/install/lib64/R/library")
library(SNPRelate)
library(GWASTools)
library(GENESIS)
library(ff)
core <- 8
memory.limit(size=16000)
rm(list = ls())
gc()
geno <- "genesis.gds"
pc_fn <- "genesis.round1.pcair.pcs.txt"
unrel_fn <- "genesis.round1.unrelated.pcs.txt"
out1 <- "genesis.round1.pcrelate.pcs.matrix.rds"
out2 <- "genesis.round1.pcrelate.pcs.rds"

#PC-Relate----------------------------------------------------------------
#1
pcs<- read.table(pc_fn,header = T)
row.names(pcs) <- pcs$sample.id
pcs_m <- as.matrix( pcs[,1:20] )
#2
unrel <- read.table(unrel_fn,header = F,stringsAsFactors = F)[,1]
#3
G_reader <- GdsGenotypeReader( geno )
G_obj    <- GenotypeData( G_reader )
G_obj    <- GenotypeBlockIterator(G_obj)
samps <- unlist(rownames(pcs))
#samps <- as.vector(samps)
pcrelate_obj <- pcrelate( gdsobj = G_obj, pcs_m[,1:2], sample.include = samps,training.set= unrel,algorithm="randomized")
saveRDS(pcrelate_obj,out1)
#GRM -------------------------------------------------------------------
grm <- pcrelateToMatrix( pcrelate_obj)
saveRDS(grm,out2)
