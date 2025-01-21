# dia

An R package for the National Oceanic and Atmospheric Administration dam impact analysis

[![DOI](https://zenodo.org/badge/383607566.svg)](https://zenodo.org/doi/10.5281/zenodo.13376045) 
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![DOI](https://joss.theoj.org/papers/10.21105/joss.07475/status.svg)](https://doi.org/10.21105/joss.07475)

## Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Getting Started](#getting-started)
- [Examples](#examples)
- [References](#references)

## Overview
An R package for hosting code and data, and running the Atlantic salmon Dam Impact Analysis (DIA) model. This package was designed to provide a transparent, open-source version of the National Oceanic and Atmospheric Administration's Dam Impact Analysis (DIA) model for Atlantic salmon (*Salmo salar*) in the Penobscot River, Maine, USA, that was previously hosted as an @RISK add on for Microsoft Excel. We created the package for use by fisheries scientists, managers, and decision makers as a transparent tool to support decision-making related to conservation of Atlantic salmon in this priority waterbody that hosts the majority of adult returns to the USA each year. It uses life-history data, flow-specific survival rates and other empirical estimates to simulate the response of Atlantic salmon in the Penobscot River over multiple generations to key conservation and restoration decisions such as supplemental fish stocking and passage through hydropower dams. A number of example uses are provided below that build in complexity.

The full details of the model parameterization, including background information about the Atlantic salmon life cycle and the Penobscot River, are available from [Nieland et al. (2013)](https://repository.library.noaa.gov/view/noaa/4559), with a specific case study by [Nieland et al. (2015)](https://academic.oup.com/icesjms/article/72/8/2423/2458708) and updated biological data and a second case study in [Nieland and Sheehan (2020)](https://repository.library.noaa.gov/view/noaa/23714). Below is a comparison of the original model parameterized by Nieland et al. (2013) and the core workflow of the `dia` package. Helper functions and built-in data sets are used to simulate a population through space in a single generation using the `run_one_gen()` function, which is then wrapped in the `run_dia()` function that facilitates stochastic simulation over a user-specified number of generations.

We are actively working to generalize the functions in the `dia` package and others to facilitate use for other efforts. While many of the data sets, population vital-rate simulation routines, and helper functions are relatively generalizable among populations or even to other species, the underlying `production_units` table and associated default `straying_matrix` for natal 
homing are currently river-specific. For this reason, we welcome contributions that would help generalize the approach to creating structural river systems that underly population models in this package. You can learn more about contributing to this package in [`Contributing.md`](https://github.com/danStich/dia/blob/main/Contributing.md) in this GitHub repository.

<br></br>

![**Figure**: Graphical overview of the *dia* work flow (right) compared to the original Atlantic salmon *Salmo salar* lifecycle model presented by Nieland et al. (2013, 2015, 2020). Rounded rectangles are Atlantic salmon life stages, ovals are additions to population, and rectangles are subtractions from populations. Dashed rectangles indicate stochastic dynamics that are implemented within the model but that are neither additions nor subtractions. In the *dia* workflow, some noteable helper functions are shown in bold and have trailing parentheses (e.g., **`smolt_stocking()`**), built-in datasets are in bold with no trailing parentheses (e.g., **`life_stage_survival`**), and user-specified arguments to `run_dia()` are in plain font. You can learn more about these and other user-facing functions by running `help("dia")` after you've installed the package. The source code for `run_dia()` and all helper functions can be exposed by running, for example, `print(run_dia)` to further clarify workflows.](inst/images/Figure2.png?raw=true)


## Installation

The development version of `dia` can be installed with  [`devtools`](https://www.rstudio.com/products/rpackages/devtools/) in R using the repository url:

`devtools::install_github("danStich/dia")`

To install `dia`, you will need to have `devtools` installed ahead of time in R, but that requires some special tools. To install on **Windows**, you will need to download and install the appropriate version of [Rtools](https://cran.r-project.org/bin/windows/Rtools/). To install on **Mac**, you will need to have the [XCode command-line tools](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/) installed. And, if running from **Linux**, you will need to install the developer version of R (`r-base-dev`) if you have not already.

## Directories

`data/` Contains built-in data sets for the package

`man/`  help files and documentation

`R/`    R functions in scripts

`inst/images` includes images used in this README

`inst/shiny-examples/dia_shiny` includes server and ui files for `run_dia_shiny()`, a shiny-based user interface

`tests/` Includes package tests for default parameter accuracy conducted on package build

## Getting started
There are two primary user-facing functions within the `dia` package. The `run_dia()` function can be called within an Rscript to run the Dam Impact Analysis (DIA) model using default or user-defined inputs. The `run_dia_shiny()` function launches a graphical user interface (GUI) that opens in a web browser and is written with the `shiny` package. The former provides functionality for large-scale simulation studies in R whereas the latter provides an intuitive  interface for running smaller numbers of management scenarios.

### `run_dia()`
The `run_dia()` function provides the primary user-facing function for the `dia` package. The purpose of the function is to run the Dam Impact Analysis for some number of generations (15 by default). The output of this function is a  dataframe (i.e., data table) containing number of wild and hatchery-origin adult returns in each generation. All default argument values (model inputs) are  based on the most-recent version of the NOAA Dam Impact Analysis Excel-based model (v67, [Nieland et al. 2013](https://repository.library.noaa.gov/view/noaa/55737); [Nieland et al. 2015](https://academic.oup.com/icesjms/article-pdf/72/8/2423/31226690/fsv083.pdf); [Nieland and Sheehan 2020](https://repository.library.noaa.gov/view/noaa/23714)).

The `run_dia()` function allows users to specify number of generations,  number of starting wild and hatchery adults, whether stocking is turned on or off, how many fish are stocked in each production unit of the river, upstream and downstream dam passage rates, and other life-history or dam-related vital rates.

You can find the help file for the `run_dia()` function in R by running: `?dia::run_dia`. This file contains all accepted user arguments, explanations of what they mean and what are default values, and examples of how to use
the `run_dia()` function. Examples are shown at the bottom of this page. You can browse a list of all helper functions called by `run_dia()` as well as all built-in datasets and their metadata by running `help("dia") or ?dia`.

### `run_dia_shiny()`
The `run_dia_shiny()` function provides an intuitive user interface for running  the DIA model. Though more limited in flexibility than `run_dia()`, the simplified interface should allow full exploration of management scenarios. The primary difference is that `run_dia_shiny()` does not allow the user to input custom distributions or values for some input parameters such as the `straying_matrix` or `inefficiency_matrix` implemented in the `run_dia()` function. 

Currently, the shiny interface for the DIA model can only be called directly from R or Rstudio by running the following lines of code:
```
library(dia)
run_dia_shiny()
```

This will open the user-interface in a local instance of the default web browser on the computer where further instructions are provided.


## Examples
We provide a range of examples for using the `run_dia()` function below to demonstrate flexibility in application for predicting population response to restoration scenarios or uncertainty and variability in biological parameters. 

We build complexity from single-use cases, to small simulation studies, to large parallel computations that can be used to explore restoration scenarios or model uncertainties further by the users. To do this, we use the default model parameters for the first three examples to demonstrate a single realization, a small run of 100 iterations, and a larger simulation of hundreds or thousands of iterations in parallel. We then use the parallel framework, which we prefer for simulation studies, to demonstrate how the user can specify custom argument values to provide concrete applications of this tool to answer restoration questions.

Most of the arguments passed to `run_dia()` can accept custom user input, for a near infinite number of potential scenarios that could be assessed for a wide variety of questions. We have selected two common examples for demonstration: 1) simulating outcomes of hypothetical dam removals, and 2) testing sensitivity of restoration outcomes to biological uncertainty or variability.


### Single simulation using default values
An example of a single simulation using `run_dia()` is demonstrated below,  using the default values based on Nieland et al. ([2013](https://repository.library.noaa.gov/view/noaa/4559), [2015](https://academic.oup.com/icesjms/article/72/8/2423/2458708)) and [Nieland and Sheehan (2020)](https://repository.library.noaa.gov/view/noaa/23714). Each of these default values can be modified by the user, as we demonstrate in later examples. They each have default values and do not need to be explicitly specified unless changing the value, but all are shown here so we can see what they are.

The output is a dataframe with 1 observation of 2 sea-winter spawning females (`abundance`) reaching each production unit in the watershed in each generation, by rearing origin (`'hatchery'` or `'wild'`). Graphically, we'll need to run more simulations to summarize these results in a meaningful way. That is the objective of the next several examples.

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

### Multiple simulations using default values
An example of a single simulation using `run_dia()` is demonstrated below, using the default values based on Nieland et al. (2013, 2015) and Nieland and Sheehan (2020). This example demonstrates serial, looped execution using the `foreach` package, although we do not recommend this approach for  large numbers of simulations (see subsequent examples about parallel execution for these). This example includes code for processing serial list output, summarizing results through tidy workflows using the `tidyverse`, and visualization of results with `ggplot2` and related utilities.

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

### Parallel execution of multiple simulations using default values
This example demonstrates execution of multiple simulations in parallel to make better use of local or remote compute clusters. We rely primarily on the `snowfall` package, but this approach is transferrable to any parallel back-end in R as far as we know. This example includes code for processing parallel  output, summarizing results through tidy workflows using the `tidyverse`, and visualization of results with `ggplot2` and related utilities. 

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

### Simulating population response to dam removals
This example demonstrates how to simulate, for example, the removal of several dams as part of a hypothetical dam removal fabricated for the sake of demonstration. We use the parallel approach to stochastic sampling demonstrated above to simulate new population abundances when four dams are removed from the Piscataquis River (Upper Dover, Browns Mills, Sebec, Milo, and Howland dams). To do this, we can simply set their list elements in `upstream` and `downstream` to `1`, indicating that the dams present no impediment to migration. We demonstrate how the parallel simulation outputs can be processed through convenient, tidy workflows using the `tidyverse` and visualized with `ggplot2`.

```
# Example of parallel execution for assessing dam removals ----
# . Libraries ----
library(tidyverse)
library(snowfall)
library(dia)
library(data.table)

# For reproducibility: uncomment the line below to sample stochastically
set.seed(7475)

# . Parallel settings ----
# Get number of nodes (cpu cores - 1)
ncpus <- parallel::detectCores() - 1

# Initialize snowfall socket cluster
sfInit(parallel = TRUE, cpus = ncpus, type = "SOCK")

# . Wrapper function for worker nodes ----
sim <- function(x){
  
    # Replace upstream and downstream passage rates 
    # with "1" to indicate removal of dam. In this example,
    # we'll assess influence of removing all dams in the
    # Piscataquis River (upper_dover, browns_mills, sebec, milo, 
    # and howland).
    output <- run_dia(n_generations = 15,
    n_wild = 31, 
    n_hatchery = 306,
    stocking = 1,
    n_stocked = rep(545000, 15),
    upstream = list(
      medway = 0,
      mattaceunk = 0.90,
      west_enfield = 0.95,
      upper_dover = 1,
      browns_mills = 1,
      sebec = 1,
      milo = 1,
      howland = 1,
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
      upper_dover = 1,
      browns_mills = 1,
      sebec = 1,
      milo = 1,
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
    n_broodstock = 150)
    
  out_list <- list(
    output = output)
  
  return(out_list)
    
}


# . Parallel execution ----
# .. Load libraries on workers -----
sfLibrary(dia)


# .. Distribute to workers -----
# Number of simulations to run
niterations <- 1e4


# .. Run the simulation ----
# Record start time
start <- Sys.time()

# Run simulation and return results
result <- sfLapply(1:niterations, sim) 

# Calculate total time elapsed for benchmarking
total_time <- Sys.time()-start
total_time


# . Result processing ----
# Extract results dataframes by string and rbind all list elements
res <- lapply(result, function(x) x[[c('output')]])
out_df <- data.frame(data.table::rbindlist(res))

# . Result summary ----
# .. By generation ----
# Summarize results across replicate stochastic model realizations
plotter <- out_df %>% 
          group_by(generation, origin, production_unit) %>% 
          summarize(abund = median(abundance),
                    lwr = quantile(abundance, 0.025),
                    upr = quantile(abundance, 0.975)) %>% 
          group_by(generation, origin) %>% 
          summarize(abundance = sum(abund),
                    lwr = sum(lwr),
                    upr = sum(upr)) %>% 
          mutate(origin = str_to_sentence(origin))

# Plot results by generation
generations <- ggplot(plotter, aes(x = generation, y = abundance,
            color = origin, fill = origin)) +
  geom_line() +
  geom_ribbon(aes(x = generation, ymin = lwr, ymax = upr, color = NULL),
              alpha = 0.25) +
  xlab("Generation number") +
  ylab("Abundance") +
  labs(color = "Origin", fill = "Origin") +
  annotate("text", x = 1, y = 3500, label = "(a)")

# .. By production unit ----
# Summarize results across replicate stochastic model realizations
plotter <- out_df %>% 
  filter(generation == 15) %>% 
  mutate(production_unit = substr(production_unit, 4, 5)) %>% 
  mutate(origin = str_to_sentence(origin))

# Plot results by generation
pus <- ggplot(plotter, aes(x = production_unit, y = abundance,
                    color = origin, fill = origin)) +
  geom_boxplot(alpha = 0.25) +
  xlab("Production unit") +
  ylab("Abundance") +
  labs(color = "Origin", fill = "Origin") +
  annotate("text", x = 1, y = 5000, label = "(b)")

gridExtra::grid.arrange(generations, pus)

```

### Assess sensitivity of restoration outcomes to uncertainty or variability
This example demonstrates how to simulate population sensitivity to underlying model parameters using the parallel approach to stochastic sampling demonstrated above. In this example, we run the model under a wide range of marine survival rates for wild fish to investigate how uncertainty or variability in this parameter could influence predicted outcomes of restoration efforts. We continue to demonstrate how to summarize simulation outputs using tidy workflows from the `tidyverse` and visualization with `ggplot2`. We recommend copying the code below into an editor such as RStudio to view syntax highlighting and make use of code-folding tabs.

```
# Example of parallel execution for assessing marine survival ----
# . Libraries ----
library(tidyverse)
library(snowfall)
library(dia)
library(data.table)

# For reproducibility: uncomment the line below to sample stochastically
set.seed(7475)

# . Parallel settings ----
# Get number of nodes (cpu cores - 1)
ncpus <- parallel::detectCores() - 1

# Initialize snowfall socket cluster
sfInit(parallel = TRUE, cpus = ncpus, type = "SOCK")

# . Wrapper function for worker nodes ----
sim <- function(x){
  
  # Here, we use the default values for everything except marine survival
  # of wild fish and then plot the results to determine sensitivity of
  # species recovery to changes in marine survival.
  
  # Simulate marine survival from a truncated normal distribution
  # using the make_marine_s() function from the dia package
  # like this (uncomment to run).
  # marine_s_wild <- dia::make_marine_s(n = 1, a = 0, b = 0.25,
  #                                     hatchery = FALSE)  
  
  # Alternatively, we could just specify a sample from a range of values:
  marine_s_wild <- sample( seq(0, 0.025, 0.001), 1, replace = TRUE)
  
  output <- run_dia(marine_s_wild = marine_s_wild)
  
  output$marine_s_wild <- marine_s_wild
  
  out_list <- list(
    output = output)
  
  return(out_list)
  
}


# . Parallel execution ----
# .. Load libraries on workers -----
sfLibrary(dia)


# .. Distribute to workers -----
# Number of simulations to run
niterations <- 1e3


# .. Run the simulation ----
# Record start time
start <- Sys.time()

# Run simulation and return results
result <- sfLapply(1:niterations, sim) 

# Calculate total time elapsed for benchmarking
total_time <- Sys.time()-start
total_time


# . Result processing ----
# Extract results dataframes by string and rbind all list elements
res <- lapply(result, function(x) x[[c('output')]])
out_df <- data.frame(data.table::rbindlist(res))

# . Result summary ----
# .. Sensitivity to marine s ----
# Summarize results across replicate stochastic model realizations
# to examine variability in abundance in generation 15 compared to
# variability in marine survival
plotter <- out_df %>% 
  filter(generation == 15) %>%   
  mutate(marine_s_wild = round(marine_s_wild, 3)) %>% 
  group_by(production_unit, origin, marine_s_wild) %>% 
  summarize(abund = median(abundance),
            lwr = quantile(abundance, 0.025),
            upr = quantile(abundance, 0.975)) %>% 
  group_by(origin, marine_s_wild) %>% 
  summarize(abundance = sum(abund),
            lwr = sum(lwr),
            upr = sum(upr)) %>% 
  mutate(origin = str_to_sentence(origin))

# Plot results by generation
  ggplot(plotter, aes(x = marine_s_wild, 
                      y = abundance,
                      color = origin, 
                      fill = origin)) +
    geom_line() +
    geom_ribbon(aes(xmax = marine_s_wild, ymin = lwr, ymax = upr, color = NULL),
                alpha = 0.50) +
    xlab("Generation number") +
    ylab("Abundance") +
    labs(color = "Origin", fill = "Origin")
```

## References
Nieland JL, Sheehan TF. 2020. Quantifying the Effects of Dams on Atlantic Salmon in the Penobscot River Watershed, with a Focus on Weldon Dam. US Department of Commerce, Northeast Fisheries Science Center Reference Document 19-16, Woods Hole, MA. URL: [https://repository.library.noaa.gov/view/noaa/23714](https://repository.library.noaa.gov/view/noaa/23714).

Nieland JL, Sheehan TF, Saunders R. 2015. Assessing demographic effects of dams on diadromous fish: a case study for Atlantic salmon in the Penobscot River, Maine. ICES Journal of Marine Science 72:2423–2437. URL: [https://academic.oup.com/icesjms/article/72/8/2423/2458708](https://academic.oup.com/icesjms/article/72/8/2423/2458708).

Nieland JL, Sheehan TF, Saunders R, Murphy JS, Trinko Lake TR, Stevens JR. 2013. Dam Impact Analysis model for Atlantic salmon in the Penobscot River, Maine. US Department of Commerce, Northeast Fisheries Science Center Reference Document 13-09, Woods Hole, MA. URL: [https://repository.library.noaa.gov/view/noaa/4559](https://repository.library.noaa.gov/view/noaa/4559).
