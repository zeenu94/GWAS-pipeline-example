library(SeqArray)
library(SeqVarTools)
library(SNPRelate)
library(GWASTools)
library(GENESIS)
sessionInfo()
# open

geno <- "genesis.step1.gds"
gds_obj <- snpgdsOpen(geno)
out1 <- "genesis.kingMat.amish.rds"
#out2 <- "genesis_extra_ld.pruned.round1.pcair.pcs.txt"
#out3 <- "genesis_extra_ld.pruned.round1.unrelated.txt"
#out4 <- "genesis_extra_ld.pruned.round1.related.txt"
core <- 8
#KING-----------------------------------------------------------------
king <- snpgdsIBDKING( gdsobj =  gds_obj, verbose = FALSE)
kingMat <- king$kinship
dimnames(kingMat) <- list(king$sample.id, king$sample.id)
saveRDS(kingMat, out1)
print("king step finished-------------------------------")
#kingMat <- readRDS("adgc.kingMat.rds")
#PC-AiR---------------------------------------------------------------
#pcair_obj  <- pcair(gdsobj = gds_obj, num.cores= core , kinobj=kingMat,divobj=kingMat)
#print("pcair step finished------------------------------")
#pc.df         <- as.data.frame(pcair_obj$vectors)[,1:10]
#names(pc.df)  <- paste0("PC", 1:ncol( pc.df ))
#pc.df$sample.id <- row.names(pcair_obj$vectors) 
#write.table(pc.df,file=out2,col.names = TRUE,sep='\t',row.names = F, quote = F)
#write.table(pcair_obj$unrels,file=out3,col.names = F,row.names = F,sep='\t', quote = F)
#write.table(pcair_obj$rels,  file=out4,  col.names = F,row.names = F,sep='\t', quote = F)
snpgdsClose(gds_obj)
