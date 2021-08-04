#' @title Simulate marine survival
#' 
#' @description Simulate marine survival from the built-in
#' \code{\link{life_stage_survival}} dataset using a truncated normal 
#' distribution (Nieland and Sheehan 2020). For hatchery fish, smolt survival 
#' is based on empirical results from Stich et al. (2015a, 2015c) and adult
#' returns based on MDMR (2018). For wild fish, estimate is based on
#' smolt-to-adult returns in the Narraguagus River (USASAC 2018).
#' 
#' @param n Number of samples
#' 
#' @param a Lower limit of truncated normal
#' 
#' @param b Upper limit of truncated normal
#' 
#' @param mean Mean of distribution. When `mean = NULL` (default), the mean
#' value is parameterized from the built-in \code{\link{life_stage_survival}}
#' dataset. 
#' 
#' @param sd Standard deviation of distribution. When `mean = NULL` (default), 
#' the mean value is parameterized from the built-in
#'  \code{\link{life_stage_survival}} dataset.
#'  
#' @param hatchery A logical indicating whether the estimate is
#' for hatchery-reared fish (`TRUE`) or wild fish (`FALSE`).
#' 
#' @return A vector of length `n`
#' 
#' @references
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
#' Stich DS, Bailey MM, Holbrook CM, Kinnison MT, Zydlewski JD. 2015a. 
#' Catchment-wide survival of wild- and hatchery-reared Atlantic salmon smolts in
#' a changing system. Canadian Journal of Fisheries and Aquatic Sciences 
#' 72:1352–1365.
#'  
#' Stich DS, Zydlewski GB, Kocik JF, Zydlewski JD. 2015c. Linking behavior, 
#' physiology, and survival of Atlantic salmon smolts during estuary migration. 
#' Marine and Coastal Fisheries 7:68–86.  
#'  
#' USASAC (US Atlantic Salmon Assessment Committee). 2018. Annual Report of the 
#' US Atlantic Salmon Assessment Committee, Report No. 30 - 2017 Activities, 
#' Portland, ME.
#'  
#' @export
#' 
make_marine_s <- function(n = 1, 
                          a = 0, 
                          b = 0.25, 
                          mean = NULL, 
                          sd = NULL,
                          hatchery
                          ){
  
  if(hatchery == TRUE){
    if(!is.null(mean) & !is.null(sd)){
      marine_s <- truncnorm::rtruncnorm(
        n = n,
        a = a,
        b = b,
        mean = mean,
        sd = sd)
    }
    if(!is.null(mean) & is.null(sd)){
    marine_s <- truncnorm::rtruncnorm(
        n = n,
        a = a,
        b = b,
        mean = mean,
        sd = dia::life_stage_survival[4, 4])    
    }
    if(is.null(mean) & !is.null(sd)){
    marine_s <- truncnorm::rtruncnorm(
        n = n,
        a = a,
        b = b,
        mean = dia::life_stage_survival[4, 2],
        sd = sd)  
    }  
    if(is.null(mean) & is.null(sd)){
    marine_s <- truncnorm::rtruncnorm(
        n = n,
        a = a,
        b = b,
        mean = dia::life_stage_survival[4, 2],
        sd = dia::life_stage_survival[4, 4])  
    }    
  }
  
  if(hatchery == FALSE){
    if(!is.null(mean) & !is.null(sd)){
      marine_s <- truncnorm::rtruncnorm(
        n = n,
        a = a,
        b = b,
        mean = mean,
        sd = sd)
    }
    if(!is.null(mean) & is.null(sd)){
    marine_s <- truncnorm::rtruncnorm(
        n = n,
        a = a,
        b = b,
        mean = mean,
        sd = dia::life_stage_survival[5, 4])    
    }
    if(is.null(mean) & !is.null(sd)){
    marine_s <- truncnorm::rtruncnorm(
        n = n,
        a = a,
        b = b,
        mean = dia::life_stage_survival[5, 2],
        sd = sd)  
    }  
    if(is.null(mean) & is.null(sd)){
    marine_s <- truncnorm::rtruncnorm(
        n = n,
        a = a,
        b = b,
        mean = dia::life_stage_survival[5, 2],
        sd = dia::life_stage_survival[5, 4])  
    }    
  }  

  return(marine_s)
  
}
