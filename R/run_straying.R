#' @title Run adult straying routine
#' 
#' @description Adult straying (homing) routine for Atlantic salmon in
#' the Dam Impact Analysis (DIA) model v67 during year 6.
#' 
#' @param returns Total number of fish returning to river by production unit.
#' 
#' @param straying_matrix A matrix identical in structure to the built-in
#' \code{\link{straying_matrix}} dataset.
#' 
#' @return A vector containing a number of adults of starting total (sum of all
#' 15 production units) that end up in each PU after straying.
#' 
#' @references
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
#' @seealso straying_matrix, straying_locations
#' 
#' @examples 
#' # Run for 10,000 random fish returning to each PU
#' run_straying(returns = rep(1e4, 15), straying_matrix = dia::straying_matrix)
#' 
#' @export
#' 
run_straying <- function(returns, straying_matrix){

  after_straying <- matrix(data = 0, nrow = 15, ncol = 15)
  
  for( i in 1:15 ){
    after_straying[i, ] <- returns[i] * as.vector(straying_matrix[i, ])
  }
  
  destinations <- apply(after_straying, 2, sum)
    
  return(round(destinations, 0))
  
}
