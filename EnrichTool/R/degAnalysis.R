#' @description
#' This function compares two groups and finds genes that look different.
#' It just calculates a simple log2 fold change. Nothing advanced.

#' @param count_data A data frame with gene counts.
#' @param group A vector showing group labels for each sample.
#' @param log2fc_cutoff The fold change limit. Default is 1.

#' @return A small data frame with genes that pass the cutoff.
#'
#' @examples
#' # deg <- degAnalysis(my_counts, c("A","A","B","B"))
#'
#' @export
degAnalysis <- function(count_data, group, log2fc_cutoff = 1) {

  # pick samples in each group
  g1 <- count_data[, group == unique(group)[1]]
  g2 <- count_data[, group == unique(group)[2]]

  # mean counts
  m1 <- rowMeans(g1)
  m2 <- rowMeans(g2)

  # fold change
  log2fc <- log2(m2 + 1) - log2(m1 + 1)

  # choose genes
  keep <- abs(log2fc) >= log2fc_cutoff

  # output
  result <- data.frame(
    gene = rownames(count_data),
    log2FC = log2fc
  )

  return(result[keep, ])
}
