#' @title Run the DIA model interactively with shiny
#'
#' @description Run the DIA model interactively in a browser using the shiny
#' package for R. Allows users to view or download summary data from multiple
#' runs of a single scenario.
#' 
#' @seealso run_dia
#'
#' @examples 
#' # To open the shiny user-interface, run the following in R console:
#' # run_dia_shiny()
#'
#' @export
run_dia_shiny <- function() {

  requireNamespace(package = "dplyr")
  requireNamespace(package = "DT")
  requireNamespace(package = "ggplot2")
  
  appDir <- system.file("shiny-examples", "dia_shiny", package = "dia")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `dia`.",
         call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal", launch.browser = TRUE)
}
