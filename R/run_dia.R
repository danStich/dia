#' @title Run the Dam Impact Analysis
#' 
#' @description Use functions from \code{\link{dia}} to simulate
#' cohorts of 2 sea-winter female Atlantic salmon through time using data
#' and inputs from Nieland et al. (2013, 2015, 2020) as implemented in `@Risk`.
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
#' @param n_stocked Number of fish to be stocked. Will also be a vector 
#' corresponding to `n_generations` in length at some point.
#' 
#' @param upstream Upstream passage efficiency of adult Atlantic salmon through
#' dams.
#' 
#' @param downstream Downstream survival of Atlantic salmon smolts through dams.
#' The default values are based on the most recent values used by Nieland et al. 
#' (2020) based on standards established in the the NOAA Species Protection Plan
#' following implementation of the Penobscot River Restoration Project.
#' The default `NULL` randomly samples correlated survival rates of smolts for 
#' each dam based on cumulative flow probabilities and associated empirical 
#' survival rates (Nieland et al. 2013, 2020).
#' 
#' @param mattaceunk_impoundment_mortality Mortality incurred by Atlantic salmon
#' smolts during migration through the Mattaceunk (Weldon) Dam impoundment. The
#' default value is based on Nieland et al. (2020). Based on results of 
#' Holbrook et al. (2011) and Stich et al. (2015a).
#' 
#' @param p_stillwater Probability that fish use the Stillwater Branch for 
#' downstream migration. The default (`NULL`) draws flow-correlated values from
#' a cumulative distribution of flows with paired estimates of p_stillwater
#' used by Nieland et al. (2020), based on empirical results in Holbrook et al.
#' (2006), Stich et al. (2014), and Stich et al. (2015a).
#' 
#' @param indirect_latent_mortality Indirect, latent mortality incurred by 
#' Atlantic salmon smolts at each dam passed. The default value is what was used
#' in Nieland et al. (2020), derived from estimates in Stich et al. (2015b).
#' 
#' @param p_female Proportion of females in population.
#' 
#' @param new_or_old A character string indicating whether to use `"new"` 
#' (Nieland et al. 2013, 2015) or `"old"` (Nieland et al. 2020) flow-correlated
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
#' @return A dataframe containing inputs and outputs. Will add more
#' of an explanation here once we know what they all are.
#' 
#' @references Holbrook et al. (2006); Nieland et al. (2013, 2015, 2020); Stich 
#' et al. (2014, 2015a, 2015b).
#' 
#' @export
#' 
run_dia <- function(n_generations = 1,
                    n_wild = 31, 
                    n_hatchery = 306,
                    stocking = 1,
                    n_stocked = 545000,
                    upstream = list(
                      medway = 1,
                      mattaceunk = 1,
                      west_enfield = 1,
                      upper_dover = 1,
                      browns_mills = 1,
                      sebec = 1,
                      milo = 1,
                      howland = 1,
                      lowel = 1,
                      stillwater = 1,
                      milford = 1,
                      great_works = 1,
                      orono = 1,
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
                      lowel = NA,
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
                    marine_s_wild = NULL
                    ){
  
  # Year 1 Adults ---- 
  # Multinomial draw to distribute wild adults in PUs
  wild_adults <- stats::rmultinom(
    n = 1, 
    size = n_wild, 
    prob = dia::production_units$Proportion_of_HUs_in_scenario)
  
  # Multinomial draw to distribute hatchery adults in PUs
  hatchery_adults <- stats::rmultinom(
    n = 1, 
    size = n_hatchery, 
    prob = dia::production_units$Proportion_of_HUs_in_scenario) 
  
  # Sum wild and hatchery adults 
  adults <- wild_adults + hatchery_adults
  
  # Year 1 Eggs ----
  eggs_per_female <- dia::make_eggs_per_female()
  
  wild_eggs <- as.vector(wild_adults * dia::life_stage_survival[1, 2] +
               hatchery_adults * dia::life_stage_survival[1, 2])
    
  hatchery_eggs <- rep(0, length(wild_eggs))
  
  all_eggs <- wild_eggs + hatchery_eggs
  
  # Year 4 Smolts ----
  # Starting number based on Year 1 eggs and survival rate
  egg_to_smolt_survival <- make_egg_to_smolt_survival()
  
  wild_smolts <- wild_eggs * egg_to_smolt_survival
  
  hatchery_smolts <- round(hatchery_eggs * egg_to_smolt_survival, 0)
  
  stocked_smolts <- round(dia::smolt_stocking(n_stocked) * stocking, 0)
  
  hatchery_smolt_total <- hatchery_smolts + stocked_smolts
  
  # . Downstream migration ----
  # Get user-specified and/or Alden estimated downstream survival
  # of smolts through dams
  # Make the user-specified list into a vector
  downstream_passage <- unlist(downstream)
  # Get flow-correlated survival values for each dam and probability of
  # using Stillwater Branch
  dam_stuff <- dia::get_dam_passage(new_or_old = "new")
  dam_survival <- dam_stuff$dam_survival
  if(is.null(p_stillwater)) p_stillwater <- dam_stuff$p_stillwater
    
  # Replace any NA values with the flow-correlated survival values
  downstream_passage[is.na(downstream_passage)] <- dam_survival[is.na(downstream_passage)]
  names(downstream_passage) <- NULL
  
  
  # Run the downstream_passage module
  downstream_out <- dia::run_downstream_passage(
    hatchery_smolt_total = hatchery_smolt_total,
    wild_smolts = wild_smolts,
    downstream_passage = downstream_passage,
    p_stillwater = p_stillwater,
    mattaceunk_impoundment_mortality = mattaceunk_impoundment_mortality,
    n_dams = dia::n_dams,
    indirect_latent_mortality = indirect_latent_mortality,
    p_female = p_female
    )
  
  hatchery_out <- downstream_out$hatchery_out
  wild_out <- downstream_out$wild_out
  hatchery_p_out <- downstream_out$hatchery_p_out
  wild_p_out <- downstream_out$wild_p_out
  
  # Year 5 dynamics (Marine) ----
  # Simulate marine survival if not specified by user
  if(is.null(marine_s_hatchery)){
    marine_s_hatchery <- dia::make_marine_s(hatchery = TRUE)
  }
  if(is.null(marine_s_wild)){
    marine_s_wild <- dia::make_marine_s(hatchery = FALSE)
  }
  
  # Apply marine_s to outmigrants to make them adult returns
  hatchery_returns <- hatchery_out * marine_s_hatchery
  wild_returns <- wild_out * marine_s_wild
  
  
  
  # . Upstream migration model ----
  
  
  
  
  
  
  
}