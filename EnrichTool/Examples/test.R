#This is an example script on how to run the functions

#Import count data and filter on log 2 cpm
count_table <- import_RNA("Examples/E-MTAB-2523.counts.txt")

#Extract the sample information from sdrf file
sdrf <- data.table::fread("Examples/E-MTAB-2523_sample table.txt")

#Set the group variable and make "healthy" baseline
Sample <- sdrf$sample
Disease <- factor(sdrf$disease, levels = c("normal", "carcinoma"))

SampleTable <- data.frame(Sample, Disease)
SampleTable <- data.frame(SampleTable, row.names = 1)

#Run DEG analysis on the filtered count data and provide the group variable
def_res <- degAnalysis(count_table, SampleTable$Disease)

#Run ORA (GO and KEGG) on the deg results
ora <- ora_res(def_res, "SYMBOL")

head(ora$GO)
head(ora$KEGG)

#export result
exportToExcel(def_res)
