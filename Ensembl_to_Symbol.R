library(AnnotationDbi)
library(org.Hs.eg.db)
library(clusterProfiler)
library(dplyr)

diff <- read.csv("C:/Users/Lamarck/Desktop/diff_expr_result.csv")

converted_genes <- bitr(
  geneID = diff$gene,
  fromType = "ENSEMBL",
  toType = "SYMBOL",
  OrgDb = org.Hs.eg.db
)

final_data <- left_join(diff, converted_genes, by = c("gene" = "ENSEMBL"))

write.csv(final_data, "C:/Users/Lamarck/Desktop/UP_genes_ENSEMBL_HGNC.csv", row.names = FALSE)
