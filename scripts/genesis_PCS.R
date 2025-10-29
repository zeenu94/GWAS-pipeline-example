library(SeqArray)
library(SeqVarTools,lib.loc = "/share/pkg.7/r/4.0.5/install/lib64/R/library")
library(SNPRelate)
library(GWASTools)
library(GENESIS)


sessionInfo()
out2 <- "genesis.round1.pcair.pcs.txt"
out3 <- "genesis.round1.unrelated.pcs.txt"
out4 <- "genesis.round1.related.pcs.txt"
geno <- "genesis.gds"

gds_obj <- snpgdsOpen(geno)
kingMat <- readRDS("genesis.kingMat.rds")
sampleset <- pcairPartition(kinobj =kingMat,divobj =kingMat)
unrelated.id <- sampleset$unrels[ sampleset$unrels %in% colnames(kingMat)]
related.id   <- sampleset$rels[ sampleset$rels %in% colnames(kingMat)]
length(sampleset$rels)
length(related.id)
length(sampleset$unrels)
length(unrelated.id)

pca.unrel <- snpgdsPCA(gds_obj, sample.id=unrelated.id)
snp.load  <- snpgdsPCASNPLoading(pca.unrel, gdsobj=gds_obj)

samp.load <- snpgdsPCASampLoading(snp.load, gdsobj=gds_obj, sample.id=related.id)

pcs  <- rbind(pca.unrel$eigenvect, samp.load$eigenvect)
rownames(pcs) <- c(pca.unrel$sample.id, samp.load$sample.id)

pc.df  <- as.data.frame(pcs)[,1:20]
names(pc.df)  <- paste0("PC", 1:ncol( pc.df ))
pc.df$sample.id <- row.names(pcs)

snpgdsClose(gds_obj)

write.table(unrelated.id,file=out3,col.names = F,row.names = F,sep='\t', quote = F)
write.table(related.id,  file=out4,  col.names = F,row.names = F,sep='\t', quote = F)
write.table(pc.df, file=out2,col.names = TRUE,sep='\t',row.names = F, quote = F)
