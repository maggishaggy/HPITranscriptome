
hpiList<-read.table("HPIs.addEntrezID.txt", header=T, check.names=F, sep="\t")

library(org.Hs.eg.db)
hostGene <- as.character(hpiList$`Entrez ID`)
hostGeneSymbol <-select(org.Hs.eg.db, hostGene, c("SYMBOL", "GENENAME"))

viralGene<-read.table("vacvGeneID.txt", header=T, check.names=F, sep="\t")
refseqID <- viralGene$RefseqID

sel.order <- match(hpiList$`Virus RefSeqID`, refseqID)
viralGeneSymbol <- as.character(viralGene[sel.order,]$Symbol)

write.table(cbind(Viral_Gene_Symbol=viralGeneSymbol, hpiList, hostGeneSymbol, ENTREZID=hostGeneSymbol$ENTREZID),
            sep="\t",
            quote = FALSE, row.names=FALSE, file="HPIs.addGeneSymbol.txt")

save.image("addGeneSymbol.RData")