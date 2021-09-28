#' @title Run upstream migration routine
#' 
#' @description Run the upstream migration routine for adult Atlantic salmon in
#' the Dam Impact Analysis (DIA) model v67 during year 6. Not intended to be
#' called directly.
#' 
#' @param hatchery_returns Total number of hatchery smolts exiting river in 
#' year 4.
#' 
#' @param hatchery_proportions Proportion of individuals attempting to return
#' to each production unit (PU in the river). Within the `run_dia()` function,
#' these values are passed as output from `run_downstream_migration()`. 
#' 
#' @param wild_returns Number of wild-reared smolts exiting river in 
#' year 4.
#' 
#' @param wild_proportions Proportion of individuals attempting to return
#' to each production unit (PU in the river). Within the `run_dia()` function,
#' these values are passed as output from `run_downstream_migration()`. 
#' 
#' @param upstream_passage Numeric vector with length = 15 corresponding to
#' dam passage efficiencies at each of 15 dams in the watershed that are used 
#' to delineate PUs. Default usage is to inherit these values from the 
#' \code{link{run_dia}} function's `upstream_passage` argument using default
#' values based on NMFS (2013) prescriptions as implemented in Nieland and
#' Sheehan (2020).
#' 
#' @param straying_matrix A dataframe identical in structure to the built-in
#' \code{\link{straying_locations}} dataset.
#' 
#' @param p_mainstem_up Probability that fish use the mainstem Penobscot River
#' (and not Stillwater Branch) for upstream migration around Marsh Island.
#' 
#' @param stocking Number indicating whether hatchery stocking is on (`1`) or
#' off (`0`). Will be a vector corresponding to `n_generations` at some point.
#'   
#' @param n_broodstock Target number of adult returns collected at Milford Dam 
#' for spawning at US Fish and Wildlife Service Craig Brook National Fish 
#' Hatchery each year. Broodstock are collected upstream of Milford Dam
#' in \code{\link{run_upstream_passage}}.
#' 
#' @param inefficiency_matrix A matrix identical in structure to the built-in
#' \code{\link{inefficiency_matrix}} dataset.
#' 
#' @references
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
#' NMFS (National Marine Fisheries Service). 2013. Endangered Species Act 
#' Biological Opinion: FERC amendment of license for the Mattaceunk Project 
#' (Interim Species Protection Plan). NMFS Greater Atlantic Regional Office, 
#' NER-2013-9640, Gloucester, MA.
#' 
#' @seealso run_dia, run_downstream_passage
#' 
#' @export
#' 
run_upstream_passage <- function(hatchery_returns,
                                 hatchery_proportions,
                                 wild_returns,
                                 wild_proportions,
                                 upstream_passage,
                                 straying_matrix,
                                 p_mainstem_up,
                                 stocking,
                                 n_broodstock,
                                 inefficiency_matrix
                                 ){

  # Number of fish attempting to return to each PU ----
  hatchery_returns_by_pu <- round(hatchery_returns * hatchery_proportions, 0)
  wild_returns_by_pu <- round(wild_returns * wild_proportions, 0)
  
  # Number of fish remaining after straying ----
  hatchery_return_after_straying <- dia::run_straying(hatchery_returns_by_pu, 
                                                      straying_matrix)
    
  wild_return_after_straying <- dia::run_straying(wild_returns_by_pu, 
                                                  straying_matrix)  
  
  # Upstream migration through dams -----
  # . Veazie and Frankfort dams ----
  hatchery_after_veazie_frankfort <- round(c(
    hatchery_return_after_straying[1:13] * upstream_passage[14],
    hatchery_return_after_straying[14] * upstream_passage[15],
    hatchery_return_after_straying[15] * 1), 0)
  
  wild_after_veazie_frankfort <- round(c(
    wild_return_after_straying[1:13] * upstream_passage[14],
    wild_return_after_straying[14] * upstream_passage[15],
    wild_return_after_straying[15] * 1), 0)  
  
  # . Stillwater Branch ----
  # .. Orono ----
  hatchery_after_orono <- round(
    hatchery_after_veazie_frankfort * (1 - p_mainstem_up) * upstream_passage[13], 0)
  
  wild_after_orono <- round(
    wild_after_veazie_frankfort * (1 - p_mainstem_up) * upstream_passage[13], 0)
  # .. Stillwater ----
  hatchery_after_stillwater <- round(
    hatchery_after_orono * upstream_passage[10], 0)
  
  wild_after_stillwater <- round(
    wild_after_orono * upstream_passage[10], 0)  
  
  # . Mainstem ----
  # .. Greatworks ----
  hatchery_after_greatworks <- round(
    hatchery_after_veazie_frankfort * (p_mainstem_up) * upstream_passage[12], 0)
  
  wild_after_greatworks <- round(
    wild_after_veazie_frankfort * (p_mainstem_up) * upstream_passage[12], 0)  
  
  # .. Milford ----
  hatchery_after_milford <- round(
    hatchery_after_greatworks * upstream_passage[11], 0)
  
  wild_after_milford <- round(wild_after_greatworks * upstream_passage[11], 0)
  
  # .. Milford broodstock collection ----
  # Get total number available for broodstock collection
  total_available <- sum(hatchery_after_milford[1:9]) + 
    sum(wild_after_milford[1:9])
  
  if(is.na(total_available)) total_available <- 0
  
  # Default containers that will be unchanged if stocking turned off
  hatchery_after_broodstock <- hatchery_after_milford
  wild_after_broodstock <- wild_after_milford
  
  # If more returns than brood, divide them equally among PUs upstream
  # of Milford Dam
  if(stocking == 1 & total_available > n_broodstock){
    broodstock_taken <- n_broodstock
    hatchery_after_broodstock[1:9] <- round(
      (hatchery_after_milford[1:9] - 
        n_broodstock * (hatchery_after_milford[1:9]/total_available)), 0
    )
    wild_after_broodstock[1:9] <- round(
      (wild_after_milford[1:9] - 
        n_broodstock * (wild_after_milford[1:9]/total_available)), 0
    )    
  }
  
  # If fewer or same number of returns as broodstock target, then take them
  # all and zero out adults attempting to return to PUs 1 - 9
  if(stocking == 1 & total_available <= n_broodstock & !is.na(total_available)){
    broodstock_taken <- total_available
    hatchery_after_broodstock[1:9] <- 0
    wild_after_broodstock[1:9] <- 0
  }  
  
  # . Confluence ----
  hatchery_at_confluence <- hatchery_after_stillwater + 
    hatchery_after_broodstock
  
  wild_at_confluence <- wild_after_stillwater + 
    wild_after_broodstock 
  
  # . Upper Penobscot ----
  # .. Lowell Tannery, Howland, and West Enfield Dams ----
  hatchery_up_one_dam <- round(c(
    hatchery_at_confluence[1:3] * upstream_passage[3],
    hatchery_at_confluence[4:8] * upstream_passage[8],
    hatchery_at_confluence[9] * upstream_passage[9],
    hatchery_at_confluence[10:15]
  ), 0)
  
  wild_up_one_dam <- round(c(
    wild_at_confluence[1:3] * upstream_passage[3],
    wild_at_confluence[4:8] * upstream_passage[8],
    wild_at_confluence[9] * upstream_passage[9],
    wild_at_confluence[10:15]
  ), 0)
  
  # .. Mattaceunk, Browns Mills, Milo ----
  hatchery_up_two_dams <- round(c(
    hatchery_up_one_dam[1:2] * upstream_passage[2],
    hatchery_up_one_dam[3],
    hatchery_up_one_dam[4:5] * upstream_passage[5],
    hatchery_up_one_dam[6:7] * upstream_passage[7],
    hatchery_up_one_dam[8:15]
  ), 0)  
 
  wild_up_two_dams <- round(c(
    wild_up_one_dam[1:2] * upstream_passage[2],
    wild_up_one_dam[3],
    wild_up_one_dam[4:5] * upstream_passage[5],
    wild_up_one_dam[6:7] * upstream_passage[7],
    wild_up_one_dam[8:15]
  ), 0)  
  
  # .. Medway, Upper Dover, Sebec ----
  hatchery_up_three_dams <- round(c(
    hatchery_up_two_dams[1] * upstream_passage[1],
    hatchery_up_two_dams[2:3],
    hatchery_up_two_dams[4] * upstream_passage[4],
    hatchery_up_two_dams[5],
    hatchery_up_two_dams[6] * upstream_passage[6],
    hatchery_up_two_dams[7:15]
  ))
  
  wild_up_three_dams <- round(c(
    wild_up_two_dams[1] * upstream_passage[1],
    wild_up_two_dams[2:3],
    wild_up_two_dams[4] * upstream_passage[4],
    wild_up_two_dams[5],
    wild_up_two_dams[6] * upstream_passage[6],
    wild_up_two_dams[7:15]
  ))
  
  # Fate of fish that don't pass dams ----
  # Hatchery fish
  hatchery_no_pass <- vector(mode = "numeric",
                             length = length(hatchery_up_three_dams))
  
  hatchery_no_pass[1] <- hatchery_up_two_dams[1] - hatchery_up_three_dams[1]
  hatchery_no_pass[2] <- sum(hatchery_up_one_dam[1:2]) - 
    sum(hatchery_up_two_dams[1:2])
  hatchery_no_pass[3] <- sum(hatchery_at_confluence[1:3]) - 
    sum(hatchery_up_one_dam[1:3])
  hatchery_no_pass[4] <- hatchery_up_two_dams[4] - hatchery_up_three_dams[4]
  hatchery_no_pass[5] <- sum(hatchery_up_one_dam[4:5]) - 
    sum(hatchery_up_two_dams[4:5])
  hatchery_no_pass[6] <- hatchery_up_two_dams[6] - hatchery_up_three_dams[6]
  hatchery_no_pass[7] <- sum(hatchery_up_one_dam[6:7]) - 
    sum(hatchery_up_two_dams[6:7])
  hatchery_no_pass[8] <- sum(hatchery_at_confluence[4:8]) - 
    sum(hatchery_up_one_dam[4:8])
  hatchery_no_pass[9] <- hatchery_at_confluence[9] - hatchery_up_one_dam[9]
  hatchery_no_pass[10] <- sum(hatchery_after_greatworks[1:10]) - 
    sum(hatchery_after_milford[1:10])
  hatchery_no_pass[11] <- sum(hatchery_after_orono[1:10]) - 
    sum(hatchery_after_stillwater[1:10])
  hatchery_no_pass[12] <- sum(hatchery_after_veazie_frankfort[1:11]) - 
    sum(hatchery_after_greatworks[1:11])
  hatchery_no_pass[13] <- sum(hatchery_after_veazie_frankfort[1:12]) - 
    sum(hatchery_after_orono[1:12])  
  hatchery_no_pass[14] <-  sum(hatchery_return_after_straying[1:13]) - 
    sum(hatchery_after_veazie_frankfort[1:13])
  hatchery_no_pass[15] <- hatchery_return_after_straying[14] - 
    hatchery_after_veazie_frankfort[14]
  
  # Wild fish
  wild_no_pass <- vector(mode = "numeric",
                             length = length(wild_up_three_dams))
  
  wild_no_pass[1] <- wild_up_two_dams[1] - wild_up_three_dams[1]
  wild_no_pass[2] <- sum(wild_up_one_dam[1:2]) - 
    sum(wild_up_two_dams[1:2])
  wild_no_pass[3] <- sum(wild_at_confluence[1:3]) - 
    sum(wild_up_one_dam[1:3])
  wild_no_pass[4] <- wild_up_two_dams[4] - wild_up_three_dams[4]
  wild_no_pass[5] <- sum(wild_up_one_dam[4:5]) - 
    sum(wild_up_two_dams[4:5])
  wild_no_pass[6] <- wild_up_two_dams[6] - wild_up_three_dams[6]
  wild_no_pass[7] <- sum(wild_up_one_dam[6:7]) - 
    sum(wild_up_two_dams[6:7])
  wild_no_pass[8] <- sum(wild_at_confluence[4:8]) - 
    sum(wild_up_one_dam[4:8])
  wild_no_pass[9] <- wild_at_confluence[9] - wild_up_one_dam[9]
  wild_no_pass[10] <- sum(wild_after_greatworks[1:10]) - 
    sum(wild_after_milford[1:10])
  wild_no_pass[11] <- sum(wild_after_orono[1:10]) - 
    sum(wild_after_stillwater[1:10])
  wild_no_pass[12] <- sum(wild_after_veazie_frankfort[1:11]) - 
    sum(wild_after_greatworks[1:11])
  wild_no_pass[13] <- sum(wild_after_veazie_frankfort[1:12]) - 
    sum(wild_after_orono[1:12])  
  wild_no_pass[14] <-  sum(wild_return_after_straying[1:13]) - 
    sum(wild_after_veazie_frankfort[1:13])
  wild_no_pass[15] <- wild_return_after_straying[14] - 
    wild_after_veazie_frankfort[14] 
  
  # .. Fish that die after passage failure ----
  hatchery_dead <- round(
    hatchery_no_pass * dia::upstream_inefficiency$p_die, 0)
  
  wild_dead <- round(
    wild_no_pass * dia::upstream_inefficiency$p_die, 0)
    
  # .. Fish that return to sea ----
  hatchery_to_sea <- round(
    hatchery_no_pass * dia::upstream_inefficiency$p_return_to_sea, 0)
  
  wild_to_sea <- round(
    wild_no_pass * dia::upstream_inefficiency$p_return_to_sea, 0)
      
  # .. Fish that go elsewhere ----
  hatchery_elsewhere <- hatchery_no_pass - (hatchery_dead + hatchery_to_sea)
  
  wild_elsewhere <- wild_no_pass - (wild_dead + wild_to_sea)
        
  hatchery_destinations <- dia::run_inefficiency(
    n = hatchery_elsewhere,
    inefficiency_matrix = inefficiency_matrix
    )
  
  wild_destinations <- dia::run_inefficiency(
    n = wild_elsewhere,
    inefficiency_matrix = inefficiency_matrix
    )
  
  hatchery_pu_final <- hatchery_up_three_dams + hatchery_destinations
  wild_pu_final <- wild_up_three_dams + wild_destinations
  
  # Summary calcs from DIA Model67.xlsx ----
  # Not sure this is needed anymore? Can swing back to it...
  p_success <- hatchery_pu_final / hatchery_returns_by_pu
  
  return(
    list(
      hatchery_adults = hatchery_pu_final,
      wild_adults = wild_pu_final
    )
  )
  
}
