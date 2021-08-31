#' dia: Atlantic salmon Dam Impact Analysis (DIA) for R
#' 
#' The dia package is a collection of functions and datasets used to run
#' the Dam Impact Analysis (DIA) for Atlantic salmon in the Penobscot
#' River, Maine, USA.
#' 
#' @section Functions called directly:
#' The following functions can be called directly from dia.
#' 
#'  \describe{
#'    \code{\link{run_dia}}{ The primary user-facing function used to run the multi-generation DIA model for Atlantic salmon} \cr \cr
#'    \code{\link{run_one_gen}}{ Run the DIA model for a single generation} \cr \cr
#'    \code{\link{get_dam_passage}}{ Get flow-correlated downstream dam passage values and probability of using Stillwater Branch for smolts each year in `run_one_gen`} \cr \cr
#'    \code{\link{make_egg_to_smolt_survival}}{ Simulate survival from egg to smolt stage for naturally produced smolts in `run_one_gen`} \cr \cr
#'    \code{\link{make_eggs_per_female}}{ Simulate number of eggs per female each year in `run_one_gen`} \cr \cr
#'    \code{\link{make_inriver_s}}{ Simulate natural, in-river survival per km for downstream migrating smolts in `run_one_gen`} \cr \cr   
#'    \code{\link{make_marine_s}}{ Simulate marine survival each year in `run_one_gen`} \cr \cr    
#'    \code{\link{run_downstream_passage}}{ Run the downstream smolt passage module in `run_one_gen`} \cr \cr
#'    \code{\link{run_inefficiency}}{ Re-distribute adult upstream migrants following failed dam passage in `run_one_gen`} \cr \cr    
#'    \code{\link{run_straying}}{ Assign destination production units for adult returns in `run_one_gen`} \cr \cr      
#'    \code{\link{run_upstream_passage}}{ Function used to run the upstream passage module for adults in `run_one_gen`} \cr \cr        
#'    \code{\link{smolt_stocking}}{ Function used to distribute stocked smolts among production units in `run_one_gen`} \cr \cr
#'  }
#'  
#' @section Data:
#' The following built-in datasets are included:
#' 
#'   \describe{
#'     \code{\link{downstream_brownsmills}}{ Flow-correlated estimates of smolt survival through Browns Mills Dam} \cr \cr
#'     \code{\link{downstream_frankfort}}{ Flow-correlated estimates of smolt survival through Frankfort Dam} \cr \cr
#'     \code{\link{downstream_greatworks}}{ Flow-correlated estimates of smolt survival through Great Works Dam} \cr \cr
#'     \code{\link{downstream_howland}}{ Flow-correlated estimates of smolt survival through Howland Dam} \cr \cr
#'     \code{\link{downstream_lowell}}{ Flow-correlated estimates of smolt survival through Lowell Dam} \cr \cr
#'     \code{\link{downstream_mattaceunk}}{ Flow-correlated estimates of smolt survival through Mattaceunk Dam} \cr \cr
#'     \code{\link{downstream_medway}}{ Flow-correlated estimates of smolt survival through Medway Dam} \cr \cr
#'     \code{\link{downstream_milford}}{ Updated (2020) flow-correlated estimates of smolt survival through Milford Dam} \cr \cr
#'     \code{\link{downstream_milford_old}}{ Original (2013) flow-correlated estimates of smolt survival through Milford Dam} \cr \cr
#'     \code{\link{downstream_milo}}{ Flow-correlated estimates of smolt survival through Milo Dam} \cr \cr
#'     \code{\link{downstream_moosehead}}{ Flow-correlated estimates of smolt survival through Moosehead Dam} \cr \cr
#'     \code{\link{downstream_orono}}{ Updated (2020) flow-correlated estimates of smolt survival through Orono Dam} \cr \cr
#'     \code{\link{downstream_orono_old}}{ Original (2013) flow-correlated estimates of smolt survival through Orono Dam} \cr \cr
#'     \code{\link{downstream_sebec}}{ Flow-correlated estimates of smolt survival through Sebec Dam} \cr \cr
#'     \code{\link{downstream_stillwater}}{ Updated (2020) flow-correlated estimates of smolt survival through Stillwater Dam} \cr \cr
#'     \code{\link{downstream_stillwater_old}}{ Original (2013) flow-correlated estimates of smolt survival through Stillwater Dam} \cr \cr
#'     \code{\link{downstream_veazie}}{ Flow-correlated estimates of smolt survival through Veazie Dam} \cr \cr
#'     \code{\link{downstream_westenfield}}{ Flow-correlated estimates of smolt survival through West Enfield Dam} \cr \cr
#'     \code{\link{in_river_m}}{ Cumulative frequency distribution of in-river mortality per km for smolts} \cr \cr
#'     \code{\link{life_stage_survival}}{ Distributional parameters for year-specific number of eggs produced per female, egg-to-smolt survival rate, in-river mortality rate, and marine survival rate} \cr \cr
#'     \code{\link{n_dams}} { Number of dams passed by smolts in each production unit and migration route} \cr \cr
#'     \code{\link{production_units}}{ Division of Penobscot River watershed into sections, or Production Units (PUs)} \cr \cr
#'     \code{\link{stillwater_use}}{ Updated (2020) probability of smolts using Stillwater Branch for outmigration given discharge} \cr \cr
#'     \code{\link{stillwater_use_old}}{ Original (2013) probability of smolts using Stillwater Branch for outmigration given discharge} \cr \cr
#'     \code{\link{stocking_default}}{ Default stocking proportions of smolts by PU} \cr \cr
#'     \code{\link{straying_locations}}{ Straying locations of adult Atlantic salmon based on behavioral patterns} \cr \cr
#'     \code{\link{straying_matrix}}{ Numeric columns only from `straying_locations`} \cr \cr
#'     \code{\link{upstream_inefficiency}}{ Destination PUs and probabilities for adults that fail to pass dams} \cr \cr
#'     \code{\link{inefficiency_matrix}}{ Columns 5 through 20 from `upstream_inefficiency`} \cr \cr
#'   }
#'   
#' @docType package
#' 
#' @name dia
#' 
# #' @importFrom truncnorm rtruncnorm
# #' @importFrom stats quantile rnorm runif sd
NULL
