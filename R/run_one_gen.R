#' @title Run the Dam Impact Analysis
#' 
#' @description Use functions from \code{\link{dia}} to simulate one
#' generation of 2 sea-winter female Atlantic salmon through time using data
#' and inputs from Nieland et al. (2013, 2015, 2020) as implemented in `@Risk`.
#' 
#' @param wild_adults Number of starting wild adult salmon.
#' 
#' @param hatchery_adults Number of starting hatchery adult salmon.
#' 
#' @param stocking Number indicating whether hatchery stocking is on (`1`) or
#' off (`0`).
#' 
#' @param n_stocked A vector corresponding to `n_generations` in length 
#' with number of smolts stocked in each generation simulated.
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
#' @param straying_matrix A dataframe identical in structure to the built-in
#' \code{\link{straying_locations}} dataset.
#' 
#' @param p_mainstem_up Probability that fish use the mainstem Penobscot River
#' (and not Stillwater Branch) for upstream migration around Marsh Island.
#'  
#' @param n_broodstock Target number of adult returns collected at Milford Dam 
#' for spawning at US Fish and Wildlife Service Craig Brook National Fish 
#' Hatchery each year. Broodstock are collected upstream of Milford Dam
#' in \code{\link{run_upstream_passage}}.
#' 
#' @return A dataframe containing inputs and outputs. Will add more
#' of an explanation here once we know what they all are.
#' 
#' @references Holbrook et al. (2006); Nieland et al. (2013, 2015, 2020); Stich 
#' et al. (2014, 2015a, 2015b).
#' 
#' @export
#' 
run_one_gen <- function(wild_adults, 
                        hatchery_adults,
                        stocking,
                        n_stocked,
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
                        ){
      
  # Sum wild and hatchery adults 
  adults <- wild_adults + hatchery_adults
  
  # Year 1 Eggs ----
  eggs_per_female <- dia::make_eggs_per_female()
  
  wild_eggs <- as.vector(wild_adults * dia::life_stage_survival[1, 2] +
               hatchery_adults * dia::life_stage_survival[1, 2])
    
  stocked_eggs <- rep(0, length(wild_eggs))
  
  all_eggs <- wild_eggs + stocked_eggs
  
  # Year 4 Smolts ----
  # Starting number based on Year 1 eggs and survival rate
  egg_to_smolt_survival <- make_egg_to_smolt_survival()
  
  wild_smolts <- round(all_eggs * egg_to_smolt_survival, 0)

  stocked_smolts <- round(dia::smolt_stocking(n_stocked) * stocking, 0)
  
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
    stocked_smolts = stocked_smolts,
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
  hatchery_proportions <- downstream_out$hatchery_p_out
  wild_proportions <- downstream_out$wild_p_out
  
  # Year 5 dynamics (Marine) ----
  # Simulate marine survival if not specified by user
  if(is.null(marine_s_hatchery)){
    marine_s_hatchery <- dia::make_marine_s(hatchery = TRUE)
  }
  if(is.null(marine_s_wild)){
    marine_s_wild <- dia::make_marine_s(hatchery = FALSE)
  }
  
  # Apply marine_s to outmigrants to make them adult returns
  hatchery_returns <- round(hatchery_out * marine_s_hatchery, 0)
  wild_returns <- round(wild_out * marine_s_wild, 0)

  # . Upstream migration model ----
  upstream_passage <- unlist(upstream)
  names(upstream_passage) <- NULL  
  
  if(is.null(straying_matrix)){
    straying_matrix <- dia::straying_matrix
  }
  
  if(is.null(inefficiency_matrix)){
    inefficiency_matrix <- dia::inefficiency_matrix
  }  
  
  spawners <- dia::run_upstream_passage(
    hatchery_returns,
    hatchery_proportions,
    wild_returns,
    wild_proportions,
    upstream_passage,
    straying_matrix,
    p_mainstem_up,
    stocking,
    n_broodstock,
    inefficiency_matrix
  )
  
  hatchery_adults <- spawners$hatchery_adults
  wild_adults <- spawners$wild_adults
  
  # Output ----
    return(list(
      n_hatchery = sum(hatchery_adults),
      n_wild = sum(wild_adults),
      hatchery_adults = hatchery_adults,
      wild_adults = wild_adults
    ))

}