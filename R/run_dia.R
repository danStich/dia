#' @title Run the Dam Impact Analysis
#' 
#' @description Use functions from \code{\link{dia}} to simulate multiple
#' generations of 2 sea-winter female Atlantic salmon through time using data
#' and inputs from Nieland et al. (2013, 2015) and Nieland and Sheehan (2020) 
#' as implemented in `@Risk` add-in for `Excel`. This function is a wrapper for 
#' \code{\link{run_one_gen}} that uses output from one generation as the seed 
#' for user-specified number of subsequent generations.
#' 
#' @param n_generations Number of generations to simulate. One 
#' complete generation from egg to returning adult is six years.
#' 
#' @param n_wild Number of starting wild, adult Atlantic salmon.
#' 
#' @param n_hatchery Number of starting hatchery adult Atlantic salmon.
#' 
#' @param stocking Numeric indicating whether hatchery stocking is on (`1`) or
#' off (`0`). If hatchery stocking is on, then hatchery smolts are stocked into
#' production units based on the \code{proportion_stocked} column in the
#' built-in \code{\link{stocking_default}} dataset.
#' 
#' @param n_stocked A numeric vector corresponding to `n_generations` in length
#' with the number of stocked hatchery smolts per generation.
#' 
#' @param upstream Upstream passage efficiency of adult Atlantic salmon through
#' dams. Default values are based on NMFS (2013) prescriptions as implemented
#' in Nieland and Sheehan (2020). Any numeric value between zero and 1, 
#' inclusive, can be specified for any dam by the user.
#' 
#' @param downstream Downstream survival of Atlantic salmon smolts through dams.
#' The default values are based on the most recent values used by Nieland et al. 
#' (2020) based on standards established in the the NOAA Species Protection Plan
#' following implementation of the Penobscot River Restoration Project.
#' The default `NA` randomly samples correlated survival rates of smolts for 
#' each dam based on cumulative flow probabilities and associated empirical 
#' survival rates (Nieland et al. 2013, Nieland and Sheehan 2020), and can also
#' be used for dams that have a default value other than \code{NA}.
#' 
#' @param in_river_s In-river survival per kilometer for downstream migrating
#' smolts. The default `NA` value simulates from a cumulative distribution 
#' function using values in \code{\link{in_river_m}}. This value is the same
#' for hatchery stocked and wild smolts.
#' 
#' @param mattaceunk_impoundment_mortality Mortality incurred by Atlantic salmon
#' smolts during migration through the Mattaceunk (Weldon) Dam impoundment. The
#' default value is based on Nieland and Sheehan (2020), who used results of 
#' Holbrook et al. (2011) and Stich et al. (2015a).
#' 
#' @param p_stillwater Probability that fish use the Stillwater Branch for 
#' downstream migration. The default (\code{NULL}) draws flow-correlated probability
#' of using the Stillwater Branch from a cumulative distribution of flows with 
#' paired estimates of \code{p_stillwater} used by Nieland and Sheehan (2020), 
#' based on empirical results in Holbrook et al. (2006), Stich et al. (2014), 
#' and Stich et al. (2015a).
#'
#' @param indirect_latent_mortality Indirect, latent mortality incurred by 
#' Atlantic salmon smolts at each dam passed. The default value of \code{0.06}
#' is what was used in Nieland and Sheehan (2020), derived from estimates in 
#' Stich et al. (2015b).
#' 
#' @param p_female Proportion of females in population. Any value between zero
#' and one, inclusive, is allowable.
#' 
#' @param new_or_old A character string indicating whether to use \code{"new"} 
#' (Nieland and Sheehan 2020) or \code{"old"} (Nieland et al. 2013, 2015) 
#' flow-correlated probabilities of \code{p_stillwater} as well as 
#' flow-correlated survival at \code{milford, orono}, and \code{stillwater} dams.
#' 
#' @param marine_s_hatchery Numeric indicating marine survival rate for 
#' post-smolt to adult survival of hatchery outmigrants. The default (`NA`)
#' simulates values from a truncated normal distribution using hatchery smolt
#' survival estimates from the Penobscot River, ME, USA.
#' 
#' @param marine_s_wild Numeric indicating marine survival rate for 
#' post-smolt to adult survival of wild outmigrants during two winters at sea. 
#' The default (`NA`) simulates values from a truncated normal distribution 
#' using wild smolt survival estimates from the Narraguagus River, ME, USA.
#' 
#' @param straying_matrix A dataframe identical in structure to the built-in
#' \code{\link{straying_locations}} dataset. By default, uses the built-in
#' data set to parameterize straying probabilities to destination PUs from 
#' starting PUs.
#' 
#' @param p_mainstem_up Probability that fish use the mainstem Penobscot River
#' (and not Stillwater Branch) for upstream migration around Marsh Island. The 
#' default value `1` was used by Nieland and Sheehan (2020).
#'  
#' @param n_broodstock Target number of adult returns collected at Milford Dam 
#' for spawning at US Fish and Wildlife Service Craig Brook National Fish 
#' Hatchery each year. Broodstock are collected upstream of Milford Dam
#' in \code{\link{run_upstream_passage}} and removed from the population for
#' that generation, as is the case in reality.
#' 
#' @return A dataframe with four variables corresponding to each generation of
#' the simulation. Variables correspond to output from \code{\link{run_one_gen}}.
#' \describe{
#'   \code{production_unit } Production unit \cr \cr
#'   \code{generation } Generation number from simulation \cr \cr
#'   \code{origin } Fish origin (hatchery or wild) \cr \cr
#'   \code{abundance } Fish abundance within production units, generations, and origin
#' }
#' 
#' @references 
#' Holbrook CM, Kinnison MT, Zydlewski J. 2011. Survival of migrating Atlantic 
#' salmon smolts through the Penobscot River, Maine: a prerestoration assessment. 
#' Transactions of the American Fisheries Society 140:1255-1268.
#' 
#' Holbrook CM, Zydlewski J, Gorsky D, Shepard SL, Kinnison MT. 2009. Movements of 
#' prespawn adult Atlantic salmon near hydroelectric dams in the lower Penobscot 
#' River, Maine. North American Journal of Fisheries Management 29:495-505.
#' 
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423-2437. 
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
#' 72:1352-1365.
#' 
#' Stich DS, Bailey MM, Zydlewski JD. 2014. Survival of Atlantic salmon Salmo salar
#' smolts through a hydropower complex. Journal of Fish Biology 85:1074-1096.
#' 
#' Stich DS, Kinnison MT, Kocik JF, Zydlewski JD. 2015b. Initiation of migration 
#' and movement rates of Atlantic salmon smolts in fresh water. Canadian Journal 
#' of Fisheries and Aquatic Sciences 72:1339-1351.
#' 
#' @examples 
#' # Additional examples, including parallel implementation can be found in the
#' # readme file for the GitHub repository for this package: 
#' # https://github.com/danStich/dia.
#' 
#' # 1. Run dia model with defaults for 15 generations ----
#' 
#' result <- run_dia(n_generations = 15)
#' 
#' # 2. Run dia model with user-specified dam passage ----
#' 
#' run_dia(
#'   n_generations = 15,
#'   upstream = list(
#'     medway = 0, 
#'     mattaceunk = 0.9, 
#'     west_enfield = 0.95, 
#'     upper_dover = 0.92, 
#'     browns_mills = 0.92, 
#'     sebec = 0, 
#'     milo = 0, 
#'     howland = 0.95, 
#'     lowel = 0.92,
#'     stillwater = 0, 
#'     milford = 0.95, 
#'     great_works = 1, 
#'     orono = 0, 
#'     veazie = 1, 
#'     frankfort = 1),
#'   downstream = list(
#'   medway = 0, 
#'   mattaceunk = 1, 
#'   west_enfield = 0.96, 
#'   upper_dover = 0.9215, 
#'   browns_mills = 1, 
#'   sebec = 1, 
#'   milo = 1, 
#'   howland = 1, 
#'   lowell = 1,
#'   stillwater = 0.96, 
#'   milford = 0.96, 
#'   great_works = 1, 
#'   orono = 0.96, 
#'   veazie = 1,
#'   frankfort = 1))
#' 
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
                    in_river_s = NA,
                    mattaceunk_impoundment_mortality = 0.072,
                    p_stillwater = NA,
                    indirect_latent_mortality = 0.06,
                    p_female = 0.60,
                    new_or_old = "new",
                    marine_s_hatchery = NA,
                    marine_s_wild = NA,
                    straying_matrix = NULL,
                    p_mainstem_up = 1,
                    n_broodstock = 150
                    ){
  
  # Make sure n_stocked is n_generations long
  if(length(n_stocked) != n_generations){
    stop("error: n_stocked must have n_generations number of elements")
  }
  
  if(is.na(marine_s_hatchery)) marine_s_hatchery <- NULL
  if(is.na(marine_s_wild)) marine_s_wild <- NULL
  # if(is.na(in_river_s)) in_river_s <- NULL
  
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
  g <- 1
  out_list[[1]] <- run_one_gen(wild_adults, 
                       hatchery_adults,
                       stocking,
                       n_stocked = n_stocked[1],
                       upstream,
                       downstream,
                       in_river_s,
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
                           in_river_s,
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
  
  odf <- do.call(rbind, lapply(out_list, data.frame))
  odf$generation <- row.names(odf)
  
  if(n_generations < 100){
    odf$generation <- as.numeric(as.factor(substr(odf$generation, 1, 13)))
  }
  
  if(n_generations >= 100){
    odf$generation <- as.numeric(as.factor(substr(odf$generation, 1, 14)))
  }
  
  row.names(odf) <- seq(1, nrow(odf))
  
  odf <- data.frame(
    tidyr::pivot_longer(odf, 
                        cols = c("hatchery_adults", "wild_adults"), 
                        names_to = "origin", 
                        values_to = "abundance"))
  odf$origin <- gsub("_adults", "", odf$origin)
  odf$abundance[is.na(odf$abundance)] <- 0
  
  return(odf)
  
}