#' @title Run adult straying routine
#' 
#' @description Adult straying (homing) routine for Atlantic salmon in
#' the Dam Impact Analysis (DIA) model v67 during year 6.
#' 
#' @param returns Total number of fish returning to river.
#' 
#' @param straying_matrix A matrix identical in structure to the built-in
#' \code{\link{straying_locations}} matrix.
#' 
#' @references Nieland et al. (2015, 2020).
#' 
#' @seealso straying_locations
#' 
#' @export
#' 
run_straying <- function(returns, straying_matrix){

  after_straying <- vector(
    mode = "numeric", 
    length = nrow(dia::straying_locations))
  
  for( i in 2:(length(returns) + 1) ){
    after_straying[i - 1] <- sum( returns[i - 1] * straying_matrix[, i], na.rm = TRUE )
  }
    
  return(round(after_straying, 0))
  
}











