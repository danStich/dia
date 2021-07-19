#' dia: Atlantic salmon Dam Impact Analysis (DIA) for R
#' 
#' The dia package is a collection of functions and datasets used to run
#' the Dam Impact Analysis (DIA) for Atlantic salmon in the Penobscot
#' River, Maine, USA.
#' 
#' @section Functions called directly:
#' The following functions can be called directly from dia.
#' 
# #'  \describe{
# #'    \code{link{run_dia}}{The primary user-facing function used to run the DIA}
# #'  }
#'  
#' @section Data:
#' The following built-in datasets are included:
#' 
#'   \describe{
#'     \code{\link{downstream_brownsmills}}{ Flow-correlated estimates of smolt survival through Browns Mills Dam} \cr
#'     \code{\link{downstream_frankfort}}{ Flow-correlated estimates of smolt survival through Frankfort Dam} \cr
#'     \code{\link{downstream_greatworks}}{ Flow-correlated estimates of smolt survival through Great Works Dam} \cr
#'     \code{\link{downstream_howland}}{ Flow-correlated estimates of smolt survival through Howland Dam} \cr
#'     \code{\link{downstream_lowell}}{ Flow-correlated estimates of smolt survival through Lowell Dam} \cr
#'     \code{\link{downstream_mattaceunk}}{ Flow-correlated estimates of smolt survival through Mattaceunk Dam} \cr
#'     \code{\link{downstream_medway}}{ Flow-correlated estimates of smolt survival through Medway Dam} \cr
#'     \code{\link{downstream_milford}}{ Updated (2020) flow-correlated estimates of smolt survival through Milford Dam} \cr
#'     \code{\link{downstream_milford_old}}{ Original (2013) flow-correlated estimates of smolt survival through Milford Dam} \cr
#'     \code{\link{downstream_milo}}{ Flow-correlated estimates of smolt survival through Milo Dam} \cr
#'     \code{\link{downstream_moosehead}}{ Flow-correlated estimates of smolt survival through Moosehead Dam} \cr
#'     \code{\link{downstream_orono}}{ Updated (2020) flow-correlated estimates of smolt survival through Orono Dam} \cr
#'     \code{\link{downstream_orono_old}}{ Original (2013) flow-correlated estimates of smolt survival through Orono Dam} \cr
#'     \code{\link{downstream_sebec}}{ Flow-correlated estimates of smolt survival through Sebec Dam} \cr
#'     \code{\link{downstream_stillwater}}{ Updated (2020) flow-correlated estimates of smolt survival through Stillwater Dam} \cr
#'     \code{\link{downstream_stillwater_old}}{ Original (2013) flow-correlated estimates of smolt survival through Stillwater Dam} \cr
#'     \code{\link{downstream_veazie}}{ Flow-correlated estimates of smolt survival through Veazie Dam} \cr
#'     \code{\link{downstream_westenfield}}{ Flow-correlated estimates of smolt survival through West Enfield Dam} \cr
#'     \code{\link{life_stage_survival}}{ Distributional parameters for year-specific number of eggs produced per female, egg-to-smolt survival rate, in-river mortality rate, and marine survival rate} \cr
#'     \code{\link{production_units}}{ Division of Penobscot River watershed into sections, or Production Units (PUs)} \cr
#'     \code{\link{stillwater_use}}{ Updated (2020) probability of smolts using Stillwater Branch for outmigration given discharge} \cr
#'     \code{\link{stillwater_use_old}}{ Original (2013) probability of smolts using Stillwater Branch for outmigration given discharge} \cr
#'     \code{\link{stocking_default}}{ Default stocking proportions of smolts by PU} \cr
#'     \code{\link{straying_locations}}{ Straying locations of adult Atlantic salmon based on behavioral patterns} \cr
#'   }
#'
#' @docType package
#' 
#' @name dia
#' 
# #' @importFrom truncnorm rtruncnorm
# #' @importFrom stats quantile rnorm runif sd
NULL
