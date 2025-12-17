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
#' @examples
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

    ggplot2::ggsave("dot_go.png", plot = dot_go, width = 10, height = 8, dpi = 300)
    ggplot2::ggsave("dot_kegg.png", plot = dot_kegg, width = 10, height = 8, dpi = 300)
  }


  #Cnetplot
  if ("cnetplot" %in% plots){

    GO <- DOSE::setReadable(GO, "org.Hs.eg.db", "ENTREZID")
    cnet_go <- enrichplot::cnetplot(GO, showCategory = 5) +
      ggplot2::ggtitle("GO Enrichment Network") +
      ggplot2::theme(plot.title = ggplot2::element_text(color="black", size=15, face="bold.italic"),
                     plot.background = ggplot2::element_rect(fill = "white"))

    KEGG <- DOSE::setReadable(KEGG, "org.Hs.eg.db", "ENTREZID")
    cnet_kegg <- enrichplot::cnetplot(KEGG, showCategory = 5) +
      ggplot2::ggtitle("KEGG Enrichment Network") +
      ggplot2::theme(plot.title = ggplot2::element_text(color="black", size=15, face="bold.italic"),
                     plot.background = ggplot2::element_rect(fill = "white"))

    ggplot2::ggsave("cnet_go.png", plot = cnet_go, width = 12, height = 12, dpi = 300)
    ggplot2::ggsave("cnet_kegg.png", plot = cnet_kegg, width = 12, height = 12, dpi = 300)
  }

}
