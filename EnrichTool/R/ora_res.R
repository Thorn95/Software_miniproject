#' ORA analysis (GO and KEGG)
#'
#' This function performs over-representation analysis for a list of
#' significant genes. It runs GO enrichment and KEGG pathway enrichment.
#'
#' The input is usually the result from degAnalysis().
#' Gene IDs are expected to be gene symbols (SYMBOL).
#' For KEGG analysis, gene symbols are converted to ENTREZ IDs.
#'
#' @param gene_data Data frame with significant genes.
#'   Genes should be in a column called "gene".
#' @param key_type Type of gene ID used. Default is "SYMBOL".
#'
#' @return A list with GO and KEGG enrichment results.
#'
#' @examples
#' # res <- ora_res(deg_table)
#' # res$GO
#' # res$KEGG
#'
#' @export
ora_res <- function(gene_data, key_type = "SYMBOL") {

  if (!requireNamespace("clusterProfiler", quietly = TRUE)) {
    stop("clusterProfiler package is required.")
  }
  if (!requireNamespace("org.Hs.eg.db", quietly = TRUE)) {
    stop("org.Hs.eg.db package is required.")
  }

  # get gene symbols from DEG table
  genes <- gene_data$gene
  genes <- unique(genes)

  # convert gene symbols to ENTREZ IDs
  entrez_df <- clusterProfiler::bitr(
    geneID   = genes,
    fromType = key_type,
    toType   = "ENTREZID",
    OrgDb    = org.Hs.eg.db::org.Hs.eg.db
  )

  entrez_ids <- unique(entrez_df$ENTREZID)

  # GO enrichment analysis
  go_res <- clusterProfiler::enrichGO(
    gene          = entrez_ids,
    OrgDb         = org.Hs.eg.db::org.Hs.eg.db,
    keyType       = "ENTREZID",
    pvalueCutoff  = 0.05,
    pAdjustMethod = "BH",
    readable      = TRUE
  )

  # KEGG pathway enrichment
  kegg_res <- clusterProfiler::enrichKEGG(
    gene         = entrez_ids,
    organism     = "hsa",
    pvalueCutoff = 0.05
  )

  list(GO = go_res, KEGG = kegg_res)
}

