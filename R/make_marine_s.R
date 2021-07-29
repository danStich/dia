#' @title Simulate marine survival
#' 
#' @description Simulate marine survival from the built-in
#' \code{\link{life_stage_survival}} dataset using a truncated normal 
#' distribution.
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
#' @references Nieland et al. (2020)
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

  return(marine_s)
  
}
