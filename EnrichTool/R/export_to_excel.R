#' export_to_excel
#'
#' @description
#' Writes the results from differentially expressed genes (DEG) analysis to Excel.
#'
#' @param deg_res Result from DEG-analysis
#'
#' @param file_name Name of file.
#'
#' @return
#' Returns an excel file with DEG's.
#'
#' @examples
#' library(EnrichTool)
#' export_to_excel(deg_res, file_name = "my_deg_results.xlsx")
#'
#' @export
#'
export_to_excel <- function(deg_res, file_name = "deg_results.xlsx"){

  openxlsx::write.xlsx(deg_res, file = file_name, rowNames = TRUE)
}
