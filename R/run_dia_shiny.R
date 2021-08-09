#' @title Run the DIA model interactively with shiny
#'
#' @description Run the DIA model interactively in a browser using the shiny
#' package for R. Allows users to view or download summary data from multiple
#' runs of a single scenario.
#' 
#' @seealso run_dia
#'
#' @export
run_dia_shiny <- function() {
  appDir <- system.file("shiny-examples", "dia_shiny", package = "dia")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `dia`.",
         call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal", launch.browser = TRUE)
}
