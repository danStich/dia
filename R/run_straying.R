#' @title Run adult straying routine
#' 
#' @description Adult straying (homing) routine for Atlantic salmon in
#' the Dam Impact Analysis (DIA) model v67 during year 6.
#' 
#' @param returns Total number of fish returning to river.
#' 
#' @param straying_matrix A matrix identical in structure to the built-in
#' \code{\link{straying_matrix}} dataset.
#' 
#' @references Nieland et al. (2015, 2020).
#' 
#' @seealso straying_matrix, straying_locations
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
