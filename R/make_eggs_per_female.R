#' @title Simulate eggs per female
#' 
#' @description Simulate number of eggs per adult female based on data
#' collected at the US Fish and Wildlife Service Craig Brook National Fish
#' Hatchery. 
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
#' @references
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
#' @examples
#' # 1. Simulate a single value for eggs per female ----
#' make_eggs_per_female()
#' 
#' # 2. Simulate 10,000 values for eggs per female ----
#' make_eggs_per_female(n = 10000)
#' 
#' @export
#' 
make_eggs_per_female <- function(n = 1, 
                                 a = 4000, 
                                 b = 12000, 
                                 mean = NULL, 
                                 sd = NULL){
  
  if(!is.null(mean) & !is.null(sd)){
    eggs_per_female <- truncnorm::rtruncnorm(
      n = n,
      a = a,
      b = b,
      mean = mean,
      sd = sd)
  }
  if(!is.null(mean) & is.null(sd)){
  eggs_per_female <- truncnorm::rtruncnorm(
      n = n,
      a = a,
      b = b,
      mean = mean,
      sd = dia::life_stage_survival[1, 4])    
  }
  if(is.null(mean) & !is.null(sd)){
  eggs_per_female <- truncnorm::rtruncnorm(
      n = n,
      a = a,
      b = b,
      mean = dia::life_stage_survival[1, 2],
      sd = sd)  
  }  
  if(is.null(mean) & is.null(sd)){
  eggs_per_female <- truncnorm::rtruncnorm(
      n = n,
      a = a,
      b = b,
      mean = dia::life_stage_survival[1, 2],
      sd = dia::life_stage_survival[1, 4])  
  }    
  
  return(round(eggs_per_female, 0))
  
}
