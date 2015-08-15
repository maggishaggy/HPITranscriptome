library(gage)

rawExprMat<-read.table("human-readcount.txt", header=T, check.names=F, sep="\t")

row.names(rawExprMat)<-rawExprMat[,1]

rawExprMat<-rawExprMat[,-1]

sel.non0<-rowSums(rawExprMat)!= 0
rawExprMatNon0<-rawExprMat[sel.non0,]

write.table(cbind(Entrez_ID=rownames(rawExprMatNon0), rawExprMatNon0), sep="\t", 
            row.names = FALSE, quote = FALSE, file="human-GeneExprMat.txt")


# Normalization
libsizes<-colSums(rawExprMatNon0)
size.factor<-libsizes/exp(mean(log(libsizes)))
count.norm<-t(t(rawExprMatNon0)/size.factor)
count.log<-log2(count.norm+8)

# 4h (samp.idx) as treatment and 2h (ref.idx) as control
samp.idx=c(2,4)
ref.idx=c(1,3)

# Load gene-sets
gsHuman=readList("humanRefGSready.gmt")
geneset.p<-gage(count.log, gsets=gsHuman, samp=samp.idx, ref=ref.idx, compare="unpaired")

gs.up.full<-geneset.p$greater
write.table(cbind(PathwayID=rownames(gs.up.full), gs.up.full),sep="\t",row.names=FALSE, quote = FALSE, file="geneset.up.list")
gs.down.full<-geneset.p$less
write.table(cbind(PathwayID=rownames(gs.down.full), gs.down.full),sep="\t",row.names=FALSE,quote = FALSE, file="geneset.down.list")

save.image("human-GSEA-analysis.RData")