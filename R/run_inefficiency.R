#' @title Run adult passage inefficiency
#' 
#' @description Adult inefficiency (homing) routine for Atlantic salmon that 
#' fail to pass a dam but that also do not die or return to sea.
#' 
#' @param n A vector of length 15 containing total number of fish that failed to
#' pass dams and did not die or return to sea.
#' 
#' @param inefficiency_matrix A matrix identical in structure to the built-in
#' \code{\link{inefficiency_matrix}} dataset (NMFS 2012; Neiland et al. 2013).
#' 
#' @references
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
#' NMFS (National Marine Fisheries Service). 2012. Biological Opinion regarding 
#' effects to the endangered GOM DPS for Atlantic salmon (Salmo salar), endangered 
#' shortnose sturgeon (Acipenser brevirostrum), and the threatened and endangered 
#' DPSs of Atlantic sturgeon (Acipenser oxyrhynchus oxyrhynchus) from proposed 
#' FERC license amendments for Black Bear Hydro Partners’ Hydroelectric Projects 
#' on the Penobscot River in Maine. NMFS Greater Atlantic Regional Office, 
#' Gloucester, MA.
#' 
#' @seealso inefficiency_matrix, upstream_inefficiency
#' 
#' @examples
#' # Simulate 10,000 starting fish at each dam and
#' # randomly sample number of failures for each PU (15 of these)
#' 
#' failures = sample(1e4, 15, replace = TRUE)
#' 
#' # Use run_inefficiency to simulate where these 
#' # failed migrants end up in the watershed based on the 
#' # default inefficiency_matrix in dia.
#' 
#' run_inefficiency(failures, dia::inefficiency_matrix)
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
