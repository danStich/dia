#' @title Get dam-specific survival rates
#' 
#' @description Get correlated dam-specific downstream survival rates for 
#' smolts at each dam from built-in `downstream_` datasets. Values based on 
#' Amaral et al. (2012) and sampled following Nieland et al. (2013, 2015) and
#' Nieland and Sheehan (2020).
#' 
#' @param stoch_val Value to be used for a stochastic random draw from 
#' `runif(-stoch_val, stoch_val)` to enforce variability on quantiles used
#' for flow-correlated survival values in the underlying data sets following
#' Nieland and Sheehan (2020).
#' 
#' @param new_or_old A character string indicating whether to use `"new"` 
#' (Amaral et al. 2012, Nieland and Sheehan 2020) or `"old"` (Amaral et al. 2012, 
#' Nieland et al. 2020) flow-correlated probabilities of p_stillwater as well 
#' as flow-correlated survival at `milford`, `orono`, and `stillwater` dams.
#' 
#' @return A vector with dam passage rates 
#' 
#' @references
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Phase 3 Final Report. Alden Research Laboratory, Inc., Holden, MA.
#' 
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
#' @export
#' 
get_dam_passage <- function(stoch_val = 0.1695, new_or_old = "new"){
  
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
    if(!exists("quants")){quants <- stats::runif(1, 0.025, 1)}
    
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