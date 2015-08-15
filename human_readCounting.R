#source("http://bioconductor.org/biocLite.R")
#biocLite("TxDb.Hsapiens.UCSC.hg38.knownGene")

library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(Rsamtools)
library(GenomicAlignments)
exByGn <- exonsBy(TxDb.Hsapiens.UCSC.hg38.knownGene, "gene")

fls <- list.files(".", pattern="bam$", full.names =T)
bamfls <- BamFileList(fls,yieldSize=100000)

# For single-end
readcount <- summarizeOverlaps(exByGn, bamfls, mode="Union",
                               ignore.strand=FALSE, 
                               singleEnd=TRUE, fragments=FALSE)
countMat=assay(readcount)
write.table(cbind(Gene_ID=rownames(countMat), countMat), sep="\t", 
            row.names=FALSE, quote = FALSE, file="human-readcount.txt")

save.image("human_readCounting.RData")
