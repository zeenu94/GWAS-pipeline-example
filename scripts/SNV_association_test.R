library(SeqArray)
library(SeqVarTools)
library(SNPRelate)
library(GWASTools)
library(GENESIS)
library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(GGally)
library(qqman)
library(biomaRt)
library(stringr)


pheno <- read.delim("pheno.csv")
pcs <- read.delim("genesis.round1.pcair.pcs.txt")
colnames(pcs)[21] <- "SampleID"

PCs <- left_join(pcs,pheno, by="SampleID")
colnames(PCs)[21] <- "scanID"
scanAnnot<- ScanAnnotationDataFrame(PCs)

# # # # #
GRM <- readRDS("grm.rds")
GRM_noDup <- GRM[row.names(GRM) %in%  PCs$scanID, colnames(GRM) %in%  PCs$scanID ]
nullmod <- fitNullModel(scanAnnot, outcome = "AD", covars = c("PC1","PC2","PC3","PC4","PC5","PC6","PC7","PC8","PC12","PC13","PC14","PC15","PC16","PC17","PC19","PC20","Age","Sex","readlen","Sequencing_Platform","Capture_kit"),
                        cov.mat = GRM_noDup, family = binomial)
saveRDS(nullmod, "nullmod")


