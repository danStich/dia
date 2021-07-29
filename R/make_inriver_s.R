#' @title Create natural in-river smolt survival by reach
#' 
#' @description Create natural in-river smolt mortality per kilometer from 
#' built-in datasets.
#' 
#' @param m Natural in-river mortality rate per km. The default (`NULL`) 
#' uses a truncated normal distribution with mean = 0.00329 and standard 
#' deviation of 0.00459 defined on the interval (0, 0.29)
#' 
#' @param initial Logical indicating Whether in-river mortality rate is for initial PU or
#' a PU downstream from where smolts started. If `TRUE` then default hatchery 
#' segment lengths is used to calculate whole-reach survival for hatchery smolts
#' as (1 - m) ^ dia::production_units$Hatchery_segment_length) and 1/2 of the
#' longest straight-line reach length 
#' (dia::production_units$Longest_segment_length_km) is used to calculate 
#' whole-reach survival of wild smolts. If `FALSE`, then both hatchery and wild
#' smolt survival is calculated from the longets straight-line reach length.
#' 
#' @param hatchery_wild A character string indicating whether reach mortality is
#' to be calculated for `"hatchery"` or `"wild"` smolts.
#' 
#' @param alt A numeric indicating whether to use 
#' `"Longest_segment_length"` (`alt = 0`), 
#' `"Partial_segment_length_1"` (`alt = 2`), or 
#' `"Partial_segment_length_2"` (`alt = 3`) from the `production_units` table to
#' calculate whole-reach survival rates based on per-km mortality.
#' 
#' @return A vector with 15 elements, I think...
#' 
#' @references Nieland et al. (2020).
#' 
#' @export
#' 
make_inriver_s <- function(m = NULL, initial = FALSE, hatchery_wild = "wild",
                           alt = 0){

    # Draw in-river mortality based on Nieland et al. (2020) if not defined
    if(is.null(m)){
    m <- truncnorm::rtruncnorm(n = 1, a = 0, b = 0.02928, mean = 0.00329,
                               sd = 0.00459)
    }
  
    if(!alt %in% c(0, 1, 2)){
      stop("alt must be 0, 1, or 2")
    }
  
    if(alt == 0){
      # Define which segment to use for which PU and rearing history
      if(initial == TRUE){
        
        if(hatchery_wild == "hatchery"){
          # In-river S for hatchery-stocked fish starting in PU
          in_river_s  <- (1 - m) ^ (dia::production_units$Hatchery_segment_length)
          
        }
        
        if(hatchery_wild == "wild"){
          # In-river S for wild-reared fish starting in PU
          in_river_s  <- (1 - m) ^ (dia::production_units$Longest_segment_length_km/2)
          in_river_s[1] <- (1 - m) ^ (dia::production_units$Longest_segment_length_km[1])
          
        }  
        
      }
    
      if(initial == FALSE){
          # In-river S for wild and hatchery fish migrating through PU
          in_river_s  <- (1 - m) ^ (dia::production_units$Longest_segment_length_km)
          
      }  
    }
  
    # Partial segment length (1) in production units sheet of Model67.xlsx ----
    if(alt == 1){
      # Define which segment to use for which PU and rearing history
      if(initial == TRUE){
        
        if(hatchery_wild == "hatchery"){
          # In-river S for hatchery-stocked fish starting in PU
          in_river_s  <- (1 - m) ^ (dia::production_units$Hatchery_segment_length)
          
        }
        
        if(hatchery_wild == "wild"){
          # In-river S for wild-reared fish starting in PU
          in_river_s  <- (1 - m) ^ (dia::production_units$Longest_segment_length_km/2)
          # Replace longest with partial (1)
          in_river_s[!is.na(dia::production_units$Partial_segment_length_1)] <- 
            (1 - m)  ^ (dia::production_units$Partial_segment_length_1/2)          
          
        }  
        
      }
    
      if(initial == FALSE){
          # In-river S for wild and hatchery fish migrating through PU
          in_river_s  <- (1 - m) ^ (dia::production_units$Longest_segment_length_km)
          # Replace longest with partial (1)
          in_river_s[!is.na(dia::production_units$Partial_segment_length_1)] <- 
            (1 - m)  ^ (dia::production_units$Partial_segment_length_1[!is.na(dia::production_units$Partial_segment_length_1)])           
          
      }
    }
      
    # Partial segment length (2) in production units sheet of Model67.xlsx ----
    if(alt == 2){
      # Define which segment to use for which PU and rearing history
      if(initial == TRUE){
        
        if(hatchery_wild == "hatchery"){
          # In-river S for hatchery-stocked fish starting in PU
          in_river_s  <- (1 - m) ^ (dia::production_units$Hatchery_segment_length)
          
        }
        
        if(hatchery_wild == "wild"){
          # In-river S for wild-reared fish starting in PU
          in_river_s  <- (1 - m) ^ (dia::production_units$Longest_segment_length_km/2)
          # Replace longest with partial (1)
          in_river_s[!is.na(dia::production_units$Partial_segment_length_2)] <- 
            (1 - m)  ^ (dia::production_units$Partial_segment_length_2/2)          
          
        }  
        
      }
    
      if(initial == FALSE){
          # In-river S for wild and hatchery fish migrating through PU
          in_river_s  <- (1 - m) ^ (dia::production_units$Longest_segment_length_km)
          # Replace longest with partial (1)
          in_river_s[!is.na(dia::production_units$Partial_segment_length_2)] <- 
            (1 - m)  ^ (dia::production_units$Partial_segment_length_2[!is.na(dia::production_units$Partial_segment_length_2)])           
          
      }
    }  
  
  
  return(in_river_s)
  
}
