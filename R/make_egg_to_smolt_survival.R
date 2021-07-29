#' @title Simulate egg-to-smolt survival
#' 
#' @description Simulate egg-to-smolt survival from the built-in
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
#' @return A vector of length `n`
#' 
#' @references Nieland et al. (2020)
#' 
#' @export
#' 
make_egg_to_smolt_survival <- function(n = 1, 
                                       a = 0, 
                                       b = 0.023, 
                                       mean = NULL, 
                                       sd = NULL){
  
  if(!is.null(mean) & !is.null(sd)){
    egg_to_smolt_survival <- truncnorm::rtruncnorm(
      n = n,
      a = a,
      b = b,
      mean = mean,
      sd = sd)
  }
  if(!is.null(mean) & is.null(sd)){
  egg_to_smolt_survival <- truncnorm::rtruncnorm(
      n = n,
      a = a,
      b = b,
      mean = mean,
      sd = dia::life_stage_survival[2, 4])    
  }
  if(is.null(mean) & !is.null(sd)){
  egg_to_smolt_survival <- truncnorm::rtruncnorm(
      n = n,
      a = a,
      b = b,
      mean = dia::life_stage_survival[2, 2],
      sd = sd)  
  }  
  if(is.null(mean) & is.null(sd)){
  egg_to_smolt_survival <- truncnorm::rtruncnorm(
      n = n,
      a = a,
      b = b,
      mean = dia::life_stage_survival[2, 2],
      sd = dia::life_stage_survival[2, 4])  
  }    
  
  return(egg_to_smolt_survival)
  
}
