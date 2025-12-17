#' deg_analysis
#'
#' @description
#' Performs differentially expressed genes (DEG) analysis using functions in
#' edgeR.
#'
#' Generalized linear modeling is applied to response variables (genes here),
#' which are not normally distributed.
#'
#' The function needs to be supplied with the design and contrast matrix that
#' corresponds to the study.
#'
#' @param count_data A dataframe of RNA-seq count data (filtered)
#'
#' @param design A dataframe containing the study explanatory variables.
#'
#' @param contrastmat A contrast matrix containing the sample groups which are
#' being compared
#'
#' @return
#' Table of significant DEG's between sample groups.
#'
#' @examples
#' library(EnrichTool)
#' deg_analysis(count_data, design, contrastmat)
#'
#' @export
#'
deg_analysis <- function(count_data, design, contrastmat){

  #Prepare data for analysis
  dge <- edgeR::DGEList(count_data)
  #Calculate normalization factors
  dge <- edgeR::calcNormFactors(dge)

  #Fit glm
  dge <- edgeR::estimateDisp(dge, design, robust = TRUE)
  fit <- edgeR::glmQLFit(dge, design, robust = TRUE)

  #Statistical testing
  qlfRes <- edgeR::glmQLFTest(fit, contrast = contrastmat)
  topRes <- edgeR::topTags(qlfRes, n = nrow(fit$counts))
  topRes <- subset(topRes$table, abs(logFC) > 1 & FDR < 0.05)

  return(topRes)
}
