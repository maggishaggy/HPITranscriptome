
hpiList<-read.table("HPIs.expressedGene.txt", header=T, check.names=F, sep="\t")
viralDEA<-read.table("virus-DEA-output.txt", header=T, check.names=F, sep="\t")

refseqID <- viralDEA$RefSeq_ID

sel.order <- match(hpiList$`Virus RefSeqID`, refseqID)
viralDEAHPI <- viralDEA[sel.order,]

write.table(cbind(viralDEAHPI, hpiList),sep="\t",
            quote = FALSE, row.names=FALSE, file="viralDEA.mergeHPI.txt")

save.image("mergeViralDEA2HPI.RData")