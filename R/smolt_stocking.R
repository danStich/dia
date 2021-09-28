#' @title Smolt stocking by production unit
#' 
#' @description Create smolt stocking numbers in each production unit (PU) based
#' on starting number of smolts and proportion of smolts to be stocked in each
#' PU.
#' 
#' @param n_stocked Number of hatchery-reared 2-year smolts to be stocked.
#' 
#' @param stocking_proportions Proportion of total to be stocked in each PU. The
#' values must sum to 1. Default values are based on smolt stocking locations
#' 2008 - 2017 (USASAC 2018).
#' 
#' @return A vector with 15 elements within which positions correspond to PUs
#' as ordered in the \code{link{stocking_default}} dataset. The default (`NULL`)
#' corresponds to default values used in Nieland et al. (2015, 2020).
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
#' USASAC (US Atlantic Salmon Assessment Committee). 2018. Annual Report of the 
#' US Atlantic Salmon Assessment Committee, Report No. 30 - 2017 Activities, 
#' Portland, ME.
#' 
#' @examples
#' # Run stocking routine for 1 million fish with default stocking
#' # proportions based on built-in \code{\link{stocking_default}} data set.
#' smolt_stocking(1e6, stocking_proportions = NULL)
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