#' @title Production unit table
#'
#' @description Production unit table from the Atlantic salmon Dam 
#' Impact Analysis model v67. Division of Penobscot River watershed 
#' into sections, or Production Units (PUs).  Gives boundaries, 
#' habitat units, production potential, and length of each PU.
#'
#' @format A dataframe with 15 observations of 12 variables
#' \describe{
#'   \code{PU }{Production unit number (Neiland et al. 2015)}
#'   \code{Boundaries }{Boundaries used to delimit PU}
#'   \code{HU } Habitat units
#'   \code{HU_scen } Habitat units in default scenario
#'   \code{Proportion_of_HUS_in_scenario} Proportion of habitat units within PU (of entire watershed)
#'   \code{Adjusted_proportion_of_HUs_in_scenario} Adjusted cumulative proportion of habitat units within PU (of entire watershed)
#'   \code{Smolt_production_potential} Number of smolts that can be produced in each PU based on HUs
#'   \code{Longest_segment_length_km} Maximum segment length of PU (km)
#'   \code{Partial_segment_length_1} First partial segment length, if applicable
#'   \code{Partial_segment_length_2} Second partial segment length, if applicable
#'   \code{Hatchery_segment_length} Length of hatchery stocking segment
#'   \code{Dam} Name of dam at downstream end of PU
#' }
#'
#' @source Nieland et al. (2013, 2015, 2020)
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
#'   \code{Natal_PU }{Natal production unit as smolt}
#'   \code{PU_01, ..., PU14 } Destination production unit as adult
#' }
#' 
#' @source Nieland et al. (2013, 2015, 2020)
#' 
"straying_locations"

#' @title Upstream inefficiency of adult migrants
#' 
#' @description Upstream inefficiency table from the Atlantic salmon 
#' Dam Impact analysis model v67. When adult Atlantic salmon do not 
#' pass a dam, a proportion of those fish die, a proportion return 
#' to sea, and a proportion go elsewhere to attempt to spawn.
#' 
#' @format A dataframe with 15 observations of 19 variables
#' \describe{
#'   \code{dam_failed_to_pass } The dam the adults fail to pass
#'   \code{p_die } The proportion of failed migrants that die
#'   \code{p_return_to_sea } The proportion of failed migrants that return to sea
#'   \code{p_go_elsewhere } The proportion going elsewhere
#'   \code{PU_01...PU14 } The destination PUs for failed migrants at each dam with proportion going to each
#' }
#' 
#' @source Nieland et al. (2013, 2015, 2020)
#' 
"upstream_inefficiency"

#' @title Life-stage survival rates
#' 
#' @description Life Stage Survival table from the Atlantic salmon 
#' Dam Impact analysis model v67. Distributional parameters for year-specific
#' number of eggs produced per female, egg-to-smolt survival rate, 
#' in-river mortality rate, and marine survival rate.
#' 
#' @format A dataframe with 5 observations of 6 variables
#' \describe{
#'   \code{rate } Vital rate of interest
#'   \code{means } Mean of vital rate
#'   \code{medians } Median of vital rate
#'   \code{sds } Standard deviation of vital rate
#'   \code{mins } Minimum value (where applicable)
#'   \code{maxes } Maximum value (where applicable)
#' }
#' 
#' @source Nieland et al. (2013, 2015, 2020)
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
#'   \code{cum_prob } Cumulative probability for proportion
#'   \code{proportion } Proportion of smolts using Stillwater Branch
#' }
#' 
#' @source Nieland et al. (2020)
#' 
"stillwater_use"

#' @title Stillwater Use (old)
#' 
#' @description Stillwater use table from the Atlantic salmon 
#' Dam Impact analysis model v67. Previous values used for 
#' Cumulative probabilities of proportional use of Stillwater Branch by 
#' outmigrating Atlantic salmon smolts in the Penobscot River, ME.
#' 
#' @format A dataframe with 5,000 observations of 2 variables
#' \describe{
#'   \code{cum_prob } Cumulative probability for proportion
#'   \code{proportion } Proportion of smolts using Stillwater Branch
#' }
#' 
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#'  
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2020)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2020)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
#' 
"downstream_orono_old"

#' @title Downstream data for Stillwater
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow. This dataset was updated in 2020 following changes to the
#' hydrosystem associated with the Penobscot River Restoration Project.
#' 
#' @format A dataframe with 4,456 observations of 4 variables
#' \describe{
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2020)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
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
#'   \code{flow_cfs } Value of flow (discharge)
#'   \code{cumulative_prob } Cumulative flow probability
#'   \code{flow_prob } Probability of individual flow value
#'   \code{smolt_surv_prob } Smolt survival probability given flow
#' }
#' 
#' @source Nieland et al. (2013, 2015)
#' 
"downstream_westenfield"

#' @title Default stocking proportions by production unit
#' 
#' @description Default stocking proportions from the Hatchery worksheet
#' in the Atlantic salmon Dam Impact Analysis model v67. 
#' 
#' @format A dataframe with 15 observations of 2 variables
#' \describe{
#'   \code{PU } Production unit
#'   \code{proportion_stocked } Proportion of hatchery smolts stocked in PU
#' }
#' 
#' @source Nieland et al. (2020)



