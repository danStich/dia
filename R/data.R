#' @title Production unit table
#'
#' @description Production unit table from the Atlantic salmon Dam 
#' Impact Analysis model v67. Division of Penobscot River watershed 
#' into sections, or Production Units (PUs).  Gives boundaries, 
#' habitat units, production potential, and length of each PU.
#'
#' @format A dataframe with 15 observations of 12 variables
#' \describe{
#'   \code{PU }{Production unit number (Neiland et al. 2015)} \cr \cr
#'   \code{Boundaries }{Boundaries used to delimit PU} \cr \cr
#'   \code{HU } Habitat units \cr \cr
#'   \code{HU_scen } Habitat units in default scenario \cr \cr
#'   \code{Proportion_of_HUS_in_scenario} Proportion of habitat units within PU (of entire watershed) \cr \cr
#'   \code{Adjusted_proportion_of_HUs_in_scenario} Adjusted cumulative proportion of habitat units within PU (of entire watershed) \cr \cr
#'   \code{Smolt_production_potential} Number of smolts that can be produced in each PU based on HUs \cr \cr
#'   \code{Longest_segment_length_km} Maximum segment length of PU (km) \cr \cr
#'   \code{Partial_segment_length_1} First partial segment length, if applicable \cr \cr
#'   \code{Partial_segment_length_2} Second partial segment length, if applicable \cr \cr
#'   \code{Hatchery_segment_length} Length of hatchery stocking segment \cr \cr
#'   \code{Dam} Name of dam at downstream end of PU
#' }
#'
#' @source 
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
"production_units"

#' @title Straying locations
#' 
#' @description Straying matrix from the Atlantic salmon Dam 
#' Impact Analysis model v67. Straying locations of adult Atlantic 
#' salmon based on behavioral patterns. 
#' 
#' @format A dataframe with 15 observations of 16 variables.
#' \describe{
#'   \code{Natal_PU }{Natal production unit as smolt} \cr \cr
#'   \code{PU_01, ..., PU14 } Destination production unit as adult \cr \cr
#' }
#' 
#' @source 
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
"straying_locations"

#' @title Straying matrix
#' 
#' @description Numeric columns only from \code{\link{straying_locations}}
#' 
#' @format A matrix with 15 observations of 16 variables.
#' 
#' @source 
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
"straying_matrix"

#' @title Upstream inefficiency of adult migrants
#' 
#' @description Upstream inefficiency table from the Atlantic salmon 
#' Dam Impact Analysis model v67. When adult Atlantic salmon do not 
#' pass a dam, a proportion of those fish die, a proportion return 
#' to sea, and a proportion go elsewhere to attempt to spawn.
#' 
#' @format A dataframe with 15 observations of 15 variables
#' \describe{
#'   \code{dam_failed_to_pass } The dam the adults fail to pass \cr \cr
#'   \code{p_die } The proportion of failed migrants that die \cr \cr
#'   \code{p_return_to_sea } The proportion of failed migrants that return to sea \cr \cr
#'   \code{p_go_elsewhere } The proportion going elsewhere \cr \cr
#'   \code{PU_01...PU14 } The destination PUs for failed migrants at each dam with proportion going to each \cr \cr
#' }
#' 
#' @source 
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
"upstream_inefficiency"

#' @title Inefficiency matrix
#' 
#' @description Numeric columns 5 - 20 from \code{\link{upstream_inefficiency}}
#' 
#' @format A matrix with 15 observations of 15 variables.
#' 
#' @source
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
"inefficiency_matrix"

#' @title Life-stage survival rates
#' 
#' @description Life Stage Survival table from the Atlantic salmon 
#' Dam Impact analysis model v67. Distributional parameters for year-specific
#' number of eggs produced per female, egg-to-smolt survival rate, 
#' in-river mortality rate, and marine survival rate.
#' 
#' @format A dataframe with 5 observations of 6 variables
#' \describe{
#'   \code{rate } Vital rate of interest \cr \cr
#'   \code{means } Mean of vital rate \cr \cr
#'   \code{medians } Median of vital rate \cr \cr
#'   \code{sds } Standard deviation of vital rate \cr \cr
#'   \code{mins } Minimum value (where applicable) \cr \cr
#'   \code{maxes } Maximum value (where applicable) \cr \cr
#' }
#' 
#' @source 
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
"life_stage_survival"

#' @title Stillwater Use
#' 
#' @description Stillwater use table from the Atlantic salmon 
#' Dam Impact analysis model v67. Cumulative probabilities of proportional
#' use of Stillwater Branch by outmigrating Atlantic salmon smolts in the 
#' Penobscot River, ME. This dataset was updated in 2020 following changes
#' associated with the Penobscot River restoration project.
#' 
#' @format A dataframe with 5,000 observations of 2 variables
#' \describe{
#'   \code{cum_prob } Cumulative probability for proportion \cr \cr
#'   \code{proportion } Proportion of smolts using Stillwater Branch \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
"stillwater_use"

#' @title Stillwater Use (old)
#' 
#' @description Stillwater use table from the Atlantic salmon 
#' Dam Impact analysis model v67. Previous values used for 
#' Cumulative probabilities of proportional use of Stillwater Branch by 
#' outmigrating Atlantic salmon smolts in the Penobscot River, ME. This 
#' version can be used to reproduce analyses from Nieland et al. (2013, 2015)
#' and to explore current scenarios relative to historical conditions (e.g., 
#' conditions prior to removal of dams and implementation of new fish
#' passage systems).
#' 
#' @format A dataframe with 5,000 observations of 2 variables
#' \describe{
#'   \code{cum_prob } Cumulative probability for proportion \cr \cr
#'   \code{proportion } Proportion of smolts using Stillwater Branch \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"stillwater_use_old"

