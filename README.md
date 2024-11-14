# dia

[![DOI](https://zenodo.org/badge/383607566.svg)](https://zenodo.org/doi/10.5281/zenodo.13376045)

## Overview

An R package for hosting code and data, and running the Atlantic salmon Dam Impact Analysis (DIA) model. This package was designed to provide a transparent, open-source version of the National Oceanic and Atmospheric Administration's Dam Impact Analysis (DIA) model for Atlantic salmon (*Salmo salar*) in the Penobscot River, Maine, USA. We created the package for use by fisheries scientists, managers, and decision makers as a transparent tool to support decision-making related to conservation of Atlantic salmon in this priority waterbody. It uses life-history data, flow-specific survival rates and other empirical estimates to simulate the response of Atlantic salmon in the Penobscot River over multiple generations to key conservation and restoration decisions such as supplemental fish stocking and passage through hydropower dams.

## Installation

The development version of `dia` can be installed with  [`devtools`](https://www.rstudio.com/products/rpackages/devtools/) in R using the repository url:

`devtools::install_github("danStich/dia")`

To install `dia`, you will need to have `devtools` installed ahead of time in R, but that requires some special tools. To install on **Windows**, you will need to download and install the appropriate version of [Rtools](https://cran.r-project.org/bin/windows/Rtools/). To install on **Mac**, you will need to have the [XCode command-line tools](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/) installed. And, if running from **Linux**, you will need to install the developer version of R (`r-base-dev`) if you have not already.

## Directories

`data/` Contains built-in data sets for the package

`man/`  help files and documentation

`R/`    R functions in scripts

`inst/shiny-examples/dia_shiny` includes server and ui files for `run_dia_shiny()`, a shiny-based user interface

`tests/` Includes package tests for default parameter accuracy conducted on package build

## Getting started
There are two primary user-facing functions within the `dia` package. The `run_dia()` function can be called within an Rscript to run the Dam Impact Analysis (DIA) model using default or user-defined inputs. The `run_dia_shiny()` function launches a graphical user interface (GUI) that opens in a web browser and is written with the `shiny` package. The former provides functionality for large-scale simulation studies in R whereas the latter provides an intuitive  interface for running smaller numbers of management scenarios.

### `run_dia()`
The `run_dia()` function provides the primary user-facing function for the `dia` package. The purpose of the function is to run the Dam Impact Analysis for some number of generations (15 by default). The output of this function is a  dataframe (i.e., data table) containing number of wild and hatchery-origin adult returns in each generation. All default argument values (model inputs) are  based on the most-recent version of the NOAA Dam Impact Analysis Excel-based model (v67, [Nieland et al. 2013](https://repository.library.noaa.gov/view/noaa/55737); [Nieland et al. 2015](https://academic.oup.com/icesjms/article-pdf/72/8/2423/31226690/fsv083.pdf); [Nieland and Sheehan 2020](https://repository.library.noaa.gov/view/noaa/23714)).

The `run_dia()` function allows user to specify number of generations,  number of starting wild and hatchery adults, whether stocking is turned on or off, how many fish are stocked in each production unit of the river, upstream and downstream dam passage rates, and other life-history or dam-related vital rates.

You can find the help file for the `run_dia()` function in R by running: `?dia::run_dia`. This file contains all accepted user arguments, explanations of what they mean and what are default values, and examples of how to use
the `run_dia()` function. Examples are shown at the bottom of this page.

### `run_dia_shiny()`
The `run_dia_shiny()` function provides an intuitive user interface for running  the DIA model. Though more limited in flexibility than `run_dia()`, the simplified interface should allow full exploration of management scenarios. The primary difference is that `run_dia_shiny()` does not allow the user to input custom distributions or values for some input parameters such as the `straying_matrix` or `inefficiency_matrix` implemented in the `run_dia()` function. 

Currently, the shiny interface for the DIA model can only be called directly from R or Rstudio by running the following lines of code:
```
library(dia)
run_dia_shiny()
```

This will open the user-interface in a local instance of the default web browser on the computer where further instructions are provided.

## Examples using `run_dia()`

### Single simulation
An example of a single simulation using `run_dia()` is demonstrated below, using the default values based on Nieland et al. ([2013](https://repository.library.noaa.gov/view/noaa/4559), [2015](https://academic.oup.com/icesjms/article/72/8/2423/2458708)) and [Nieland and Sheehan (2020)](https://repository.library.noaa.gov/view/noaa/23714).

```
library(dia)

# For reproducibility: comment out the next line if you wish to sample stochastically
set.seed(7475)

run_dia(
  n_generations = 15,
  n_wild = 31,
  n_hatchery = 306,
  stocking = 1,
  n_stocked = rep(545000, 15),
  upstream = list(
    medway = 0, 
    mattaceunk = 0.9, 
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
  p_female = 0.6,
  new_or_old = "new",
  marine_s_hatchery = NA,
  marine_s_wild = NA,
  straying_matrix = NULL,
  p_mainstem_up = 1,
  n_broodstock = 150)
```

### Multiple simulations for a single scenario
An example of a single simulation using `run_dia()` is demonstrated below,
using the default values based on Nieland et al. (2013, 2015) and
Nieland and Sheehan (2020).

```
library(foreach)
library(tidyverse)
library(dia)

# For reproducibility: comment out the next line if you wish to sample stochastically
set.seed(7475) 

# Choose number of iterations
n <- 100

# Create a list holding model output
outlist <- foreach(1:n) %do%
  run_dia(
    n_generations = 15,
    n_wild = 31,
    n_hatchery = 306,
    stocking = 1,
    n_stocked = rep(545000, 15),
    upstream = list(
      medway = 0, 
      mattaceunk = 0.9, 
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
    p_female = 0.6,
    new_or_old = "new",
    marine_s_hatchery = NA,
    marine_s_wild = NA,
    straying_matrix = NULL,
    p_mainstem_up = 1,
    n_broodstock = 150
  )
  
# Collect results into a single dataframe
names(outlist) <- paste0("run_", seq(1, length(outlist)))
out_df <- do.call(rbind, outlist)

# Summarize results across number of runs
plotter <- out_df %>% 
          group_by(generation, origin, production_unit) %>% 
          summarize(abund = median(abundance),
                    lwr = quantile(abundance, 0.025),
                    upr = quantile(abundance, 0.975)
                    ) %>% 
          group_by(generation, origin) %>% 
          summarize(abundance = sum(abund),
                    lwr = sum(lwr),
                    upr = sum(upr)
                    )

# Plot results
ggplot(plotter, aes(x = generation, y = abundance,
            color = origin, fill = origin)) +
  geom_line() +
  geom_ribbon(aes(x = generation, ymin = lwr, ymax = upr, color = NULL),
              alpha = 0.1)    
```

### Example of parallel execution for running multiple models using snowfall
```
# Libraries ----
library(tidyverse)
library(snowfall)
library(dia)
library(data.table)

# For reproducibility: comment out this line if you wish to sample stochastically
set.seed(7475) 

# Parallel settings ----
# Get number of nodes (cpu cores - 1) for the sfInit() function from snowfall
ncpus <- parallel::detectCores() - 1

# Initialize snowfall socket cluster to register the parallel back-end
sfInit(parallel = TRUE, cpus = ncpus, type = "SOCK")

# Define a wrapper function that will be deployed to parallel nodes ----
sim <- function(x){

    # Run the dia function once per deployment on a parallel node
    # and save the result to an output object that can be returned
    # locally in a list of results from the parallel process
    output <- run_dia(n_generations = 15,
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
    )

  # Save the output from the call to run_dia() to an element in an
  # output list that can be returned locally   
  out_list <- list(
    output = output)

  return(out_list)
    
}


# Parallel execution ----
# . Load libraries on nodes using sfLibrary() from the snowfall package -----
sfLibrary(dia)


# . Distribute to workers -----
# Number of simulations to run
niterations <- 5e3


# . Run the simulation ----
# Record start time for benchmarking
start <- Sys.time()

# Run simulation and return results using the sfLapply() function
# from the snowfall package
result <- sfLapply(1:niterations, sim) 

# Calculate total time elapsed for benchmarking
total_time <- Sys.time()-start
total_time


# Result processing ----
# Extract results dataframes by string and rbind all list elements
res <- lapply(result, function(x) x[[c('output')]])
out_df <- data.frame(data.table::rbindlist(res))


# Result summary ----
# Summarize results across replicate stochastic model realizations
plotter <- out_df %>% 
          group_by(generation, origin, production_unit) %>% 
          summarize(abund = median(abundance),
                    lwr = quantile(abundance, 0.025),
                    upr = quantile(abundance, 0.975)) %>% 
          group_by(generation, origin) %>% 
          summarize(abundance = sum(abund),
                    lwr = sum(lwr),
                    upr = sum(upr))

# Plot results
ggplot(plotter, aes(x = generation, y = abundance,
            color = origin, fill = origin)) +
  geom_line() +
  geom_ribbon(aes(x = generation, ymin = lwr, ymax = upr, color = NULL),
              alpha = 0.1)          
```

## References
Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods Hole, MA. URL: [https://repository.library.noaa.gov/view/noaa/23714](https://repository.library.noaa.gov/view/noaa/23714).

Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams on diadromous fish: a case study for Atlantic salmon in the Penobscot River, Maine. ICES Journal of Marine Science 72:2423–2437. URL: [https://academic.oup.com/icesjms/article/72/8/2423/2458708](https://academic.oup.com/icesjms/article/72/8/2423/2458708).

Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US Department of Commerce, Northeast Fisheries Science Center Reference Document 13-09, Woods Hole, MA. URL: [https://repository.library.noaa.gov/view/noaa/4559](https://repository.library.noaa.gov/view/noaa/4559).
