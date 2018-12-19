#!/usr/bin/Rscript

library(SNPRelate)
library(ggplot2)
library(getopt) 

spec = matrix(c(
  'input'  , 'i', 1, "character",
  'output' , 'o', 1, "character",
  'help'   , 'h', 0, "logical"
), byrow=TRUE, ncol=4)

opt = getopt(spec)

if (!is.null(opt$help)) {
    cat("Usage: Rscript PCA-script.r -i <vcf file> -o <pca biplot> -h", "\n")
    q()
}

### vcf2gds then pca ###
vcf.fn <- opt$input
 
snpgdsVCF2GDS(vcf.fn, "test.gds", method="biallelic.only") 
genofile <- snpgdsOpen("test.gds")
snpset <- snpgdsLDpruning(genofile, ld.threshold=0.2)
snpset.id <- unlist(snpset)
my_pca <- snpgdsPCA(genofile, snp.id=snpset.id, num.thread=2)
#my_pca
###################
## plot ## 
png(opt$output,width=400,heigh=400)
pc.percent <- my_pca$varprop*100
pc.percent
tab <- data.frame(sample.id = my_pca$sample.id,
    EV1 = my_pca$eigenvect[,1],
    EV2 = my_pca$eigenvect[,2],    
    stringsAsFactors = FALSE)

p<-ggplot(tab,aes(x=EV1,y=EV2,color="red"))
p<-p+geom_point()+
     xlab(paste(c("PC1",as.character(pc.percent[1]),"%"),sep=""))+
     ylab(paste(c("PC2",as.character(pc.percent[2]),"%"),sep=""))#+

p
q()


