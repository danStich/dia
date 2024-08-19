# dia

An R package for hosting code and data, and running the Atlantic salmon Dam Impact Analysis (DIA) model.

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
There are two primary user-facing functions within the `dia` package. The 
`run_dia()` function can be called within an Rscript to run the Dam Impact Analysis (DIA) model using default or user-defined inputs. The `run_dia_shiny()` function launches a graphical user interface (GUI) that opens in a web browser and is written with the `shiny` package. The former provides functionality for large-scale simulation studies in R whereas the latter provides an intuitive  interface for running smaller numbers of management scenarios.

### `run_dia()`
The `run_dia()` function provides the primary user-facing function for the `dia` package. The purpose of the function is to run the Dam Impact Analysis for some number of generations (15 by default). The output of this function is a  dataframe (ie. data table) containing number of wild and hatchery-origin adult returns in each generation. All default argument values (model inputs) are  based on the most-recent version of the NOAA Dam Impact Analysis Excel-based model (v67, Nieland et al. 2013, 2015; Nieland and Sheehan 2020).

The `run_dia()` function allows user to specify number of generations,  number of starting wild and hatchery adults, whether stocking is turned on or off, how many fish are stocked in each production unit of the river, upstream and downstream dam passage rates, and other life-history or dam-related vital rates.

You can find the help file for the `run_dia()` function in R by running:
`?dia::run_dia`. This file contains all accepted user arguments, explanations
of what they mean and what are default values, and examples of how to use
the `run_dia()` function. Examples are shownd at the bottom of this page.

### `run_dia_shiny()`
The `run_dia_shiny()` function provides and intuitive user interface for running  the DIA model. Though more limited in flexibility that `run_dia()`, the simplified interface should allow full exploration of management scenarios. The primary difference is that `run_dia_shiny()` does not allow the user to input custom distributions or values for some input parameters such as the `straying_matrix` or `inefficiency_matrix` implemented in the `run_dia()` function. 

Currently, the shiny interface for the DIA model can only be called directly from R or Rstudio by running the following lines of code:
```
library(dia)
run_dia_shiny()
```

This will open the user-interface in a local instance of the default web browser on the computer where further instructions are provided.

## Examples using `run_dia()`

### Single simulation
An example of a single simulation using `run_dia()` is demonstrated below,using the default values based on Nieland et al. (2013, 2015) and Nieland and Sheehan (2020).

```
library(dia)
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

### Example of parallel execution for running multiple models
```
# Libraries ----
library(tidyverse)
library(snowfall)
library(dia)
library(data.table)

# Parallel settings ----
# Get number of nodes (cpu cores - 1)
ncpus <- 10

# Initialize snowfall socket cluster
sfInit(parallel = TRUE, cpus = ncpus, type = "SOCK")

# Wrapper function for worker nodes ----
sim <- function(x){
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
    
  out_list <- list(
    output = output)
  
  return(out_list)
    
}


# Parallel execution ----
# . Load libraries on workers -----
sfLibrary(dia)


# . Distribute to workers -----
# Number of simulations to run
niterations <- 5e3


# . Run the simulation ----
# Record start time
start <- Sys.time()

# Run simulation and return results
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
