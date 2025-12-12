#' Filter low expressed genes (edgeR)
#'
#' Removes genes with very low expression before running edgeR.
#' This uses edgeR's recommended filtering method (filterByExpr).
#'
#' @param count_data Count matrix/data.frame (rows = genes, cols = samples)
#' @param group Group labels for samples (same order as columns)
#'
#' @return Filtered count matrix
#'
#' @export
filterLowExpressed <- function(count_data, group) {

  if (!requireNamespace("edgeR", quietly = TRUE)) {
    stop("edgeR package is required.")
  }

  y <- edgeR::DGEList(counts = count_data, group = factor(group))
  keep <- edgeR::filterByExpr(y)

  count_data[keep, ]
}
