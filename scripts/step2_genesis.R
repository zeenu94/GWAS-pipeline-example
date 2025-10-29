library(SeqArray)
library(SeqVarTools)
library(SNPRelate)
library(GWASTools)
library(GENESIS)
sessionInfo()
# open

geno <- "genesis.gds"
gds_obj <- snpgdsOpen(geno)
out1 <- "genesis.kingMat.rds"

core <- 8
#KING-----------------------------------------------------------------
king <- snpgdsIBDKING( gdsobj =  gds_obj, verbose = FALSE)
kingMat <- king$kinship
dimnames(kingMat) <- list(king$sample.id, king$sample.id)
saveRDS(kingMat, out1)
print("king step finished-------------------------------")

snpgdsClose(gds_obj)
