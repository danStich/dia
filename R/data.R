#' @title Production unit table
#'
#' @description Production unit table from the Atlantic salmon Dam 
#' Impact Analysis model v67. Division of Penobscot River watershed 
#' into sections, or Production Units (PUs).  Gives boundaries, 
#' habitat units, production potential, and length of each PU.
#'
#' @format A dataframe with 15 observations of 12 variables
#' \describe{
#'   \item{\code{PU}}{Production unit number (Neiland et al. 2015)}
#'   \item{\code{Boundaries}}{Boundaries used to delimit PU}
#'   \item{\code{HU}}{Habitat units}
#'   \item{\code{HU_scen}}{Habitat units in default scenario}
#'   \item{\code{Proportion_of_HUS_in_scenario}}{Proportion of habitat units within PU (of entire watershed)}
#'   \item{\code{Adjusted_proportion_of_HUs_in_scenario}}{Adjusted cumulative proportion of habitat units within PU (of entire watershed)}
#'   \item{\code{Smolt_production_potential}}{Number of smolts that can be produced in each PU based on HUs}
#'   \item{\code{Longest_segment_length_km}}{Maximum segment length of PU (km)}
#'   \item{\code{Partial_segment_length_1}}{First partial segment length, if applicable}
#'   \item{\code{Partial_segment_length_2}}{Second partial segment length, if applicable}
#'   \item{\code{Hatchery_segment_length}}{Length of hatchery stocking segment}
#'   \item{\code{Dam}}{Name of dam at downstream end of PU}
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
#' Impact Analysis model v67. Straying locations (PUs) of returning adult Atlantic 
#' salmon based on natal PU. 
#' 
#' @format A dataframe with 15 observations of 16 variables.
#' \describe{
#'   \item{\code{Natal_PU}}{Natal production unit as smolt}
#'   \item{\code{PU_01, ..., PU14}}{Probability of returning to each destination production unit as an adult conditioned on natal PU}
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
#' @description Numeric columns only from \code{\link{straying_locations}}. A 
#' matrix of return probabilities to destination PUs (columns) conditioned on 
#' natal PU (rows) where the diagonal represents probability of returning to 
#' natal PU (i.e., homing rate). These values are used in combination with the
#' \code{\link{inefficiency_matrix}} to spatially distribute returning adult 
#' spawners in each generation of simulations.
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
"straying_matrix"

#' @title Upstream inefficiency of adult migrants
#' 
#' @description Upstream inefficiency table from the Atlantic salmon 
#' Dam Impact Analysis model v67. When adult Atlantic salmon do not 
#' pass a dam, a proportion of those fish die, a proportion return 
#' to sea, and a proportion go elsewhere to attempt to spawn. These values are
#' used in combination with the \code{\link{straying_matrix}} to spatially
#' distribute returning adult spawners in each generation of simulations.
#' 
#' 
#' @format A dataframe with 15 observations of 15 variables
#' \describe{
#'   \item{\code{dam_failed_to_pass}}{The dam the adults fail to pass}
#'   \item{\code{p_die}}{The proportion of failed migrants that die}
#'   \item{\code{p_return_to_sea}}{The proportion of failed migrants that return to sea}
#'   \item{\code{p_go_elsewhere}}{The proportion of failed migrants going elsewhere}
#'   \item{\code{PU_01...PU14}}{The destination PUs for failed migrants at each dam with proportion of failed migrants going to each}
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
#' @details See \code{\link{upstream_inefficiency}} for additional details.
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
#' in-river mortality rate, and marine survival rate. These variables provide
#' default descriptive statistics used to simulate life stage-specific vital 
#' rates within the \code{\link{run_one_gen}} function.
#' 
#' @format A dataframe with 5 observations of 6 variables
#' \describe{
#'   \item{\code{rate}}{Vital rate of interest}
#'   \item{\code{means}}{Mean of vital rate}
#'   \item{\code{medians}}{Median of vital rate}
#'   \item{\code{sds}}{Standard deviation of vital rate}
#'   \item{\code{mins}}{Minimum value (where applicable)}
#'   \item{\code{maxes}}{Maximum value (where applicable)}
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
#' associated with the Penobscot River Restoration Project 
#' (Nieland et al. 2020).
#' 
#' @format A dataframe with 5,000 observations of 2 variables
#' \describe{
#'   \item{\code{cum_prob}}{Cumulative probability for proportion}
#'   \item{\code{proportion}}{Proportion of smolts using Stillwater Branch}
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
#'   \item{\code{cum_prob}}{Cumulative probability for proportion}
#'   \item{\code{proportion}}{Proportion of smolts using Stillwater Branch}
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
#' Atlantic salmon Dam Impact analysis model v67 for Browns Mills Dam. 
#' Annual survival estimates from
#' a variety of acoustic- and radio-telemetry studies were correlated with
#' annual, in-river discharge data from hydropower facilities by Amaral 
#' et al. (2012) to result in cumulative distribution functions from which 
#' smolt survival can be drawn probabilistically. This is the default approach
#' used in the list of \code{downstream} passage rates for \code{browns_mills}
#' in the \code{\link{run_dia}} function when \code{brownsmills = NA}.
#' 
#' @format A dataframe with 857 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_brownsmills"

