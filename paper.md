---
title: 'dia: An R package for the National Oceanic and Atmospheric Administration dam impact analysis'
tags:
  - R
  - fisheries
  - dams
  - population dynamics
  - life history models
output:
  html_document:
    df_print: paged
  word_document: default
authors:
  - name: Daniel S. Stich
    orcid: "0000-0002-8946-1115"
    corresponding: true
    affiliation: "1"
  - name: Julie L. Nieland
    affiliation: "2"
  - name: Timothy F. Sheehan
    orcid: "0000-0002-9689-1180"
    affiliation: "2"
affiliations:
- name: Biology Department and Biological Field Station, State University of New York at Oneonta, NY 13280 USA
  index: 1
- name: National Oceanic and Atmospheric Administration, National Marine Fisheries Service, Northeast Fisheries Science Center, Woods Hole, MA 02543 USA
  index: 2
date: 22 October 2024
bibliography: paper.bib
---

# Summary

Populations of anadromous (sea-run) fishes such as Atlantic salmon *Salmo salar* have experienced severe global declines as a result of pollution, overfishing, and construction of dams [@limburg:2009]. Life-history-based simulation models are commonly used for planning and implementing fisheries recovery activities for many diadromous species [e.g., @nieland:2013; @barber:2018; @stich:2019; @zydlewski:2021]. Before open-source tools became prevalent, many institutionalized decision-support tools utilizing such models relied on closed-source or paid software. For example, the National Oceanic and Atmospheric Administration (NOAA) Dam Impact Analysis (DIA) was originally created as a stochastic life cycle model for Atlantic salmon in the `@RISK` add-in within Microsoft Excel [@nieland:2013]. This tool differs from those hosted in similar R packages for non-salmonid species [e.g. @stich:2019; @zydlewski:2021] in that it incorporates homing behavior (probability of adults returning to natal streams or straying to others) and integrates results of physical modeling to inform population dynamics [@nieland:2013; @nieland:2020]. This class of tools, in general, provides advantages for decision making related to anadromous species because it allows integration of geographically and temporally explicit stock dynamics (e.g., influences of dams) that are not readily implemented in classical fisheries stock assessment tools such as those available in existing R packages [e.g. @FLR; @Erickson2022; @FSA]. We created the `dia` package [@dia] for the R programming language [@R] as a freely accessible, open-source implementation of these tools that will promote transparency in planning and decision making.

# Statement of need

`dia` is an R-based implementation of a previously closed-source life cycle model of Atlantic salmon population dynamics that is used to understand population response to natural and anthropogenic influences in freshwater and marine environments. It was developed to assess the sensitivity of restoration outcomes to uncertainty in life-history inputs alongside the impacts of dams and restoration activities. The DIA model uses empirical life-history estimates (e.g., survival), predictive flow and resulting flow-specific dam survival modeling, and other empirical data in freshwater and marine environments to simulate consecutive generations of Atlantic salmon in the Penobscot River (Maine, USA) under varying environmental conditions or management decisions. As the largest remaining population of this critically endangered species in the USA, the population is intensively managed. Management decisions include fish passage rates at dams, fishery harvest rates, and numbers and locations for hatchery stocking of fish [@nieland:2013]. Since development, it has been used for mechanistic exploration of key life-history uncertainties within the context of species recovery [@nieland:2015] and to support decision-making at federally regulated hydropower dams on the Penobscot River [e.g., @noaa:2013; @nieland:2020].

We created `dia` for use by fisheries researchers, managers, and practitioners interested in understanding population dynamics of intensively managed endangered Atlantic salmon in the USA. The R package maintains the core routines from the original closed-source version of the model by replicating spreadsheet-based calculations, and incorporates original data and parameter sets as built-in objects that serve as default values for arguments of the primary user-facing functions. However, it also allows exploration of uncertainty associated with life-history parameters and investigation of future restoration scenarios through a variety of user-facing options.

The two primary user-facing functions within the `dia` package are `run_dia()` and `run_dia_shiny()`, which provide redundant interfaces for using Dam Impact Analysis (DIA) models in different ways. The `run_dia()` function provides an extensible interface to DIA. It can be used for long-run simulation or decision-optimization studies. It allows incorporation of user-specified data sets such as flow-correlated survival probabilities at dams and in free-flowing river reaches, marine survival and other life-history inputs, or fish-stocking data. The `run_dia_shiny()` function deploys a graphical user interface using the `shiny` package [@shiny] that is less extensible but more easily used by fishery managers and practitioners who may be less familiar with programming and it also includes exportable results from simulation models including `.csv` or other flat-file formats and default plots through the `ggplot2` R package [@ggplot2; @tidyverse; Figure 1]. Both can be deployed on networked servers as other R or `shiny` applications to improve accessibility or facilitate use on high performance computers for large simulations. The GitHub repository [@dia] includes additional instructions for installation and a variety of potential uses of `run_dia()` and `run_dia_shiny()`, with shorter examples included in the package help files. While implementation is currently limited to the Penobscot River as a priority conservation water in the USA, the package serves as one example to help generalize these modeling approaches to Atlantic salmon and other sea-run fish in watersheds globally. Specifically, while many of the built-in datasets and helper functions in `dia` are generalized or could be used to simulate life-history information for other systems and species, generalizing the geographic component (i.e., structural river system) represents an important priority for future development.

![Example graphical outputs using the default argument values [@nieland:2020] for `run_dia()` to run 10,000 simulations, showing (a) the number of two-sea-winter adult females of hatchery or wild origin returning to the watershed during each generation to spawn, and (b) the number of those fish returning to each production unit within the watershed after 15 generations.](Figure1.jpg)

# Acknowledgements
We acknowledge contributions from Rory Saunders, Tara Trinko-Lake, Jeffrey Murphy, and Justin Stevens in the original development of the NOAA Dam Impact Analysis model. This work was funded by the NOAA National Marine Fisheries Service Northeast Fisheries Science Center (award number NMFS-NEFSC-199 MOU), with additional support from the SUNY Oneonta Biological Field Station. We thank the reviewers for helpful guidance and comments that greatly improved the quality of this paper and the open-source software package. Any use of trade, firm, or product names is for descriptive purposes only and does not imply endorsement by the U.S. Government.

# References
