#This is an example script on how to run the functions

#Import count data and filter on log 2 cpm
count_table <- import_RNA("Examples/E-MTAB-2523.counts.txt")

#Extract the sample information from sdrf file
sdrf <- data.table::fread("Examples/E-MTAB-2523_sample table.txt")

#Set the group variable and make "healthy" baseline
Patient <- factor(sdrf$individual)
Sample <- sdrf$sample
Disease <- factor(sdrf$disease, levels = c("normal", "carcinoma"))

SampleTable <- data.frame(Sample, Disease, Patient)
SampleTable <- data.frame(SampleTable, row.names = 1)

#Define design matrix
design <- model.matrix(~ 0 + Disease + Patient, data = SampleTable)
colnames(design)[1:2] <- c("normal", "carcinoma")
#define contrast matrix
contrastmat <- limma::makeContrasts(carsinomaVsnormal = carcinoma - normal,
                             levels = design)

#Run DEG analysis on the filtered count data and provide the group variable
deg_res <- deg_analysis(count_table, design, contrastmat)
print(head(deg_res))

#Run ORA (GO and KEGG) on the deg results
ora <- ora_res(deg_res, "SYMBOL")

head(ora$GO)
head(ora$KEGG)

#export result
export_to_excel(deg_res)

#plot enrichment analysis
ora_plot(ora)

