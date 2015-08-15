library(DESeq2)

countMatRaw<-read.table("human-readcount.txt", header=T, check.names=F, sep="\t")
row.names(countMatRaw) <- countMatRaw[,1]
countMatRaw <- countMatRaw[,-1]


# Filter extremely low expressed genes and keep genes with counts greater than 5 in at least 2 samples
sel.countCutoff <- rowSums(countMatRaw> 5) >= 2
countMat.countCutoff <- countMatRaw[sel.countCutoff, ]

write.table(cbind(Entrez_ID=rownames(countMat.countCutoff), countMat.countCutoff), sep="\t", 
            row.names = FALSE, quote = FALSE, file="human-expressedGene.txt")

grp.idx <- rep(c("2h","4h"), times=2)
coldat = DataFrame(grp=factor(grp.idx))
rownames(coldat) <- colnames(countMat.countCutoff)

ddsinput <- DESeqDataSetFromMatrix(countMat.countCutoff, colData=coldat, design = ~ grp)
ddsmain <- DESeq(ddsinput)

# comparison using 4h as treatment and 2h as control
deseq2.res <- results(ddsmain, contrast=c("grp","4h","2h"))
deseqdf<-as.data.frame(deseq2.res)

# Add gene symbols
library(org.Hs.eg.db)
gene.id <- rownames(deseqdf)
gene.anno <-select(org.Hs.eg.db, gene.id, c("GENENAME", "SYMBOL"))

write.table(cbind(gene.anno, Gene_ID=rownames(deseqdf), deseqdf), sep="\t", 
            row.names = FALSE, quote = FALSE, file="human-DEA-output.txt")

save.image("human-DE-analysis.RData")
