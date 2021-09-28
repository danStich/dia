#' @title Simulate egg-to-smolt survival
#' 
#' @description Simulate egg-to-smolt survival from the built-in
#' \code{\link{life_stage_survival}} dataset using a truncated normal 
#' distribution (Nieland and Sheehan 2020).
#' 
#' @param n Number of samples
#' 
#' @param a Lower limit of truncated normal
#' 
#' @param b Upper limit of truncated normal
#' 
#' @param mean Mean of distribution. When `mean = NULL` (default), the mean
#' value is parameterized from the built-in \code{\link{life_stage_survival}}
#' dataset. Values are based on available studies cited in Nieland and 
#' Sheehan (2020).
#' 
#' @param sd Standard deviation of distribution. When `mean = NULL` (default), 
#' the mean value is parameterized from the built-in
#' \code{\link{life_stage_survival}} dataset (Nieland and Sheehan 2020).
#' 
#' @return A vector of length `n` containing egg-to-smolt survival estimates
#' 
#' @references
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
#' @examples 
#' # 1. Simulate a single value of egg-to-smolt survival ----
#' make_egg_to_smolt_survival() 
#' 
#' # 2. Simulate 10,000 values of egg-to-smolt survival ----
#' samp <- make_egg_to_smolt_survival(n = 1e4)
#' hist(samp)
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
