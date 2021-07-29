#' @title Smolt stocking by production unit
#' 
#' @description Create smolt stocking numbers in each production unit (PU) based
#' on starting number of smolts and proportion of smolts to be stocked in each
#' PU.
#' 
#' @param n_stocked Number of hatchery-reared 2-year smolts to be stocked.
#' 
#' @param stocking_proportions Proportion of total to be stocked in each PU. The
#' values must sum to 1.
#' 
#' @return A vector with 15 elements within which positions correspond to PUs
#' as ordered in the \code{link{stocking_default}} dataset. The default (`NULL`)
#' corresponds to default values used in Nieland et al. (2015, 2020).
#' 
#' @references Nieland et al. (2015, 2020).
#' 
#' @export
#' 
smolt_stocking <- function(n_stocked = 545000, stocking_proportions = NULL){

  if(is.null(stocking_proportions)){
    stocking_proportions <- dia::stocking_default[, 2]
  }
  
  if(sum(stocking_proportions) != 1){
    stop("stocking_proportions must sum to 1")
  }
  
  stocked_smolts <- n_stocked * stocking_proportions
  
  return(stocked_smolts)
  
}