#' @title Downstream data for Frankfort
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Frankfort Dam. 
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the default approach used in the list of
#' \code{downstream} passage rates for \code{frankfort} in the 
#' \code{\link{run_dia}} function when \code{frankfort = NA}.
#' 
#' @format A dataframe with 300 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_frankfort"

#' @title Downstream data for Great Works
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Great Works Dam. 
#' Annual survival estimates 
#' from a variety of acoustic- and radio-telemetry studies were correlated with
#' annual, in-river discharge data from hydropower facilities by Amaral 
#' et al. (2012) to result in cumulative distribution functions from which 
#' smolt survival can be drawn probabilistically. This is the approach
#' used in the list of \code{downstream} passage rates for \code{great_works}
#' in the \code{\link{run_dia}} function when \code{great_works = NA}. However,
#' following removal of Great Works Dam in 2012, the default value used in 
#' the \code{\link{run_dia}} function is \code{great_works = 1}.
#' 
#' @format A dataframe with 7,168 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_greatworks"

#' @title Downstream data for Howland
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Howland Dam. 
#' Annual survival estimates 
#' from a variety of acoustic- and radio-telemetry studies were correlated with
#' annual, in-river discharge data from hydropower facilities by Amaral 
#' et al. (2012) to result in cumulative distribution functions from which 
#' smolt survival can be drawn probabilistically. This is the approach
#' used in the list of \code{downstream} passage rates for \code{howland}
#' in the \code{\link{run_dia}} function when \code{howland = NA}. However,
#' following construction of a nature-like bypass around Howland Dam associated
#' with the Penobscot River Restoration Project, the default value 
#' used in the \code{\link{run_dia}} function is \code{howland = 1}.
#' 
#' @format A dataframe with 3,315 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_howland"

#' @title Downstream data for Lowell
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Lowell Dam.
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the default approach used in the list of
#' \code{downstream} passage rates for \code{lowell} in the 
#' \code{\link{run_dia}} function when \code{lowell = NA}.
#' 
#' @format A dataframe with 450 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#'  
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_lowell"

#' @title Downstream data for Mattaceunk
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Mattaceunk Dam. 
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the default approach used in the list of
#' \code{downstream} passage rates for \code{mattaceunk} in the 
#' \code{\link{run_dia}} function when \code{mattaceunk = NA}.
#' 
#' @format A dataframe with 8,681 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_mattaceunk"

#' @title Downstream data for Medway
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Medway Dam.
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the approach used in the list of
#' \code{downstream} passage rates for \code{medway} in the 
#' \code{\link{run_dia}} function when \code{medway = NA}. The default 
#' \code{medway = 0} reflects that this habitat is currently inaccessible by
#' Atlantic salmon, but the data set is included as an option.
#' 
#' @format A dataframe with 7,589 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_medway"

#' @title Downstream data for Milford
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Milford Dam.
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the default approach used in the list of
#' \code{downstream} passage rates for \code{milford} in the 
#' \code{\link{run_dia}} function when \code{milford = NA}.
#' This dataset was updated in 2020 following changes to the
#' hydrosystem associated with the Penobscot River Restoration Project (Nieland
#' et al. 2020).
#' 
#' @format A dataframe with 9,356 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
#' 
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
"downstream_milford"

#' @title Downstream data for Milford (old)
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Milford Dam.
#' Atlantic salmon Dam Impact analysis model v67 for Milford Dam.
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the default approach used in the list of
#' \code{downstream} passage rates for \code{milford} in the 
#' \code{\link{run_dia}} function when \code{milford = NA} when 
#' \code{old_or_new = "new"}.
#' 
#' 
#' @format A dataframe with 7,168 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_milford_old"

#' @title Downstream data for Milo
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. Estimates are based on 
#' in-river flow.
#' 
#' @format A dataframe with 925 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_milo"

#' @title Downstream data for Moosehead
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Moosehead (Upper Dover) Dam.
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the approach used in the list of
#' \code{downstream} passage rates for \code{upper_dover} in the 
#' \code{\link{run_dia}} function when \code{upper_dover = NA}.
#' 
#' @format A dataframe with 753 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_moosehead"

#' @title Downstream data for Orono
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67. for Orono Dam. 
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the approach used in the list of
#' \code{downstream} passage rates for \code{upper_dover} in the 
#' \code{\link{run_dia}} function when \code{upper_dover = NA}.
#' This dataset was updated in 2020 following changes to the
#' hydrosystem associated with the Penobscot River Restoration Project.
#' 
#' @format A dataframe with 4,457 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
#' 
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
"downstream_orono"

