#' Export results to an Excel file
#'
#' This function saves a data frame to an Excel file.
#'
#' @param results A data frame containing analysis results.
#' @param file_name A string with the output file name.
#'
#' @return Writes an Excel file to your working directory.
#' @export
exportToExcel <- function(results, file_name = "results.xlsx") {
  # Load the required library
  if (!requireNamespace("openxlsx", quietly = TRUE)) {
    stop("Package 'openxlsx' is required but not installed.")
  }

  # Write the file
  openxlsx::write.xlsx(results, file = file_name)

  return(paste("File saved as", file_name))
}
