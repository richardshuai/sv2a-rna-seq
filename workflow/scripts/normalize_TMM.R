library("edgeR")

cts <- read.table("results/counts/all.tsv", header=TRUE, row.names="gene", check.names=FALSE)

coldata <- read.table("config/samples.tsv", header=TRUE, row.names="sample_name", check.names=FALSE)

group <- as.factor(coldata$condition)
dge <- DGEList(counts=cts, group=group)

# keep <- filterByExpr(dge)
# dge <- dge[keep, keep.lib.sizes=FALSE]
dge <- calcNormFactors(dge, method='TMM')
tmm <- cpm(dge)

write.table(tmm, file='results/counts/TMM_normalized.tsv', quote=FALSE, sep='\t', col.names = NA)
