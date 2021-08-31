#' @title Run downstream passage routine
#' 
#' @description Run the downstream passage routine for Atlantic salmon Dam
#' Impact Analysis (DIA) model v67.
#' 
#' @param stocked_smolts Number of hatchery smolts stocked by PU.
#' 
#' @param wild_smolts Number of wild-reared smolts.
#' 
#' @param downstream_passage Numeric vector with length = 15 corresponding to
#' dam passage efficiencies at each of 15 dams in the watershed that are used 
#' to delineate PUs. Default usage is to inherit these values from the 
#' \code{link{run_dia}} function.
#' 
#' @param p_stillwater Probability that fish use the Stillwater Branch for 
#' downstream migration. Default usage is to inherit this value from the 
#' \code{link{run_dia}} function.
#' 
#' @param mattaceunk_impoundment_mortality Mortality incurred by Atlantic salmon
#' smolts during migration through the Mattaceunk (Weldon) Dam impoundment. 
#' Default usage is to inherit these values from the \code{link{run_dia}} 
#' function.
#' 
#' @param n_dams A dataframe with structure identical to the built-in
#' \code{link{n_dams}} data set.
#' 
#' @param indirect_latent_mortality Indirect, latent mortality incurred by 
#' Atlantic salmon smolts at each dam passed. Default usage is to inherit this value from the 
#' \code{link{run_dia}} function.
#' 
#' @param p_female Proportion of females in population. Default usage is to 
#' inherit this value from the \code{link{run_dia}} function.
#' 
#' @return A named list with four elements including total number of hatchery and
#' wild smolts exiting the Penobscot River (elements 1 & 2) as well as the 
#' proportion of wild and hatchery smolts exiting the river from each natal PU.
#' 
#' @references Nieland et al. (2015, 2020).
#' 
#' @seealso run_dia, n_dams
#' 
#' @export
#' 
run_downstream_passage <- function(stocked_smolts,
                                   wild_smolts,
                                   downstream_passage,
                                   p_stillwater,
                                   mattaceunk_impoundment_mortality,
                                   n_dams,
                                   indirect_latent_mortality,
                                   p_female,
                                   in_river_s
                                   ){

  if(is.na(in_river_s)) {
    m <- NULL
  } else {
    m <- 1 - in_river_s
  }
  # Initial and subsequent reach survival rates for smolts ----
  #. Hatchery stocking survival rates by PU ----
  hatchery_init <- dia::make_inriver_s(m = m,
                                  initial = TRUE,
                                  hatchery_wild = "hatchery")

  # . Initial wild survival rates by PU using longest_segment_length/2 ----
  wild_init <- dia::make_inriver_s(m = m,
                                   initial = TRUE,
                                   hatchery_wild = "wild")
  
  # . Subsequent survival rates for partial-segment migrants ----
  subseq <- dia::make_inriver_s(m = m, initial = FALSE)
  alt_1 <- dia::make_inriver_s(m = m, initial = FALSE, alt = 1)
  alt_2 <- dia::make_inriver_s(m = m, initial = FALSE, alt = 2)
  
  # . Mattaceunk impoundment survival based on user-specified value ----
  mattaceunk_imp_s <- (1 - mattaceunk_impoundment_mortality)
  
  # Upper Mainstem production units ----
  # . Production unit 1 dynamics ----
  hatchery_after_inriver_PU01 <- round(stocked_smolts[1] * hatchery_init[1], 0)
  wild_after_inriver_PU01 <- round(wild_smolts[1] * wild_init[1], 0)

  # . Production unit 2 dynamics ----
  # Medway dam
  hatchery_after_medway <- round(hatchery_after_inriver_PU01 * 
                                   downstream_passage[1], 0)
  wild_after_medway <- round(wild_after_inriver_PU01 * downstream_passage[1], 0)

  hatchery_after_inriver_PU02 <- c(
    round(hatchery_after_medway * alt_1[2], 0),
    round(stocked_smolts[2] * hatchery_init[2], 0)
    )

  wild_after_inriver_PU02 <- c(
    round(wild_after_medway * alt_1[2], 0),
    round(wild_smolts[2] * wild_init[2], 0)
    )    
  
  hatchery_after_impoundment_PU02 <- c(
    round(hatchery_after_inriver_PU02[1] * mattaceunk_imp_s, 0),
    round(hatchery_after_inriver_PU02[2] * mattaceunk_imp_s, 0)
    )

  wild_after_impoundment_PU02 <- c(
    round(wild_after_inriver_PU02[1] * mattaceunk_imp_s, 0),
    round(wild_after_inriver_PU02[2] * mattaceunk_imp_s, 0)
    )    
  
  hatchery_after_mattaceunk <- c(
    round(hatchery_after_impoundment_PU02 * downstream_passage[2], 0))

  wild_after_mattaceunk <- c(
    round(wild_after_impoundment_PU02 * downstream_passage[2], 0))
  
  # . Production unit 3 dynamics ----
  hatchery_after_inriver_PU03 <- c(
    round(hatchery_after_mattaceunk * alt_1[3], 0),
    round(stocked_smolts[3] * hatchery_init[3])
  )
  
  wild_after_inriver_PU03 <- c(
    round(wild_after_mattaceunk * alt_1[3]),
    round(wild_smolts[3] * wild_init[3])
  )
  
  hatchery_after_enfield <- round(
    hatchery_after_inriver_PU03 * downstream_passage[3], 0)
  
  wild_after_enfield <- round(
    wild_after_inriver_PU03 * downstream_passage[3], 0)
  
  # Upper Piscataquis River Production units ----
  # . Production unit 6 dynamics ----
  hatchery_after_inriver_PU06 <- c(
    0, 0, 0, # PUs 1-3 should be blank so these align later
    round(stocked_smolts[4] * hatchery_init[4], 0)
  )
  
  wild_after_inriver_PU06 <- c(
    0, 0, 0,
    round(wild_smolts[4] * wild_init[4], 0)
  )
  
  hatchery_after_upper_dover <- round(
    hatchery_after_inriver_PU06 * downstream_passage[4], 0
  )
  
  wild_after_upper_dover <- round(
    wild_after_inriver_PU06 * downstream_passage[4], 0
  )
  
  # . Production unit 5 dynamics ----
  hatchery_after_inriver_PU05 <- c(
    round(hatchery_after_upper_dover * alt_1[5], 0),
    round(stocked_smolts[5] * hatchery_init[5], 0)
  )
  
  wild_after_inriver_PU05 <- c(
    round(wild_after_upper_dover * alt_1[5], 0),
    round(wild_smolts[5] * wild_init[5], 0)
  )  
  
  hatchery_after_brownsmills <- round(
    hatchery_after_inriver_PU05 * downstream_passage[5], 0
  )
  
  wild_after_brownsmills <- round(
    wild_after_inriver_PU05 * downstream_passage[5], 0
  )  
  
  
  # Sebec River production units ----
  # . Production unit 8 dynamics ----
  hatchery_after_inriver_PU08 <- c(
    0, 0, 0, 0, 0,
    round(stocked_smolts[6] * hatchery_init[6], 0)
  )
  
  wild_after_inriver_PU08 <- c(
    0, 0, 0, 0, 0,
    round(wild_smolts[6] * wild_init[6], 0)
  )
    
  hatchery_after_sebec <- round(
    hatchery_after_inriver_PU08 * downstream_passage[6], 0
  )
  
  wild_after_sebec <- round(
    wild_after_inriver_PU08 * downstream_passage[6], 0
  )  
  
  # . Production unit 7 dynamics ----
  hatchery_after_inriver_PU07 <- c(
    round(hatchery_after_inriver_PU08 * subseq[7], 0),
    round(stocked_smolts[7] * hatchery_init[7], 0)
  )
  
  wild_after_inriver_PU07 <- c(
    round(wild_after_inriver_PU08 * subseq[7], 0),
    round(wild_smolts[7] * wild_init[7], 0)
  )  
  
  hatchery_after_milo <- round(
    hatchery_after_inriver_PU07 * downstream_passage[7], 0
  )
  
  wild_after_milo <- round(
    wild_after_inriver_PU07 * downstream_passage[7], 0
  )  
  
  # Lower Piscataquis River Production Units ----
  # . Production unit 4 dynamics ----
  # Add two zeros to the end of the brownsmills vectors
  # to make them same length as milo vectors so we can 
  # just do vector math to combine routes
  hatchery_after_brownsmills[6:7] <- 0
  wild_after_brownsmills[6:7] <- 0
  
  hatchery_after_inriver_PU04 <- 
    c(round(hatchery_after_brownsmills * alt_2[8], 0)+
      round(hatchery_after_milo * alt_1[8], 0),
      round(stocked_smolts[8] * hatchery_init[8], 0)
    )

  wild_after_inriver_PU04 <- 
    c(round(wild_after_brownsmills * alt_2[8], 0)+
      round(wild_after_milo * alt_1[8], 0),
      round(wild_smolts[8] * wild_init[8], 0)
    )
    
  hatchery_after_howland <- round(
    hatchery_after_inriver_PU04 * downstream_passage[8], 0
  )
  
  wild_after_howland <- round(
    wild_after_inriver_PU04 * downstream_passage[8], 0
  )  
  
  # Passadumkeag River dynamics ----
  # . Production Unit 15 dynamics ----
  hatchery_after_inriver_PU15 <- c(
    rep(0, 8),
    stocked_smolts[9] * hatchery_init[9]
  )
  
  wild_after_inriver_PU15 <- c(
    rep(0, 8),
    wild_smolts[9] * wild_init[9]
  )
  
  # . Lowell Tannery Dam ----
  hatchery_after_lowell <- round(
    hatchery_after_inriver_PU15 * downstream_passage[9], 0
  )
  
  wild_after_lowell <- round(
    wild_after_inriver_PU15 * downstream_passage[9], 0
  )  
  
  # Middle Penobscot River dynamics ----
  hatchery_after_howland[9] <- 0
  wild_after_howland[9] <- 0
  
  hatchery_after_inriver_PU09 <- c(
    round(hatchery_after_howland * alt_1[10], 0) +
    round(hatchery_after_lowell * alt_2[10], 0),
    round(stocked_smolts[10] * hatchery_init[10], 0)
  )
  
  wild_after_inriver_PU09 <- c(
    round(wild_after_howland * alt_1[10], 0) +
    round(wild_after_lowell * alt_2[10], 0),
    round(wild_smolts[10] * wild_init[10], 0)
  )  
  
  # Stillwater Branch use and split ----
  # . Stillwater use assignment ----
  hatchery_through_stillwater <- round(
    hatchery_after_inriver_PU09 * p_stillwater, 0
  )
  
  hatchery_through_mainstem <- hatchery_after_inriver_PU09 - 
    hatchery_through_stillwater
  
  wild_through_stillwater <- round(
    wild_after_inriver_PU09 * p_stillwater, 0
  )
  
  wild_through_mainstem <- wild_after_inriver_PU09 - wild_through_stillwater
  
  # . Stillwater Dam (Stillwater Branch) ----
  hatchery_after_stillwater <- c(
    round(hatchery_through_stillwater * downstream_passage[10], 0),
    0
  )  
  wild_after_stillwater <- c(
    round(wild_through_stillwater * downstream_passage[10], 0),
    0
  )  
  
  # . Milford Dam ----
  hatchery_after_milford <- round(
    hatchery_through_mainstem * downstream_passage[11], 0
  )

  wild_after_milford <- round(
    wild_through_mainstem * downstream_passage[11], 0
  )  
  
  # . Production unit 10 (mainstem) dynamics ----
  hatchery_after_inriver_PU10 <- c(
    round(hatchery_after_milford * subseq[11], 0),
    round(stocked_smolts[11] * hatchery_init[11], 0)
  )
  
  wild_after_inriver_PU10 <- c(
    round(wild_after_milford * subseq[11], 0),
    round(wild_smolts[11] * wild_init[11], 0))
  
  # . Greatworks Dam (mainstem) ----
  hatchery_after_greatworks <- round(
    hatchery_after_milford * downstream_passage[12], 0
  )
  
  wild_after_greatworks <- round(
    wild_after_milford * downstream_passage[12], 0
  )      
  
  # . Production unit 11 (Stillwater Branch) dynamics ----
  hatchery_after_inriver_PU11 <- c(
    round(hatchery_after_stillwater * subseq[12], 0),
    round(stocked_smolts[12] * hatchery_init[12], 0)
  )  
  
  wild_after_inriver_PU11 <- c(
    round(wild_after_stillwater * subseq[12], 0),
    round(wild_smolts[12] * wild_init[12], 0)
  )
  
  # . Orono Dam (Stillwater Branch) ----
  hatchery_after_orono <- round(
    hatchery_after_inriver_PU11 * downstream_passage[13], 0
  )
  
  wild_after_orono <- round(
    wild_after_inriver_PU11 * downstream_passage[13], 0
  )      
    
  # . Confluence (PU12) ----
  hatchery_after_inriver_PU12_mainstem <- c(
    round(hatchery_after_greatworks * alt_2[13], 0),
    0, 0)
    
  wild_after_inriver_PU12_mainstem <- c(
    round(wild_after_greatworks * alt_2[13], 0),
    0, 0)
  
  hatchery_after_inriver_PU12_stillwater <- round(
    hatchery_after_orono * alt_2[13], 0
  )
    
  wild_after_inriver_PU12_stillwater <- round(
    wild_after_orono * alt_2[13], 0
  )  
  
  hatchery_after_inriver_PU12 <- c(
    hatchery_after_inriver_PU12_mainstem +
    hatchery_after_inriver_PU12_stillwater,
    round(stocked_smolts[13] * hatchery_init[13], 0)
  )
  
  wild_after_inriver_PU12 <- c(
    wild_after_inriver_PU12_mainstem +
    wild_after_inriver_PU12_stillwater,
    round(wild_smolts[13] * wild_init[13], 0)
  )  
  
  # Lower Penobscot River dynamics ----
  # . Veazie Dam ----
  hatchery_after_veazie <- round(
    hatchery_after_inriver_PU12 * downstream_passage[14], 0
  )
  
  wild_after_veazie <- round(
    wild_after_inriver_PU12 * downstream_passage[14], 0
  )  
  
  # Production Unit 13 dynamics ----
  hatchery_after_inriver_PU13 <- c(
    rep(0, 13),
    round(stocked_smolts[14] * hatchery_init[14], 0)
  )
  
  wild_after_inriver_PU13 <- c(
    rep(0, 13),
    round(wild_smolts[14] * wild_init[14], 0)
  )  
  
  # . Frankfort Dam ----
  hatchery_after_frankfort <- round(
    hatchery_after_inriver_PU13 * downstream_passage[15], 0
  )
  
  wild_after_frankfort <- round(
    wild_after_inriver_PU13 * downstream_passage[15], 0
  )  
  
  # . Production Unit 14 dynamics ----
  hatchery_after_veazie[14] <- 0
  wild_after_veazie[14] <- 0

  hatchery_after_inriver_PU14 <- c(
    round(hatchery_after_veazie * alt_2[15], 0) +
    round(hatchery_after_frankfort * alt_1[15], 0),
    stocked_smolts[15] * hatchery_init[15]
  )
  
  wild_after_inriver_PU14 <- c(
    round(wild_after_veazie * alt_2[15], 0) +
    round(wild_after_frankfort * alt_1[15], 0),
    wild_smolts[15] * wild_init[15]
  )  
  
  # Latent indirect mortality calculations ----
  # . Across all dams ----
  hatchery_indirect_latent_mainstem <- round(
    (1 - p_stillwater) * hatchery_after_inriver_PU14 * 
      (indirect_latent_mortality * n_dams$mainstem), 0)
  
  hatchery_indirect_latent_stillwater <- round(
    p_stillwater * hatchery_after_inriver_PU14 * 
      (indirect_latent_mortality * n_dams$stillwater), 0)  
  
  hatchery_indirect_latent_total <- 
    hatchery_indirect_latent_mainstem +
      hatchery_indirect_latent_stillwater
  
  wild_indirect_latent_mainstem <- round(
    (1 - p_stillwater) * wild_after_inriver_PU14 * 
      (indirect_latent_mortality * n_dams$mainstem), 0)
  
  wild_indirect_latent_stillwater <- round(
    p_stillwater * wild_after_inriver_PU14 * 
      (indirect_latent_mortality * n_dams$stillwater), 0)    

  wild_indirect_latent_total <- 
    wild_indirect_latent_mainstem +
      wild_indirect_latent_stillwater
    
  # . Per dam ----
  hatchery_indirect_latent_mortality_per_dam_mainstem <- round(
    hatchery_indirect_latent_mainstem / n_dams$mainstem, 0
  )
  
  hatchery_indirect_latent_mortality_per_dam_stillwater <- round(
    hatchery_indirect_latent_mainstem / n_dams$stillwater, 0
  )  
  
  hatchery_indirect_latent_per_dam_total <- 
    hatchery_indirect_latent_mortality_per_dam_mainstem +
    hatchery_indirect_latent_mortality_per_dam_stillwater  
  
  wild_indirect_latent_mortality_per_dam_mainstem <- round(
    wild_indirect_latent_mainstem / n_dams$mainstem, 0
  )
  
  wild_indirect_latent_mortality_per_dam_stillwater <- round(
    wild_indirect_latent_mainstem / n_dams$stillwater, 0
  )    
  
  wild_indirect_latent_per_dam_total <- 
    wild_indirect_latent_mortality_per_dam_mainstem +
    wild_indirect_latent_mortality_per_dam_stillwater
  
  # Total smolts at Verona Island ----
  hatchery_after_verona <- 
    hatchery_after_inriver_PU14 - 
    hatchery_indirect_latent_total
  
  wild_after_verona <- 
    wild_after_inriver_PU14 - 
    wild_indirect_latent_total  
  
  # Summary calculations for adult migration module ----
  # . Female smolts at Verona Island ----
  hatchery_female_out <- round(hatchery_after_verona * p_female, 0)
  wild_female_out <- round(wild_after_verona * p_female, 0)

  # . Proportion female in PU ----
  hatchery_proportion_female_in_PU <- 
    hatchery_female_out / sum(hatchery_female_out)
  wild_proportion_female_in_PU <- 
    wild_female_out / sum(wild_female_out)
    
  # Data return to calling environment ----
  # Can update and add toggles as needed
  return(
    list(
      hatchery_out = sum(hatchery_female_out),
      wild_out = sum(wild_female_out),
      hatchery_p_out = hatchery_proportion_female_in_PU,
      wild_p_out = wild_proportion_female_in_PU
    )
  )
  
}
