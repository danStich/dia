#' @title Run adult passage inefficiency
#' 
#' @description Adult inefficiency (homing) routine for Atlantic salmon that 
#' fail to pass a dam but that also do not die or return to sea.
#' 
#' @param n A vector of length 15 Total number of fish that failed to pass dams 
#' and did not die or return to sea.
#' 
#' @param inefficiency_matrix A matrix identical in structure to the built-in
#' \code{\link{inefficiency_matrix}} dataset.
#' 
#' @references Nieland et al. (2015, 2020).
#' 
#' @seealso inefficiency_matrix, upstream_inefficiency
#' 
#' @export
#' 
run_inefficiency <- function(n, inefficiency_matrix){

  after_failure <- matrix(data = 0, nrow = 15, ncol = 15)
  
  for( i in 1:15 ){
    after_failure[i, ] <- n[i] * as.vector(inefficiency_matrix[i, ])
  }
  
  destinations <- apply(after_failure, 2, sum)
    
  return(round(destinations, 0))
  
}