#' @title Downstream data for Orono
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Orono Dam.
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the approach used in the list of
#' \code{downstream} passage rates for \code{orono} in the 
#' \code{\link{run_dia}} function when \code{orono = NA} and 
#' \code{new_or_old = "old"}.
#' 
#' @format A dataframe with 3,692 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_orono_old"

#' @title Downstream data for Sebec
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Sebec Dam.
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the approach used in the list of
#' \code{downstream} passage rates for \code{sebec} in the 
#' \code{\link{run_dia}} function when \code{sebec = NA}.
#' 
#' @format A dataframe with 745 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_sebec"

#' @title Downstream data for Stillwater
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Stillwater Dam.
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the approach used in the list of
#' \code{downstream} passage rates for \code{stillwater} in the 
#' \code{\link{run_dia}} function when \code{stillwater = NA}.
#' This dataset was updated in 2020 following changes to the
#' hydrosystem associated with the Penobscot River Restoration Project.
#' 
#' @format A dataframe with 4,456 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
#' 
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
"downstream_stillwater"

#' @title Downstream data for Stillwater (old)
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Stillwater Dam.
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the approach used in the list of
#' \code{downstream} passage rates for \code{stillwater} in the 
#' \code{\link{run_dia}} function when \code{stillwater = NA} and
#' \code{new_or_old = "old"}.
#' 
#' @format A dataframe with 3,692 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_stillwater_old"

#' @title Downstream data for Veazie
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for Veazie Dam.
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the approach used in the list of
#' \code{downstream} passage rates for \code{veazie} in the 
#' \code{\link{run_dia}} function when \code{veazie = NA}. However, following
#' removal of Veazie Dam in 2013, the default value is \code{veazie = 1}.
#' 
#' @format A dataframe with 13,939 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_veazie"

#' @title Downstream data for West Enfield
#' 
#' @description Alden research estimates of downstream survival from the 
#' Atlantic salmon Dam Impact analysis model v67 for West Enfield Dam.
#' Annual survival estimates from a variety of acoustic- and 
#' radio-telemetry studies were correlated with annual, in-river discharge data
#' from hydropower facilities by Amaral et al. (2012) to result in cumulative 
#' distribution functions from which smolt survival can be drawn 
#' probabilistically. This is the approach used in the list of
#' \code{downstream} passage rates for \code{west_enfield} in the 
#' \code{\link{run_dia}} function when \code{west_enfield = NA}.
#' 
#' @format A dataframe with 9,368 observations of 4 variables
#' \describe{
#'   \item{\code{flow_cfs}}{Value of flow (discharge)}
#'   \item{\code{cumulative_prob}}{Cumulative flow probability}
#'   \item{\code{flow_prob}}{Probability of individual flow value}
#'   \item{\code{smolt_surv_prob}}{Smolt survival probability given flow}
#' }
#' 
#' @source 
#' Amaral S, Fay C, Hecker G, Perkins N. 2012. Atlantic salmon survival 
#' estimates at mainstem hydroelectric projects on the Penobscot River. 
#' Holden (MA): Alden Research Laboratory, Inc. Phase 3 Final Report. 
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
"downstream_westenfield"

#' @title Default stocking proportions by production unit
#' 
#' @description Default proportion of stocked fish allocated to each PU
#' in the watershed from the Hatchery worksheet in the Atlantic salmon Dam 
#' Impact Analysis model v67. Used to distribute the number of stocked hatchery
#' smolts from the argument \code{n_stocked} in \code{\link{rund_dia}} when 
#' \code{stocking = 1}.
#' 
#' @format A dataframe with 15 observations of 2 variables
#' \describe{
#'   \item{\code{PU}}{Production unit}
#'   \item{\code{proportion_stocked}}{Proportion of hatchery smolts stocked in PU}
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
#'   \item{\code{PU}}{Production unit of origin}
#'   \item{\code{stillwater}}{Number of dams by natal PU encountered during downstream migration if fish move through the Stillwater Branch}
#'   \item{\code{mainstem}}{Number of dams by natal PU encountered during downstream migration if fish move through the mainstem Penobscot River} 
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
#' outmigrating smolts per km.
#' 
#' @format A dataframe with 34 observations of 3 variables
#' \describe{
#'   \item{\code{mort_per_km}}{Production unit of origin}
#'   \item{\code{cum_freq}}{Cumulative probability at mort_per_km}
#'   \item{\code{probs}}{Sampling probability}
#' }
#' 
#' @source 
#' Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon
#' in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of 
#' Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods 
#' Hole, MA.
#' 
"in_river_m"

#' @title River sections
#' 
#' @description Associations between production units and river "sections" used
#' to organize results in the output of \code{\link{run_dia}} and 
#' \code{\link{run_one_gen}} functions. Included for convenience.
#' 
#' @format A dataframe with 15 observations of 2 variables
#' \describe{
#'   \item{\code{PU}}{Production unit}
#'   \item{\code{river_section}}{Section of watershed by PU}
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