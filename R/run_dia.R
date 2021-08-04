#' @title Run the Dam Impact Analysis
#' 
#' @description Use functions from \code{\link{dia}} to simulate one
#' generation of 2 sea-winter female Atlantic salmon through time using data
#' and inputs from Nieland et al. (2013, 2015) and Nieland and Sheehan (2020) 
#' as implemented in `@Risk` add-on for `Excel`.
#' 
#' @param n_generations Number of generations to simulate for simulation. One 
#' complete generation from egg to returning adult is six years.
#' 
#' @param n_wild Number of starting wild adult salmon.
#' 
#' @param n_hatchery Number of starting hatchery adult salmon.
#' 
#' @param stocking Number indicating whether hatchery stocking is on (`1`) or
#' off (`0`). Will be a vector corresponding to `n_generations` at some point.
#' 
#' @param n_stocked A numeric vector corresponding to `n_generations` in length
#' with number of stocked smolts per generation.
#' 
#' @param upstream Upstream passage efficiency of adult Atlantic salmon through
#' dams. Default values are based on NMFS (2013) prescriptions as implemented
#' in Nieland and Sheehan (2020).
#' 
#' @param downstream Downstream survival of Atlantic salmon smolts through dams.
#' The default values are based on the most recent values used by Nieland et al. 
#' (2020) based on standards established in the the NOAA Species Protection Plan
#' following implementation of the Penobscot River Restoration Project.
#' The default `NULL` randomly samples correlated survival rates of smolts for 
#' each dam based on cumulative flow probabilities and associated empirical 
#' survival rates (Nieland et al. 2013, Nieland and Sheehan 2020).
#' 
#' @param mattaceunk_impoundment_mortality Mortality incurred by Atlantic salmon
#' smolts during migration through the Mattaceunk (Weldon) Dam impoundment. The
#' default value is based on Nieland and Sheehan (2020). Based on results of 
#' Holbrook et al. (2011) and Stich et al. (2015a).
#' 
#' @param p_stillwater Probability that fish use the Stillwater Branch for 
#' downstream migration. The default (`NULL`) draws flow-correlated values from
#' a cumulative distribution of flows with paired estimates of p_stillwater
#' used by Nieland and Sheehan (2020), based on empirical results in Holbrook et al.
#' (2006), Stich et al. (2014), and Stich et al. (2015a).
#'
#' @param indirect_latent_mortality Indirect, latent mortality incurred by 
#' Atlantic salmon smolts at each dam passed. The default value is what was used
#' in Nieland and Sheehan (2020), derived from estimates in Stich et al. (2015b).
#' 
#' @param p_female Proportion of females in population.
#' 
#' @param new_or_old A character string indicating whether to use `"new"` 
#' (Nieland et al. 2013, 2015) or `"old"` (Nieland and Sheehan 2020) flow-correlated
#' probabilities of p_stillwater as well as flow-correlated survival at 
#' `milford`, `orono`, and `stillwater` dams.
#' 
#' @param marine_s_hatchery Numeric indicating marine survival rate for 
#' post-smolt to adult survival of hatchery outmigrants. The default (`NULL`)
#' simulates values from a truncated normal distribution using hatchery smolt
#' survival estimates from the Penobscot River, ME, USA.
#' 
#' @param marine_s_wild Numeric indicating marine survival rate for 
#' post-smolt to adult survival of wild outmigrants. The default (`NULL`)
#' simulates values from a truncated normal distribution using wild smolt
#' survival estimates from the Narraguagus River, ME, USA.
#' 
#' @param straying_matrix A dataframe identical in structure to the built-in
#' \code{\link{straying_locations}} dataset.
#' 
#' @param p_mainstem_up Probability that fish use the mainstem Penobscot River
#' (and not Stillwater Branch) for upstream migration around Marsh Island. The 
#' default value (`NULL`) draws flow-correlated probabilities based on
#' Holbrook et al. (2009).
#'  
#' @param n_broodstock Target number of adult returns collected at Milford Dam 
#' for spawning at US Fish and Wildlife Service Craig Brook National Fish 
#' Hatchery each year. Broodstock are collected upstream of Milford Dam
#' in \code{\link{run_upstream_passage}}.
#' 
#' @return A dataframe containing inputs and outputs. Will add more
#' of an explanation here once we know what they all are.
#' 
#' @references 
#' Holbrook CM, Kinnison MT, Zydlewski J. 2011. Survival of migrating Atlantic 
#' salmon smolts through the Penobscot River, Maine: a prerestoration assessment. 
#' Transactions of the American Fisheries Society 140:1255–1268.
#' 
#' Holbrook CM, Zydlewski J, Gorsky D, Shepard SL, Kinnison MT. 2009. Movements of 
#' prespawn adult Atlantic salmon near hydroelectric dams in the lower Penobscot 
#' River, Maine. North American Journal of Fisheries Management 29:495–505.
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
#' NMFS (National Marine Fisheries Service). 2013. Endangered Species Act 
#' Biological Opinion: FERC amendment of license for the Mattaceunk Project 
#' (Interim Species Protection Plan). NMFS Greater Atlantic Regional Office, 
#' NER-2013-9640, Gloucester, MA.
#' 
#' Stich DS, Bailey MM, Holbrook CM, Kinnison MT, Zydlewski JD. 2015a. 
#' Catchment-wide survival of wild- and hatchery-reared Atlantic salmon smolts in
#' a changing system. Canadian Journal of Fisheries and Aquatic Sciences 
#' 72:1352–1365.
#' 
#' Stich DS, Bailey MM, Zydlewski JD. 2014. Survival of Atlantic salmon Salmo salar
#' smolts through a hydropower complex. Journal of Fish Biology 85:1074–1096.
#' 
#' Stich DS, Kinnison MT, Kocik JF, Zydlewski JD. 2015b. Initiation of migration 
#' and movement rates of Atlantic salmon smolts in fresh water. Canadian Journal 
#' of Fisheries and Aquatic Sciences 72:1339–1351.
#' 
#' @examples 
#' outlist <- run_dia(n_generations = 15)
#' 
#' @export
#' 
run_dia <- function(n_generations = 15,
                    n_wild = 31, 
                    n_hatchery = 306,
                    stocking = 1,
                    n_stocked = rep(545000, 15),
                    upstream = list(
                      medway = 0,
                      mattaceunk = 0.90,
                      west_enfield = 0.95,
                      upper_dover = 0.92,
                      browns_mills = 0.92,
                      sebec = 0,
                      milo = 0,
                      howland = 0.95,
                      lowel = 0.92,
                      stillwater = 0,
                      milford = 0.95,
                      great_works = 1,
                      orono = 0,
                      veazie = 1,
                      frankfort = 1),
                    downstream = list(
                      medway = 0,
                      mattaceunk = 1,
                      west_enfield = 0.96,
                      upper_dover = 0.9215,
                      browns_mills = NA,
                      sebec = NA,
                      milo = NA,
                      howland = 1,
                      lowell = NA,
                      stillwater = 0.96,
                      milford = 0.96,
                      great_works = 1,
                      orono = 0.96,
                      veazie = 1,
                      frankfort = NA),
                    mattaceunk_impoundment_mortality = 0.072,
                    p_stillwater = NULL,
                    indirect_latent_mortality = 0.06,
                    p_female = 0.60,
                    new_or_old = "new",
                    marine_s_hatchery = NULL,
                    marine_s_wild = NULL,
                    straying_matrix = NULL,
                    p_mainstem_up = 1,
                    n_broodstock = 150
                    ){
  
  # Make sure n_stocked is n_generations long
  if(length(n_stocked) != n_generations){
    stop("error: n_stocked must have n_generations number of elements")
  }
  
  # Seed starting population ---- 
  # Multinomial draw to distribute wild adults in PUs
  wild_adults <- as.vector(stats::rmultinom(
    n = 1, 
    size = n_wild, 
    prob = dia::production_units$Proportion_of_HUs_in_scenario))
  
  # Multinomial draw to distribute hatchery adults in PUs
  hatchery_adults <- as.vector(stats::rmultinom(
    n = 1, 
    size = n_hatchery, 
    prob = dia::production_units$Proportion_of_HUs_in_scenario) )
  
  # Run one generation of the model ----
  out_list <- vector(mode = "list", length = n_generations)
  out_list[[1]] <- run_one_gen(wild_adults, 
                       hatchery_adults,
                       stocking,
                       n_stocked = n_stocked[1],
                       upstream,
                       downstream,
                       mattaceunk_impoundment_mortality,
                       p_stillwater,
                       indirect_latent_mortality,
                       p_female,
                       new_or_old,
                       marine_s_hatchery,
                       marine_s_wild,
                       straying_matrix,
                       p_mainstem_up,
                       n_broodstock
                       )
    if(n_generations > 1){
      for(g in 2:n_generations){
        out_list[[g]] <- run_one_gen(
                           wild_adults = out_list[[g - 1]]$wild_adults, 
                           hatchery_adults = out_list[[g - 1]]$hatchery_adults,
                           stocking,
                           n_stocked = n_stocked[g],
                           upstream,
                           downstream,
                           mattaceunk_impoundment_mortality,
                           p_stillwater,
                           indirect_latent_mortality,
                           p_female,
                           new_or_old,
                           marine_s_hatchery,
                           marine_s_wild,
                           straying_matrix,
                           p_mainstem_up,
                           n_broodstock
                           )
      }
    }
    
  if(n_generations < 100){
    names(out_list) <- paste0("generation_", sprintf("%02d", 1:length(out_list)))
  }
  if(n_generations >= 100){
    names(out_list) <- paste0("generation_", sprintf("%03d", 1:length(out_list)))
  }
  
  n_wild_start = n_wild
  n_hatchery_start = n_hatchery
  n_wild_end = out_list[[length(out_list)]]$n_wild
  n_hatchery_end = out_list[[length(out_list)]]$n_hatchery
  
  if(is.na(n_wild_end)) n_wild_end <- 0
  if(is.na(n_hatchery_end)) n_hatchery_end <- 0
  
  out_df <- data.frame(n_wild = n_wild_end, 
                       n_hatchery = n_hatchery_end)
  
  return(out_df)
  
}