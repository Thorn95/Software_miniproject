#' ora_plot
#'
#' @description
#' Plots the result from over representation analysis from KEGG and GO.
#'
#' Choose to visualize ora results with dotplot and/or cnetplot.
#'
#' @param ora_res A list with result from ORA
#'
#' @param plots The string of desired plot.
#'
#' @return
#' Plots that visualizes the results from ORA
#'
#' @example
#' library(EnrichTool)
#' ora_plot(ora_res, plots = "dotplot")
#'
#' @export
#'
ora_plot <- function(ora_res, plots = c("dotplot", "cnetplot")){

  GO <- ora_res$GO
  KEGG <- ora_res$KEGG

  #Dotplots
  if ("dotplot" %in% plots){
    dot_go <- clusterProfiler::dotplot(GO, showCategory = 10) +
      ggplot2::ggtitle("GO Enrichment")

    dot_kegg <- clusterProfiler::dotplot(KEGG, showCategory = 10) +
      ggplot2::ggtitle("KEGG Enrichment")

    ggplot2::ggsave("dot_go.png", plot = dot_go, width = 6, height = 4)
    ggplot2::ggsave("dot_kegg.png", plot = dot_kegg, width = 6, height = 4)
  }


  #Cnetplot
  if ("cnetplot" %in% plots){

    GO <- DOSE::setReadable(GO, "org.Hs.eg.db", "ENTREZID")
    cnet_go <- clusterProfiler::cnetplot(GO, showCategory = 5) +
      ggplot2::ggtitle("GO Enrichment Network") +
      ggplot2::theme(plot.title = ggplot2::element_text(color="black", size=20, face="bold.italic"),
                     plot.background = ggplot2::element_rect(fill = "white"))

    KEGG <- DOSE::setReadable(KEGG, "org.Hs.eg.db", "ENTREZID")
    cnet_kegg <- clusterProfiler::cnetplot(KEGG, showCategory = 5) +
      ggplot2::ggtitle("KEGG Enrichment Network") +
      ggplot2::theme(plot.title = ggplot2::element_text(color="black", size=20, face="bold.italic"),
                     plot.background = ggplot2::element_rect(fill = "white"))

    ggplot2::ggsave("cnet_go.png", plot = cnet_go)
    ggplot2::ggsave("cnet_kegg.png", plot = cnet_kegg)
  }

}
