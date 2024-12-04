library(AnnotationDbi)
library(org.Hs.eg.db)#基因注释包
library(clusterProfiler)#富集包
library(dplyr)
library(ggplot2)#画图包
library(biomaRt)

diff<-read.csv(file="C:/Users/Lamarck/Desktop/UP_genes_ENSEMBL.csv")

# 从文件的第一列（gene列）提取基因ID
gene_ids <- diff$gene

# 使用clusterProfiler包进行基因ID转换
converted_genes <- bitr(
  geneID = gene_ids,
  fromType = "ENSEMBL",    # 原始ID类型
  toType = "ENTREZID",     # 目标ID类型
  OrgDb = org.Hs.eg.db     # 人类基因注释数据库
)

# 将转换结果合并到原始数据中
final_data <- left_join(diff, converted_genes, by = c("gene" = "ENSEMBL"))

# 删除 ENTREEID 列中有 NA 的行
final_data <- final_data %>% filter(!is.na(ENTREZID))

# 保存转换结果到文件
write.csv(final_data, file = "C:/Users/Lamarck/Desktop/UP_genes_ENSEMBL_ENTREZID.csv", row.names = FALSE)
