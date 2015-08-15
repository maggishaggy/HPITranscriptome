library(DESeq2)

countMatRaw<-read.table("virus-read-count.txt", header=T, check.names=F, sep="\t")
row.names(countMatRaw) <- countMatRaw[,1]
countMatRaw <- countMatRaw[,-1]

# Filter extremely low expressed genes and keep genes with counts greater than 10 in at least 2 samples
sel.countCutoff <- rowSums(countMatRaw > 10) >= 2
countMat.countCutoff <- countMatRaw[sel.countCutoff, ]

grp.idx <- rep(c("2h","4h"), times=2)


coldat = DataFrame(grp=factor(grp.idx))
rownames(coldat) <- colnames(countMat.countCutoff)

ddsinput <- DESeqDataSetFromMatrix(countMat.countCutoff, colData=coldat, design = ~ grp)
ddsmain <- DESeq(ddsinput)

# comparison using 4h as treatment and 2h as control
deseq2.res <- results(ddsmain, contrast=c("grp","4h","2h"))

deseqdf<-as.data.frame(deseq2.res)

# Add gene symbols
geneNameInfo <- read.table("vacvGeneID.txt",row.names=1, header=T, sep="\t")

sel.row = match(row.names(deseqdf), geneNameInfo$RefseqID);
ViralGeneSymbol = geneNameInfo[sel.row,]$Symbol
ViralGeneProduct = geneNameInfo[sel.row,]$Viral_Gene_Product

write.table(cbind(ViralGeneSymbol, ViralGeneProduct, RefSeq_ID=rownames(deseqdf), deseqdf), sep="\t", 
            row.names = FALSE, quote = FALSE, file="virus-DEA-output.txt")

save.image("virus-DE-analysis.RData")
