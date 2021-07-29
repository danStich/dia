#' @title Get dam-specific survival rates
#' 
#' @description Get correlated dam-specific downstream survival rates for 
#' smolts at each dam from built-in `downstream_` datasets.
#' 
#' @param stoch_val Value to be used for a stochastic random draw from 
#' `runif(-stoch_val, stoch_val)` to enforce variability on quantiles used
#' for flow-correlated survival values in the underlying data sets following
#' Nieland et al. (2020).
#' 
#' @param new_or_old A character string indicating whether to use `"new"` 
#' (Nieland et al. 2013, 2015) or `"old"` (Nieland et al. 2020) flow-correlated
#' probabilities of p_stillwater as well as flow-correlated survival at 
#' `milford`, `orono`, and `stillwater` dams.
#' 
#' @return A vector with dam passage rates 
#' 
#' @references Nieland et al. (2013, 2020).
#' 
#' @export
#' 
get_dam_passage <- function(stoch_val = 0.1695, new_or_old){
  
    # Draw from a uniform based on Downstream Lookup in Model67.xlsx
    stoch_param <- stats::runif(1, -stoch_val, stoch_val)
    
    # Random value between zero and one to be combined with previous
    # also based on Downstream Lookup in Model67.xlsx
    random_val <- stats::runif(1, 0, 1)
    
    # Threshold value for choosing correlated flow values
    threshold <- round(stoch_param + random_val, 4)
    
    # Compare threshold value to lower threshold and 1 (upper)
    # Use the randomly drawn threshold value to select flow-contingent
    # smolt survival at each dam if the value is within these bounds
    if(threshold < 0.0025){quants <- 0.0025}
    if(threshold > 1){quants <- 1}
    if(threshold >= 0.025 & threshold <= 1){quants <- threshold}
    
    # Extract correlated flow-contingent survival rates
    dam_survival <- c(
      dia::downstream_medway[min(which(dia::downstream_medway$cumulative_prob >= quants)),4],
      dia::downstream_mattaceunk[min(which(dia::downstream_mattaceunk$cumulative_prob >= quants)),4],
      dia::downstream_westenfield[min(which(dia::downstream_westenfield$cumulative_prob >= quants)),4],
      dia::downstream_moosehead[min(which(dia::downstream_moosehead$cumulative_prob >= quants)),4],
      dia::downstream_brownsmills[min(which(dia::downstream_brownsmills$cumulative_prob >= quants)),4],
      dia::downstream_sebec[min(which(dia::downstream_sebec$cumulative_prob >= quants)),4],
      dia::downstream_milo[min(which(dia::downstream_milo$cumulative_prob >= quants)),4],
      dia::downstream_howland[min(which(dia::downstream_howland$cumulative_prob >= quants)),4],
      dia::downstream_lowell[min(which(dia::downstream_lowell$cumulative_prob >= quants)),4],
      dia::downstream_stillwater[min(which(dia::downstream_stillwater$cumulative_prob >= quants)),4],
      dia::downstream_milford[min(which(dia::downstream_milford$cumulative_prob >= quants)),4],
      dia::downstream_greatworks[min(which(dia::downstream_greatworks$cumulative_prob >= quants)),4],
      dia::downstream_orono[min(which(dia::downstream_orono$cumulative_prob >= quants)),4],
      dia::downstream_veazie[min(which(dia::downstream_veazie$cumulative_prob >= quants)),4],
      dia::downstream_frankfort[min(which(dia::downstream_frankfort$cumulative_prob >= quants)),4]
    )
    
    p_stillwater <- dia::stillwater_use$proportion[min(which(dia::stillwater_use >= quants))]
    
    if(new_or_old == "old"){
      dam_survival[10] <- dia::downstream_stillwater_old[min(which(dia::downstream_stillwater_old$cumulative_prob >= quants)),4]
      dam_survival[11] <- dia::downstream_milford_old[min(which(dia::downstream_milford_old$cumulative_prob >= quants)),4]
      dam_survival[13] <- dia::downstream_orono_old[min(which(dia::downstream_orono_old$cumulative_prob >= quants)),4]
      p_stillwater <- dia::stillwater_use_old$proportion[min(which(dia::stillwater_use_old >= quants))]
    }
      
  return(list(dam_survival = dam_survival, p_stillwater = p_stillwater))
  
}