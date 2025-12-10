

#' @description
#' This function takes a data frame and saves it as an Excel (.xlsx) file.  
#' I made it mainly for exporting my analysis results in a simple way.
#'
#' @param results  
#' A data frame that contains the results you want to save.
#'
#' @param file_name  
#' The name of the Excel file you want to create.  
#' By default it saves as "results.xlsx".
#'
#' @return  
#' The function returns a small message telling you the file was saved.
#'
#' @examples
#' # exportToExcel(my_dataframe, "output.xlsx")
#'
#' @export
exportToExcel <- function(results, file_name = "results.xlsx") {

    # check if the openxlsx package is installed
    if (!requireNamespace("openxlsx", quietly = TRUE)) {
        stop("The 'openxlsx' package is not installed.")
    }

    # write the Excel file
    openxlsx::write.xlsx(results, file = file_name)

    # tell the user the file was saved
    return(paste("File saved as", file_name))
}