#' @title Downstream data for Browns Mills
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow. 
#' 
#' @format A dataframe with 857 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_brownsmills"

#' @title Downstream data for Frankfort
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow. 
#' 
#' @format A dataframe with 300 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_frankfort"

#' @title Downstream data for Great Works
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow. 
#' 
#' @format A dataframe with 7,168 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_greatworks"

#' @title Downstream data for Howland
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow. 
#' 
#' @format A dataframe with 3,315 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_howland"

#' @title Downstream data for Lowell
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow. 
#' 
#' @format A dataframe with 450 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#'  
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_lowell"

#' @title Downstream data for Mattaceunk
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow. 
#' 
#' @format A dataframe with 8,681 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_mattaceunk"

#' @title Downstream data for Medway
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow. 
#' 
#' @format A dataframe with 7,589 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_medway"

#' @title Downstream data for Milford
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow. This dataset was updated in 2020 following changes to the
#' hydrosystem associated with the Penobscot River Restoration Project.
#' 
#' @format A dataframe with 9,356 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
"downstream_milford"

#' @title Downstream data for Milford (old)
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow.
#' 
#' @format A dataframe with 7,168 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_milford_old"

#' @title Downstream data for Milo
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow.
#' 
#' @format A dataframe with 925 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_milo"

#' @title Downstream data for Moosehead
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow.
#' 
#' @format A dataframe with 753 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_moosehead"

#' @title Downstream data for Orono
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow. This dataset was updated in 2020 following changes to the
#' hydrosystem associated with the Penobscot River Restoration Project.
#' 
#' @format A dataframe with 4,457 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
"downstream_orono"

#' @title Downstream data for Orono
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow.
#' 
#' @format A dataframe with 3,692 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_orono_old"

#' @title Downstream data for Sebec
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow.
#' 
#' @format A dataframe with 745 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_sebec"

#' @title Downstream data for Stillwater
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow. This dataset was updated in 2020 following changes to the
#' hydrosystem associated with the Penobscot River Restoration Project.
#' 
#' @format A dataframe with 4,456 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
"downstream_stillwater"

#' @title Downstream data for Stillwater (old)
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow.
#' 
#' @format A dataframe with 3,692 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_stillwater_old"

#' @title Downstream data for Veazie
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow.
#' 
#' @format A dataframe with 13,939 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_veazie"

#' @title Downstream data for West Enfield
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow.
#' 
#' @format A dataframe with 9,368 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge) \cr \cr
#'   \code{cumulative_prob } Cumulative flow probability \cr \cr
#'   \code{flow_prob } Probability of individual flow value \cr \cr
#'   \code{smolt_surv_prob } Smolt survival probability given flow \cr \cr
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams
#' on diadromous fish: a case study for Atlantic salmon in the Penobscot River, 
#' Maine. ICES Journal of Marine Science 72:2423–2437. 
#' 
#' Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. 
#' Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US 
#' Department of Commerce, Northeast Fisheries Science Center Reference Document 
#' 13-09, Woods Hole, MA.
#' 
"downstream_westenfield"

#' @title Default stocking proportions by production unit
#' 
#' @description Default stocking proportions from the Hatchery worksheet
#' in the Atlantic salmon Dam Impact Analysis model v67. 
#' 
#' @format A dataframe with 15 observations of 2 variables
#' \describe{
#'   \code{PU } Production unit \cr \cr
#'   \code{proportion_stocked } Proportion of hatchery smolts stocked in PU \cr \cr
#' }
#' 
#' @source
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
"stocking_default"

#' @title Number of dams by natal production unit (PU) and migration route
#' 
#' @description Number of dams passed by out-migrating smolts starting in
#' different production units by downstream migration route (`stillwater` or
#' `mainstem`) 
#' 
#' @format A dataframe with 15 observations of 3 variables
#' \describe{
#'   \code{PU } Production unit of origin \cr \cr
#'   \code{stillwater } Number of dams by natal PU encountered during 
#'   downstream migration if fish move through the Stillwater Branch \cr \cr
#'   \code{mainstem } Number of dams by natal PU encountered during 
#'   downstream migration if fish move through the mainstem Penobscot River \cr \cr  
#' }
#' 
#' @source
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
"n_dams"

#' @title In river mortality
#' 
#' @description Cumulative distribution function for in-river mortality of
#' outmigrating smolts per km
#' 
#' @format A dataframe with 34 observations of 3 variables
#' \describe{
#'   \code{mort_per_km } Production unit of origin \cr \cr
#'   \code{cum_freq } Cumulative probability at mort_per_km \cr \cr
#'   \code{probs } Sampling probability \cr \cr  
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
"in_river_m"

#' @title In river mortality
#' 
#' @description Cumulative distribution function for in-river mortality of
#' outmigrating smolts per km
#' 
#' @format A dataframe with 15 observations of 2 variables
#' \describe{
#'   \code{PU } Production unit \cr \cr
#'   \code{river_section } Section of watershed by PU \cr \cr
#' }
#' 
#' @source 
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
"river_sections"